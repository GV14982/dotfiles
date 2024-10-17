update_bg() {
  if [[ "$NAME" == "space.$FOCUSED.left" ]]; then
    sketchybar --set $NAME background.drawing=on
  else
    sketchybar --set $NAME background.drawing=off
  fi
}

if [ "$SENDER" = "forced" ]; then
  FOCUSED=$(aerospace list-workspaces --focused)
  update_bg
elif [ "$SENDER" = "aerospace_workspace_changed" ]; then
  update_bg
elif [ "$SENDER" = "routine" ]; then
  WORKSPACE=$(echo $NAME | cut -d'.' -f2)
  WINDOW_COUNT=$(aerospace list-windows --workspace $WORKSPACE --format "%{workspace}" | jq -rs 'length')
  ICON="_"
  if [[ WINDOW_COUNT -gt 0 ]]; then
    ICON=$WORKSPACE
  fi
  sketchybar --set $NAME icon=$ICON
fi
