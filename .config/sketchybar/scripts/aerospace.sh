#!/bin/sh

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icon_map_fn.sh"

#echo \$FOCUSED_WORKSPACE: $FOCUSED_WORKSPACE, \$NAME: $NAME \$1: $1 >> ~/aaaa

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
                         background.color=$ORANGE \
                         background.corner_radius=8 \
                         label.color=0xff000000 \
                         icon.color=0xff000000
else
  sketchybar --set $NAME background.drawing=off \
                         label.color=$ORANGE \
                         icon.color=$ORANGE
fi

# Load all icons on startup
for sid in $(aerospace list-workspaces --all); do
  apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  sketchybar --set space.$sid drawing=on

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app; do
      icon=$(icon_map "$app")
      icon_strip+="$icon "
    done <<<"${apps}"
  else
    icon_strip=" — "
  fi
  sketchybar --animate sin 10 --set space.$sid label="$icon_strip"
done
