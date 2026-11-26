#!/bin/sh
#
# Build the notes-api FreeBSD package. Run on a FreeBSD host that has pkg(8)
# and the dependency packages installed (python312, py312-fastapi,
# py312-uvicorn); the repo tree (notes_server.py, index.html, deploy/) must be
# present on that host.
#
# Usage: build-pkg.sh [version]     (default version: YYYYMMDD)
# Output: out/notes-api-<version>.pkg next to this script

set -eu

HERE="$(cd "$(dirname "$0")" && pwd)"
readonly HERE
readonly REPO="${HERE}/../.."
readonly SHARE="usr/local/share/notes-api"

work=""

die() {
  echo "build-pkg: $*" >&2
  exit 1
}

cleanup() {
  if [ -n "${work}" ]; then
    rm -rf "${work}"
  fi
}

# Version of an installed package, for the dependency lines.
pkg_version() {
  pkg query '%v' "$1" || die "package $1 is not installed"
}

main() {
  local version="${1:-$(date +%Y%m%d)}"
  local f
  for f in "${REPO}/notes_server.py" "${REPO}/index.html" \
    "${HERE}/vendor/tinydb/__init__.py"; do
    [ -f "${f}" ] || die "missing ${f}"
  done

  work="$(mktemp -d)"
  trap cleanup EXIT
  local stage="${work}/stage"
  local meta="${work}/meta"
  mkdir -p "${stage}/${SHARE}" "${stage}/usr/local/etc/rc.d" \
    "${stage}/usr/local/sbin" "${stage}/usr/local/etc/newsyslog.conf.d" \
    "${meta}"

  # Application files.
  cp "${REPO}/notes_server.py" "${REPO}/index.html" "${stage}/${SHARE}/"
  cp -R "${HERE}/vendor/tinydb" "${stage}/${SHARE}/tinydb"
  cp "${HERE}/vendor/LICENSE.tinydb" "${stage}/${SHARE}/LICENSE.tinydb"
  find "${stage}/${SHARE}" -name __pycache__ -type d -prune \
    -exec rm -rf {} +
  find "${stage}/${SHARE}" -type d -exec chmod 0755 {} +
  find "${stage}/${SHARE}" -type f -exec chmod 0644 {} +

  # System integration files.
  install -m 0555 "${HERE}/rc.d-notes_api" \
    "${stage}/usr/local/etc/rc.d/notes_api"
  install -m 0555 "${HERE}/notes-cert" "${stage}/usr/local/sbin/notes-cert"
  install -m 0644 "${HERE}/newsyslog-notes-api.conf" \
    "${stage}/usr/local/etc/newsyslog.conf.d/notes-api.conf"

  # Packing list: share tree first (0644), then the executables and config.
  {
    echo "@owner root"
    echo "@group wheel"
    echo "@mode 0644"
    (cd "${stage}" && find "${SHARE}" -type f | sort | sed 's|^|/|')
    echo "/usr/local/etc/newsyslog.conf.d/notes-api.conf"
    echo "@mode 0555"
    echo "/usr/local/etc/rc.d/notes_api"
    echo "/usr/local/sbin/notes-cert"
  } > "${work}/plist"

  # Metadata: the manifest gets the installed dependency versions.
  sed -e "s|@VERSION@|${version}|" \
    -e "s|@PY_VER@|$(pkg_version python312)|" \
    -e "s|@FASTAPI_VER@|$(pkg_version py312-fastapi)|" \
    -e "s|@UVICORN_VER@|$(pkg_version py312-uvicorn)|" \
    "${HERE}/pkg/+MANIFEST" > "${meta}/+MANIFEST"
  cp "${HERE}/pkg/+PRE_INSTALL" "${HERE}/pkg/+POST_INSTALL" \
    "${HERE}/pkg/+DISPLAY" "${meta}/"

  mkdir -p "${HERE}/out"
  pkg create -r "${stage}" -m "${meta}" -p "${work}/plist" -o "${HERE}/out"
  echo "Built ${HERE}/out/notes-api-${version}.pkg"
  pkg info -l -F "${HERE}/out/notes-api-${version}.pkg"
}

main "$@"
