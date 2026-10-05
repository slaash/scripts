#!/bin/bash
#
# Start the Notes API server. Run with the project's virtualenv activated.

set -euo pipefail

readonly HOST='0.0.0.0'
readonly PORT='8080'

main() {
  # Run from the project dir so uvicorn can import notes_server.
  cd "$(dirname "$(readlink -f "$0")")"
  exec python -m uvicorn notes_server:app --host "${HOST}" --port "${PORT}"
}

main "$@"
