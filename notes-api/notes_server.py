"""
TinyDB + FastAPI Notes API
--------------------------
Each note: { id, timestamp, text, encrypted, tags, url }

Install deps:
    pip install -r requirements.txt

Run:
    ./start.sh
    (set BASE_URL to the public origin used in shareable links, and
    NOTES_DB_PATH to the database file; defaults to ./notes.json next to
    this file)

Docs: http://localhost:8080/docs
"""

import json
import operator
import os
import re
import tempfile
import threading
from datetime import datetime, timezone
from functools import reduce
from html import escape
from pathlib import Path
from typing import Any

from fastapi import FastAPI, HTTPException, Query as QueryParam
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse, HTMLResponse
from pydantic import BaseModel, Field, field_validator
from tinydb import TinyDB, Query
from tinydb.storages import Storage
from tinydb.table import Document

app = FastAPI(title="Notes API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],   # restrict to your domain in production
    allow_methods=["*"],
    allow_headers=["*"],
)


class AtomicJSONStorage(Storage):
    """TinyDB JSON storage that never leaves a half-written file.

    The stock JSONStorage overwrites the file in place and then truncates it,
    so a crash mid-write corrupts it. Here each write goes to a temp file in
    the same directory, is fsynced, and atomically replaces the original.
    The file is reopened on every read: a handle kept open (as JSONStorage
    does) would still point at the replaced file and return stale data.
    """

    def __init__(self, path: Path) -> None:
        # Resolve symlinks so the swap replaces the target, not the link.
        self.path = Path(path).resolve()
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.path.touch(exist_ok=True)
        # Temp files left by a crash mid-write; the real file is intact.
        for stale in self.path.parent.glob(f".{self.path.name}.*.tmp"):
            stale.unlink(missing_ok=True)

    def read(self) -> dict[str, dict[str, Any]] | None:
        """Load the whole database, or None if the file is missing or empty."""
        try:
            text = self.path.read_text(encoding="utf-8")
        except FileNotFoundError:
            return None
        return json.loads(text) if text else None

    def write(self, data: dict[str, dict[str, Any]]) -> None:
        """Atomically replace the database file with ``data``."""
        fd, tmp = tempfile.mkstemp(
            dir=self.path.parent, prefix=f".{self.path.name}.", suffix=".tmp"
        )
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as f:
                json.dump(data, f)
                f.flush()
                os.fsync(f.fileno())
            # mkstemp creates the file 0600; keep the original's permissions.
            if self.path.exists():
                os.chmod(tmp, self.path.stat().st_mode & 0o777)
            os.replace(tmp, self.path)
        finally:
            # Only still present if something failed before the replace.
            Path(tmp).unlink(missing_ok=True)
        # Persist the rename itself, not just the file contents.
        dir_fd = os.open(self.path.parent, os.O_RDONLY)
        try:
            os.fsync(dir_fd)
        finally:
            os.close(dir_fd)


DB_PATH = Path(
    os.getenv("NOTES_DB_PATH", Path(__file__).resolve().parent / "notes.json")
)
db = TinyDB(DB_PATH, storage=AtomicJSONStorage)
# FastAPI runs sync handlers in a threadpool, and TinyDB is not
# thread-safe: every access (reads too, since a write rewrites the whole
# file) goes through this lock. It only guards one process, so run a
# single uvicorn worker.
DB_LOCK = threading.Lock()
NOTE_QUERY = Query()
# Holds a single document (doc_id 1) with the highest note ID ever issued.
META = db.table("meta")

# Public origin used to build shareable links; set to wherever clients reach
# the server (e.g. "https://notes.example.com").
BASE_URL = os.getenv("BASE_URL", "http://localhost:8080").rstrip("/")

# A tag is one lowercase word: no whitespace, commas or "#" (the UI uses
# those as separators and as the search prefix).
TAG_PATTERN = re.compile(r"[^\s,#]{1,40}")
MAX_TAGS = 20
MAX_BULK_DELETE = 500


def normalize_tag(tag: str) -> str:
    """Lowercase and validate one tag, raising ValueError if it is invalid."""
    tag = tag.strip().lower()
    if not TAG_PATTERN.fullmatch(tag):
        raise ValueError(
            f"invalid tag {tag!r}: 1-40 characters, no spaces, commas or #"
        )
    return tag


