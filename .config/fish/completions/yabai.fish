complete -c yabai -f
complete -c yabai -s 'h' -l 'help' -d 'Print options to stdout and exit' -n '__fish_not_contain_opt -s m message'
complete -c yabai -s 'v' -l 'version' -d 'Print version to stdout and exit' -n '__fish_not_contain_opt -s m message'
complete -c yabai -s 'V' -l 'verbose' -d 'Output debug information to stdout' -n '__fish_not_contain_opt -s m message'
complete -c yabai -s 'c' -l 'config' -d 'Use the specified configuration file' -Fr -n '__fish_not_contain_opt -s m message'
complete -c yabai -l 'stop-service' -d 'Stops a running instance of the service and unloads it' -n '__fish_not_contain_opt -s m message'
complete -c yabai -l 'restart-service' -d 'Attempts to restart the service instance' -n '__fish_not_contain_opt -s m message'
complete -c yabai -l 'start-service' -d 'Enables, loads, and starts the launchd service' -n '__fish_not_contain_opt -s m message'
complete -c yabai -l 'uninstall-service' -d 'Removes a launchd service file from disk' -n '__fish_not_contain_opt -s m message'
complete -c yabai -l 'install-service' -d 'Writes a launchd service file to disk' -n '__fish_not_contain_opt -s m message'
complete -c yabai -l 'uninstall-sa' -d 'Uninstall the scripting-addition. Must be run as root' -n '__fish_not_contain_opt -s m message'
complete -c yabai -l 'install-sa' -d 'Load the scripting addition into Dock.app. Installs and updates the scripting addition when necessary' -n '__fish_not_contain_opt -s m message'

set layer "below " "normal" "above" "auto"
set bool_select "on" "off"
set dir_sel "north" "east" "south" "west"
set stack_sel "stack.prev" "stack.next" "stack.first" "stack.last" "stack.recent"
set window_sel "prev" "next" "first" "last" "recent" "mouse" "largest" "smallest" "sibling" "first_nephew" "second_nephew" "uncle" "first_cousin" "second_cousin"
set layout "bsp" "stack" "float"
set focus_follows_mouse "autofocus" "autoraise" "off"
set window_origin_display "default" "focused" "cursor"
set window_placement "first_child" "second_child"
set split_type "vertical" "horizontal" "auto"
set mouse_modifier "cmd" "alt" "shift" "ctrl" "fn"
set mouse_action "move" "resize"
set mouse_drop_action "swap" "stack"

set -a domain "config\t'Get or set the value of <global setting> or Get or set the value of <space setting> (with --space flag)'"
set -a domain "display\t'Control displays'"
set -a domain "space\t'Control spaces'"
set -a domain "window\t'Control windows'"
set -a domain "query\t'Query yabai state'"
set -a domain "rule\t'Manage rules for what yabai should do with certain applications'"
set -a domain "signal\t'A signal is a simple way for the user to react to some event that has been processed'"

set -a space_settings "layout\t'Set the layout of the selected space'"
set -a space_settings "top_padding\t'Padding added at the upper side of the selected space'"
set -a space_settings "bottom_padding\t'Padding added at the lower side of the selected space'"
set -a space_settings "left_padding\t'Padding added at the left side of the selected space'"
set -a space_settings "right_padding\t'Padding added at the right side of the selected space'"
set -a space_settings "window_gap\t'Size of the gap that separates windows for the selected space'"

