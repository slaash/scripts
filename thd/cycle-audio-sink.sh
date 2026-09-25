#!/usr/bin/env bash
set -euo pipefail

export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# One entry per sink+port (matches what the GNOME sound settings dropdown shows,
# e.g. Speaker/Headphones are two ports on the same sink), skipping ports
# marked "not available" (disconnected HDMI/DP outputs etc.)
mapfile -t entries < <(pactl list sinks | awk '
function reset(){ name=""; id=""; desc=""; portcount=0 }
/^\tName: / { name=$2 }
/^\tDescription: / { desc=substr($0, index($0,": ")+2) }
/object\.id = / { gsub(/"/,"",$3); id=$3 }
/^\t\t[^\t]+: .*\(.*\)$/ {
    line=$0
    avail = (line !~ /not available/)
    portkey=line; sub(/^\t\t/,"",portkey); sub(/:.*/,"",portkey)
    label=line; sub(/^\t\t[^:]+: /,"",label); sub(/ \(.*/,"",label)
    if (avail) print name "|" id "|" portkey "|" label
    portcount++
}
/^Sink #/ { if (name!="" && portcount==0) print name "|" id "||" desc; reset() }
END { if (name!="" && portcount==0) print name "|" id "||" desc }
')

names=()
ids=()
ports=()
labels=()
for e in "${entries[@]}"; do
  IFS='|' read -r n i p l <<< "$e"
  names+=("$n")
  ids+=("$i")
  ports+=("$p")
  labels+=("$l")
done

current_name=$(pactl get-default-sink)
current_port=$(pactl list sinks | awk -v n="$current_name" '
/^\tName: / { ismatch=($2==n) }
/^\tActive Port: / { if (ismatch) { sub(/^\tActive Port: /,""); print; exit } }
')

next_idx=0
for i in "${!names[@]}"; do
  if [[ "${names[$i]}" == "$current_name" && "${ports[$i]}" == "$current_port" ]]; then
    next_idx=$(( (i + 1) % ${#names[@]} ))
    break
  fi
done

new_id="${ids[$next_idx]}"
new_name="${names[$next_idx]}"
new_port="${ports[$next_idx]}"
new_label="${labels[$next_idx]}"

if [[ -n "$new_port" ]]; then
  pactl set-sink-port "$new_name" "$new_port"
fi
wpctl set-default "$new_id"

# belt-and-braces: move any already-playing streams too
for input in $(pactl list short sink-inputs | cut -f1); do
  pactl move-sink-input "$input" "$new_name"
done

notify-send "Audio output" "$new_label"
