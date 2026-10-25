#!/bin/bash
# Claude usage: 5-hour session and weekly, as percent used
export PATH="/opt/homebrew/bin:$PATH" # quota-axi is a node script; sketchybar runs with a minimal PATH
JSON=$(/opt/homebrew/bin/quota-axi --provider claude --json --max-age 60s 2>/dev/null)
read -r S W <<<"$(echo "$JSON" | /opt/homebrew/bin/jq -r '
  .providers[0].windows as $w
  | [($w[] | select(.id=="five_hour") | 100 - .percentRemaining),
     ($w[] | select(.kind=="weekly")  | 100 - .percentRemaining)]
  | map(floor) | @tsv')"
if [ -z "$S" ]; then
  sketchybar --set "$NAME" label="--"
  exit 0
fi
sketchybar --set "$NAME" label="${S}% · ${W}%"
