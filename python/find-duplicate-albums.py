import sys, re
from collections import defaultdict

lines = [l.strip() for l in sys.stdin if l.strip()]

def get_artist(name):
    # Strip leading year/number prefixes
    n = re.sub(r'^\d{4}[\.\s-]+', '', name)
    n = re.sub(r'^\[.*?\]\s*', '', n)
    if ' - ' in n:
        return n.split(' - ')[0].strip()
    return None

def normalize_artist(a):
    if not a: return None
    a = a.lower()
    a = re.sub(r'\[.*?\]', '', a)
    a = re.sub(r'\(.*?\)', '', a)
    a = re.sub(r'\{.*?\}', '', a)
    a = re.sub(r'[^a-z0-9\s]', ' ', a)
    a = re.sub(r'\s+', ' ', a).strip()
    return a

# Group all entries by artist
artist_entries = defaultdict(list)
for name in lines:
    artist = get_artist(name)
    norm = normalize_artist(artist)
    if norm and len(norm) > 2:
        artist_entries[norm].append(name)

# Find artists with discographies AND individual albums
print('=' * 80)
print('ARTISTS WITH DISCOGRAPHY + INDIVIDUAL ALBUMS (potential overlap):')
print('=' * 80)
for artist, entries in sorted(artist_entries.items()):
    if len(entries) < 2:
        continue
    has_disco = any(re.search(
        r'discograph|complete|collection|studio albums|classic albums|original albums|box.?set|essential',
        e, re.I) for e in entries)
    has_individual = any(not re.search(
        r'discograph|complete|collection|studio albums|classic albums|original albums|box.?set|essential',
        e, re.I) for e in entries)
    if has_disco and has_individual:
        print(f'\n🎵 {artist.title()}:')
        for e in entries:
            tag = '📦 COLLECTION' if re.search(
                r'discograph|complete|collection|studio albums|classic albums|original albums|box.?set|essential',
                e, re.I) else '   single album'
            print(f'  {tag}  {e}')

print()
print('=' * 80)
print('ARTISTS WITH MULTIPLE ENTRIES (>2, review for overlap):')
print('=' * 80)
for artist, entries in sorted(artist_entries.items()):
    if len(entries) > 2:
        has_disco = any(re.search(
            r'discograph|complete|collection|studio albums|classic albums|original albums|box.?set|essential',
            e, re.I) for e in entries)
        if not has_disco:
            print(f'\n🎵 {artist.title()} ({len(entries)} entries):')
            for e in entries:
                print(f'  → {e}')

print()
print('=' * 80)
print('SAME ALBUM, DIFFERENT FORMAT/QUALITY (likely true duplicates):')
print('=' * 80)
# More aggressive album matching
album_groups = defaultdict(list)
for name in lines:
    n = name.lower()
    n = re.sub(r'^\d{4}[\.\s-]+', '', n)
    n = re.sub(r'\[.*?\]', '', n)
    n = re.sub(r'\(.*?\)', '', n)
    n = re.sub(r'\{.*?\}', '', n)
    # remove quality/format tags
    for tag in ['flac','mp3','aac','wav','ape','dff','sacd','web','cd','lp','24 bit','hi res',
                'pbthal','pmedia','vtwin88cube','eac','remaster','deluxe','edition','anniversary',
                'expanded','proper','lossless','repack','som','kinda','mag','jamal the moroccan',
                'songs','h33t','rogercc','oan','kitlope','filelist','som','entitled','nbflac',
                'wre','fray','lokotorrents com']:
        n = re.sub(r'\b' + tag + r'\b', '', n)
    n = re.sub(r'\b\d{4}\b', '', n)
    n = re.sub(r'\b\d+\s*bit\b', '', n)
    n = re.sub(r'\b\d+-\d+\b', '', n)
    n = re.sub(r'[^a-z0-9\s]', ' ', n)
    n = re.sub(r'\s+', ' ', n).strip()
    if len(n) > 5:
        album_groups[n].append(name)

for key, names in sorted(album_groups.items()):
    if len(names) > 1:
        # Check they're not just disc 1/disc 2
        if not all('disc' in n.lower() for n in names):
            print(f'\n"{key}":')
            for n in names:
                print(f'  → {n}')
