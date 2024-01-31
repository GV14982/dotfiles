setup_spaces() {
	##### Adding Mission Control Space Indicators #####
	# Now we add some mission control spaces:
	# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
	# to indicate active and available mission control spaces

	SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
	SPACE_COLORS=(
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
	RANDOM=$$$(date +%s)
	for i in "${!SPACE_ICONS[@]}"
	do
		INDEX=$[$(($RANDOM + $i)) % ${#SPACE_COLORS[@]}]
		COLOR=$(echo ${SPACE_COLORS[$INDEX]} | sed 's/,//g')
		echo "$COLOR-$INDEX-$i"
		sid=$(($i+1))
		name="space.$sid.left"
		left_pad=0
		if [[ i -eq 0 ]]; then
			left_pad=9
		fi
		sketchybar --add space $name left                                 \
			--set $name space=$sid                                 \
			icon=${SPACE_ICONS[i]}                     \
			icon.color=0xff$COLOR			   \
			label.drawing=off                          \
			background.height=24 \
			background.color="0xff$CRUST" \
			padding_left=$left_pad \
			script="$PLUGIN_DIR/space.sh"              \
			click_script="yabai -m space --focus $sid"
	done
}