class NoteIn(BaseModel):
    """Request body for creating or editing a note.

    When ``encrypted`` is true, ``text`` is an opaque envelope produced by the
    client; the server never sees the plaintext or the passphrase.
    """

    text: str
    encrypted: bool = False
    # Tags are always stored in plain text, even on encrypted notes, so the
    # server can search them.
    tags: list[str] = Field(default_factory=list, max_length=MAX_TAGS)

    @field_validator("tags")
    @classmethod
    def clean_tags(cls, tags: list[str]) -> list[str]:
        """Normalize tags and drop duplicates, keeping the given order."""
        return list(dict.fromkeys(normalize_tag(t) for t in tags))


class NoteOut(BaseModel):
    """A note as returned by the API."""

    id: int
    timestamp: str
    text: str
    encrypted: bool
    tags: list[str]
    url: str


class DeleteIn(BaseModel):
    """Request body for deleting several notes at once."""

    ids: list[int] = Field(min_length=1, max_length=MAX_BULK_DELETE)


class Page(BaseModel):
    """A paginated list of notes."""

    total: int
    limit: int
    offset: int
    items: list[NoteOut]


def note_url(note_id: int) -> str:
    """Build the shareable HTML link for a note."""
    return f"{BASE_URL}/n/{note_id}"


def to_out(doc: Document) -> dict[str, Any]:
    """Convert a stored TinyDB document into the API response shape."""
    return {
        "id": doc.doc_id,
        "timestamp": doc["timestamp"],
        "text": doc["text"],
        "encrypted": doc.get("encrypted", False),
        "tags": doc.get("tags", []),
        "url": note_url(doc.doc_id),
    }


def next_note_id() -> int:
    """Return a note ID that was never used, not even by a deleted note.

    TinyDB's own counter is max(existing ID) + 1, so deleting the newest note
    and restarting would hand its ID (and its old share links) to the next
    note. Call with DB_LOCK held.
    """
    meta = META.get(doc_id=1)
    last_issued = meta["last_id"] if meta else 0
    return max([last_issued, *(d.doc_id for d in db.all())]) + 1


@app.get("/notes", response_model=Page)
def list_notes(
    limit: int = QueryParam(20, ge=1, le=200),
    offset: int = QueryParam(0, ge=0),
) -> dict[str, Any]:
    """List notes, newest first, paginated."""
    with DB_LOCK:
        all_docs = db.all()
    all_docs.sort(key=lambda d: d["timestamp"], reverse=True)  # newest first
    page = all_docs[offset: offset + limit]
    return {
        "total": len(all_docs),
        "limit": limit,
        "offset": offset,
        "items": [to_out(d) for d in page],
    }


# Must be declared before /notes/{note_id}, otherwise FastAPI would try to
# parse "search" as a note_id and fail with a 422 error.
@app.get("/notes/search", response_model=Page)
def search_notes(
    q: str = "",
    tag: list[str] = QueryParam(default_factory=list),
    limit: int = QueryParam(20, ge=1, le=200),
    offset: int = QueryParam(0, ge=0),
) -> dict[str, Any]:
    """Search notes by text and/or tags, newest first.

    ``q`` is a case-insensitive substring match on the text; encrypted notes
    never match it, as their stored text is ciphertext. Each ``tag`` (repeat
    the parameter for several) must be present on the note; tags are plain
    text, so tag-only searches include encrypted notes.
    """
    try:
        tags = [normalize_tag(t) for t in tag]
    except ValueError as err:
        raise HTTPException(status_code=422, detail=str(err)) from err
    conditions = []
    if q:
        needle = q.lower()
        conditions += [
            ~NOTE_QUERY.encrypted.test(bool),
            NOTE_QUERY.text.test(lambda t: needle in t.lower()),
        ]
    if tags:
        conditions.append(NOTE_QUERY.tags.all(tags))
    if not conditions:
        raise HTTPException(status_code=422, detail="Give q and/or tag")
    with DB_LOCK:
        matches = db.search(reduce(operator.and_, conditions))
    matches.sort(key=lambda d: d["timestamp"], reverse=True)
    page = matches[offset: offset + limit]
    return {
        "total": len(matches),
        "limit": limit,
        "offset": offset,
        "items": [to_out(d) for d in page],
    }


