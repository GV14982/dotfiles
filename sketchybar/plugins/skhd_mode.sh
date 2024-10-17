if [ "$SENDER" = "skhd_mode_changed" ]; then
  sketchybar --set $NAME label="$MODE"
fi
