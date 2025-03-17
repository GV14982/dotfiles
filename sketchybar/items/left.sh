#! /bin/bash

setup_left() {
  sketchybar --add event aerospace_workspace_changed

  source ./items/left/spaces.sh
  setup_spaces
  ##### Adding Left Items #####
  # We add some regular items to the left side of the bar
  # only the properties deviating from the current defaults need to be set

  sketchybar --add item front_app.left left \
    --set front_app.left script="$PLUGIN_DIR/front_app.sh" \
    icon= \
    --subscribe front_app.left front_app_switched

  sketchybar --add bracket lhs '/.*\.left/' \
    --set lhs background.color="0xff$BASE" \
    background.corner_radius=12 \
    background.height=24
}
