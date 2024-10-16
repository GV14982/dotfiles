setup_right() {
	##### Adding Right Items #####
	# In the same way as the left items we can add items to the right side.
	# Additional position (e.g. center) are available, see:
	# https://felixkratz.github.io/SketchyBar/config/items#adding-items-to-sketchybar

	# Some items refresh on a fixed cycle, e.g. the clock runs its script once
	# every 10s. Other items respond to events they subscribe to, e.g. the
	# volume.sh script is only executed once an actual change in system audio
	# volume is registered. More info about the event system can be found here:
	# https://felixkratz.github.io/SketchyBar/config/events

	sketchybar --add item clock.right right \
		--set clock.right update_freq=30 \
		icon= \
		script="$PLUGIN_DIR/clock.sh" \
		padding_right=6 \
		icon.padding_right=1 \
		\
		--add item seperator.1.right right \
		--set seperator.1.right icon= icon.drawing=true label.drawing=false \
		\
		--add item volume.right right \
		--set volume.right script="$PLUGIN_DIR/volume.sh" \
		icon.padding_right=1 \
		--subscribe volume.right volume_change \
		\
		--add item seperator.2.right right \
		--set seperator.2.right icon= icon.drawing=true label.drawing=false \
		\
		--add item battery.right right \
		--set battery.right script="$PLUGIN_DIR/battery.sh" \
		update_freq=120 \
		icon.padding_right=1 \
		padding_left=6 \
		--subscribe battery.right system_woke power_source_change

	sketchybar --add bracket rhs '/.*\.right/' \
		--set rhs background.color="0xff$BASE" \
		background.corner_radius=12 \
		background.height=24
}