set -a global_config "debug_output\t'Enable output of debug information to stdout'"
set -a global_config "external_bar\t'Specify top and bottom padding for a potential custom bar that you may be running. <type:top:bottom>'"
set -a global_config "mouse_follows_focus\t'When focusing a window, put the mouse at its center'"
set -a global_config "focus_follows_mouse\t'Automatically focus the window under the mouse'"
set -a global_config "window_origin_display\t'Specify which display a newly created window should be managed in'"
set -a global_config "window_placement\t'Specify whether managed windows should become the first or second leaf-node'"
set -a global_config "window_zoom_persist\t'Windows will keep their zoom-state through layout changes'"
set -a global_config "window_shadow\t'Draw shadow for windows'"
set -a global_config "window_opacity\t'Enable opacity for windows'"
set -a global_config "window_opacity_duration\t'Duration of transition between active / normal opacity'"
set -a global_config "active_window_opacity\t'Opacity of the focused window'"
set -a global_config "normal_window_opacity\t'Opacity of an unfocused window'"
set -a global_config "window_animation_duration\t'Duration of window frame animation. If 0.0, the change in dimension is not animated'"
set -a global_config "window_animation_frame_rate\t'Frame rate (expressed in frames per second) of window frame animation'"
set -a global_config "insert_feedback_color\t'Color of the window --insert message selection'"
set -a global_config "split_ratio\t'Specify the size distribution when a window is split'"
set -a global_config "split_type\t'Specify how a window should be split'"
set -a global_config "auto_balance\t'Balance the window tree upon change, so that all windows occupy the same area'"
set -a global_config "mouse_modifier\t'Keyboard modifier used for moving and resizing windows'"
set -a global_config "mouse_action1\t'Action performed when pressing mouse_modifier + button1'"
set -a global_config "mouse_action2\t'Action performed when pressing mouse_modifier + button2'"
set -a global_config "mouse_drop_action\t'Action performed when a bsp-managed window is dropped in the center of some other bsp-managed window'"

set -a external_bar "main:0:0\t'Apply the given padding only to spaces located on the main display'"
set -a external_bar "all:0:0\t'Apply the given padding to all spaces regardless of their display'"
set -a external_bar "off:0:0\t'Do not apply any special padding'"

set global_config_bool_select "debug_output" "mouse_follows_focus" "window_zoom_persist" "window_opacity" "auto_balance" ""
set global_config_mouse_action "mouse_action1" "mouse_action2"

set spaces

function __yabai_has_msg
    return ( __fish_contains_opt -s m message )
end

function __yabai_msg_arg
    return ( __yabai_has_msg; and __fish_prev_arg_in -m --message )
end

function __yabai_space_opt
    return ( __yabai_has_msg; and __fish_prev_arg_in config --spaces )
end

function __yabai_space_arg
    return ( __fish_prev_arg_in --space )
end

function __yabai_space_config
    return (  __fish_contains_opt -s m message; and __fish_seen_argument -l spaces config; and __fish_contains_opt space )
end

function __yabai_space_config_arg
    __yabai_get_space_idx
    return ( __yabai_space_config; and __fish_prev_arg_in (string split " " "$spaces") )
end

function __yabai_space_layout_arg
    return ( __yabai_space_config; and __fish_prev_arg_in layout )
end

function __yabai_global_config
    return ( __yabai_has_msg; and __fish_prev_arg_in config; and not __fish_seen_argument -l spaces )
end

function __yabai_get_space_idx
   set spaces (yabai -m query --spaces | jq -c 'map(.index) | join(" ")' | string replace -a '"' "")
end

function __yabai_huh
    set -l opts (fish_opt -s c -r) (fish_opt -s a -r)
    argparse $opts -- $argv
    echo "opts: $opts, cmd: $_flag_c, arg: $_flag_a" >> cmd.txt
end

complete -c yabai -n 'not __yabai_has_msg' -s 'm' -l 'message' -f -d 'Send message to a running instance of yabai'
complete -c yabai -n '__yabai_msg_arg' -xa "$domain"
complete -c yabai -n '__yabai_space_opt' -fl 'space'
complete -c yabai -n '__yabai_space_arg' -xa "$spaces"
complete -c yabai -n '__yabai_space_config_arg' -xa "$space_settings"
complete -c yabai -n '__yabai_space_layout_arg' -fa "$layout"
complete -c yabai -n '__yabai_global_config' -fa "$global_config"
for i in $global_config
    set -l hint ( string split "\t" $i )
    set -l cmd $hint[1]
    if contains $cmd $global_config_bool_select
        set args $bool_select
    else if contains $cmd $global_config_mouse_action
        set args $mouse_action
    else if contains $cmd "external_bar"
        set args $external_bar
    else if contains $cmd "focus_follows_mouse"
        set args $focus_follows_mouse
    else if contains $cmd "window_origin_display"
        set args $window_origin_display
    else if contains $cmd "window_placement"
        set args $window_placement
    else if contains $cmd "split_type"
        set args $split_type
    else if contains $cmd "mouse_modifier"
        set args $mouse_modifier
    else if contains $cmd "mouse_drop_action"
        set args $mouse_drop_action
    else
        continue
    end
    set -l cond '__yabai_huh -c "$cmd" -a "$args"'
    complete -c yabai -n "$cond" -xa "$args"
end
