PATH="$PATH:/opt/homebrew/bin"
setup_spaces() {
	##### Adding Mission Control Space Indicators #####
	# Now we add some mission control spaces:
	# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
	# to indicate active and available mission control spaces

	all_spaces=($(aerospace list-workspaces --all | jq -rs "sort | @sh"))
	space_colors=(
		$ROSEWATER,
		$FLAMINGO,
		$PINK,
		$MAUVE,
		$RED,
		$MAROON,
		$PEACH,
		$YELLOW,
		$GREEN,
		$TEAL,
		$SKY,
		$SAPPHIRE,
		$BLUE,
		$LAVENDER
	)
	random=$$$(date +%s)
	focused_space=$(aerospace list-workspaces --focused)
	for i in "${!all_spaces[@]}"; do
		rand_idx=$(($(($random + $i)) % ${#space_colors[@]}))
		color=$(echo ${space_colors[$rand_idx]} | sed 's/,//g')
		sid=$(($i + 1))
		window_count=$(aerospace list-windows --workspace $sid --format "%{workspace}" | jq -rs "length")
		name="space.$sid.left"
		icon=$sid
		left_pad=0
		active="off"
		if [[ i -eq 0 ]]; then
			left_pad=9
		fi
		if [[ focused_space -eq sid ]]; then
			active="on"
		fi
		if [[ window_count -lt 1 ]]; then
			icon="_"
		fi

		sketchybar --add item $name left \
			--set $name icon=$icon \
			icon.color=0xff$color \
			label.drawing=off \
			background.drawing=$active \
			background.height=24 \
			background.color="0xff$CRUST" \
			padding_left=$left_pad \
			script="$PLUGIN_DIR/space.sh" \
			click_script="aerospace workspace $sid" \
			update_freq=1 \
			--subscribe $name aerospace_workspace_changed
	done
}