@app.get("/notes/{note_id}", response_model=NoteOut)
def get_note(note_id: int) -> dict[str, Any]:
    """Get a single note by ID."""
    with DB_LOCK:
        doc = db.get(doc_id=note_id)
    if doc is None:
        raise HTTPException(status_code=404, detail="Note not found")
    return to_out(doc)


@app.post("/notes", response_model=NoteOut, status_code=201)
def add_note(note: NoteIn) -> dict[str, Any]:
    """Create a note, timestamped now (UTC)."""
    record = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "text": note.text,
        "encrypted": note.encrypted,
        "tags": note.tags,
    }
    with DB_LOCK:
        doc_id = next_note_id()
        db.insert(Document(record, doc_id=doc_id))
        # Written after the note: if we crash in between, next_note_id()
        # still sees the note itself, so the ID can't be issued twice.
        META.upsert(Document({"last_id": doc_id}, doc_id=1))
    return {"id": doc_id, "url": note_url(doc_id), **record}


@app.put("/notes/{note_id}", response_model=NoteOut)
def update_note(note_id: int, note: NoteIn) -> dict[str, Any]:
    """Replace a note's text and tags, keeping its creation timestamp."""
    with DB_LOCK:
        existing = db.get(doc_id=note_id)
        if existing is None:
            raise HTTPException(status_code=404, detail="Note not found")
        updated = {
            "timestamp": existing["timestamp"],  # keep creation time
            "text": note.text,
            "encrypted": note.encrypted,
            "tags": note.tags,
        }
        db.update(updated, doc_ids=[note_id])
    return {"id": note_id, "url": note_url(note_id), **updated}


@app.delete("/notes/{note_id}", status_code=204)
def delete_note(note_id: int) -> None:
    """Delete a note by ID."""
    with DB_LOCK:
        if db.get(doc_id=note_id) is None:
            raise HTTPException(status_code=404, detail="Note not found")
        db.remove(doc_ids=[note_id])


# Not under DELETE /notes/{note_id}: a body on DELETE is poorly supported by
# proxies and clients, so the bulk version is a POST.
@app.post("/notes/delete")
def delete_notes(body: DeleteIn) -> dict[str, list[int]]:
    """Delete several notes in a single write.

    IDs that don't exist (e.g. already deleted) are skipped rather than
    failing the whole request; the response lists what was deleted.
    """
    with DB_LOCK:
        deleted = [i for i in dict.fromkeys(body.ids) if db.contains(doc_id=i)]
        if deleted:
            db.remove(doc_ids=deleted)
    return {"deleted": deleted}


@app.get("/", include_in_schema=False)
def index() -> FileResponse:
    """Serve the web UI."""
    return FileResponse(Path(__file__).resolve().with_name("index.html"))


@app.get("/n/{note_id}", response_class=HTMLResponse)
def view_note(note_id: int) -> HTMLResponse:
    """Render a note as a standalone HTML page (the shareable link)."""
    with DB_LOCK:
        doc = db.get(doc_id=note_id)
    if doc is None:
        return HTMLResponse("<h1>Note not found</h1>", status_code=404)

    if doc.get("encrypted", False):
        text = "This note is encrypted. Open it in the notes app to read it."
    else:
        text = escape(doc["text"])
    timestamp = escape(doc["timestamp"])

    return HTMLResponse(f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Note #{note_id}</title>
      <style>
        body {{ font-family: sans-serif; max-width: 600px; margin: 60px auto; color: #222; }}
        .meta {{ color: #888; font-size: 0.85em; margin-bottom: 20px; }}
        .text {{ white-space: pre-wrap; line-height: 1.5; font-size: 1.1em; }}
      </style>
    </head>
    <body>
      <div class="meta">Note #{note_id} &middot; {timestamp}</div>
      <div class="text">{text}</div>
    </body>
    </html>
    """)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8080)
