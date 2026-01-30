function backlight -d "Adjust backlight from 0-100"
    argparse -N 1 -X 1 -- $argv
    set val $argv[1]
    if not string match --quiet --regex "\b(\d|[1-9]\d|100)\b" $val
        echo "Invalid value $val. Must be a number from 0-100"
        return
    end
    set max (cat /sys/class/backlight/intel_backlight/max_brightness)
    set newVal (math "floor (($val / 100) * $max)")
    echo $newVal >/sys/class/backlight/intel_backlight/brightness
end
