#!/bin/bash
#
# (Re)start the Notes API server in the background, logging to
# notes-server.log. Stops an already running instance first. Run with the
# project's virtualenv activated; BASE_URL and NOTES_DB_PATH are passed
# through from the environment.

set -euo pipefail

readonly HOST='0.0.0.0'
readonly PORT='8080'
readonly LOG_FILE='notes-server.log'
readonly STOP_TIMEOUT_SECONDS=10
readonly START_TIMEOUT_SECONDS=15

# Matches servers started by this script (old foreground version included),
# but not other uvicorn apps or instances on other ports.
readonly SERVER_PATTERN="uvicorn notes_server:app --host ${HOST} --port ${PORT}$"

#######################################
# Stop running server instances: SIGTERM, then SIGKILL after a timeout.
# Globals:
#   SERVER_PATTERN, STOP_TIMEOUT_SECONDS
#######################################
stop_server() {
  local pids
  pids="$(pgrep -f "${SERVER_PATTERN}" || true)"
  [[ -z "${pids}" ]] && return 0

  echo "Stopping running server (PID ${pids//$'\n'/ })"
  # shellcheck disable=SC2086  # word splitting wanted: one arg per PID
  kill ${pids} 2>/dev/null || true
  local waited=0
  while pgrep -f "${SERVER_PATTERN}" >/dev/null; do
    if (( waited >= STOP_TIMEOUT_SECONDS )); then
      echo "Still running after ${STOP_TIMEOUT_SECONDS}s, sending SIGKILL" >&2
      pkill -KILL -f "${SERVER_PATTERN}" || true
      break
    fi
    sleep 1
    waited=$(( waited + 1 ))
  done
}

#######################################
# Wait until uvicorn reports it is listening, or fail if it exits first.
# Globals:
#   LOG_FILE, START_TIMEOUT_SECONDS
# Arguments:
#   Server PID; log size in bytes before this start.
# Returns:
#   0 once listening, 1 if the server exited or timed out.
#######################################
wait_until_listening() {
  local pid="$1"
  local offset="$2"
  local waited=0
  while (( waited < START_TIMEOUT_SECONDS * 4 )); do
    # Only look at output from this start, not earlier runs.
    if tail -c "+$(( offset + 1 ))" "${LOG_FILE}" \
      | grep -q 'Uvicorn running on'; then
      return 0
    fi
    kill -0 "${pid}" 2>/dev/null || return 1
    sleep 0.25
    waited=$(( waited + 1 ))
  done
  return 1
}

main() {
  # Run from the project dir so uvicorn can import notes_server.
  cd "$(dirname "$(readlink -f "$0")")"
  stop_server

  echo "=== $(date '+%Y-%m-%d %H:%M:%S') starting on ${HOST}:${PORT}" \
    >> "${LOG_FILE}"
  local offset
  offset="$(stat -c %s "${LOG_FILE}")"
  nohup python -m uvicorn notes_server:app --host "${HOST}" --port "${PORT}" \
    >> "${LOG_FILE}" 2>&1 < /dev/null &
  local pid=$!

  if ! wait_until_listening "${pid}" "${offset}"; then
    kill "${pid}" 2>/dev/null || true
    echo "Server failed to start; log since this start:" >&2
    tail -c "+$(( offset + 1 ))" "${LOG_FILE}" | tail -n 20 >&2
    exit 1
  fi
  echo "Server running (PID ${pid}), logging to ${PWD}/${LOG_FILE}"
}

main "$@"
