#! /bin/bash

setup_left() {
	source ./items/left/spaces.sh
	setup_spaces
	##### Adding Left Items #####
	# We add some regular items to the left side of the bar
	# only the properties deviating from the current defaults need to be set

	sketchybar --add item front_app.left left                               \
		   --set front_app.left script="$PLUGIN_DIR/front_app.sh" \
		   icon= \
		   --subscribe front_app.left front_app_switched

	sketchybar --add event skhd_mode_changed

	sketchybar --add item skhd_mode.left left \
		   --set skhd_mode.left script="$PLUGIN_DIR/skhd_mode.sh" \
		   icon= \
		   label=normal \
		   icon.padding_right=0 \
		   background.padding_right=6 \
		   --subscribe skhd_mode.left skhd_mode_changed

	sketchybar --add bracket lhs '/.*\.left/' \
		--set lhs background.color="0xff$BASE" \
			background.corner_radius=12 \
			background.height=24
}
