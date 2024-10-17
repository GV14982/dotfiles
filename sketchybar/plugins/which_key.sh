if [ "$SENDER" = "skhd_mode_changed" ]; then
  if [ "$MODE" = "default" ]; then
    sketchybar --set leftmost.left popup.drawing=false
    sketchybar --remove /.*\.command/
  elif [ "$MODE" = "command" ]; then
    sketchybar --remove /.*\.command/
    sketchybar --set leftmost.left popup.drawing=true \
      --add item switch.left.command popup.leftmost.left \
      --set switch.left.command label="Switch left" \
      background.corner_radius=5 \
      icon=h \
      --add item switch.down.command popup.leftmost.left \
      --set switch.down.command label="Switch down" \
      background.corner_radius=5 \
      icon=j \
      --add item switch.up.command popup.leftmost.left \
      --set switch.up.command label="Switch up" \
      background.corner_radius=5 \
      icon=k \
      --add item switch.right.command popup.leftmost.left \
      --set switch.right.command label="Switch right" \
      background.corner_radius=5 \
      icon=l \
      --add item move.left.command popup.leftmost.left \
      --set move.left.command label="Move left" \
      background.corner_radius=5 \
      icon=H \
      --add item move.down.command popup.leftmost.left \
      --set move.down.command label="Move down" \
      background.corner_radius=5 \
      icon=J \
      --add item move.up.command popup.leftmost.left \
      --set move.up.command label="Move up" \
      background.corner_radius=5 \
      icon=K \
      --add item move.right.command popup.leftmost.left \
      --set move.right.command label="Move right" \
      background.corner_radius=5 \
      icon=L \
      --add item fullscreen.command popup.leftmost.left \
      --set fullscreen.command label="Fullscreen window" \
      background.corner_radius=5 \
      icon=0 \
      --add item close.command popup.leftmost.left \
      --set close.command label="Close window" \
      background.corner_radius=5 \
      icon=x \
      --add item rotate.command popup.leftmost.left \
      --set rotate.command label="Rotate space" \
      background.corner_radius=5 \
      icon=r \
      --add item balance.command popup.leftmost.left \
      --set balance.command label="Balance space" \
      background.corner_radius=5 \
      icon=b \
      --add item close.command popup.leftmost.left \
      --set close.command label="Close window" \
      background.corner_radius=5 \
      icon=x \
      --add item float.toggle.command popup.leftmost.left \
      --set float.toggle.command label="Toggle float" \
      background.corner_radius=5 \
      icon=t \
      --add item split.toggle.command popup.leftmost.left \
      --set split.toggle.command label="Toggle split" \
      background.corner_radius=5 \
      icon=e \
      --add item float.command popup.leftmost.left \
      --set float.command label="Float" \
      background.corner_radius=5 \
      icon=f \
      --add item workspace.command popup.leftmost.left \
      --set workspace.command label="Workspace" \
      background.corner_radius=5 \
      icon=w
  elif [ "$MODE" = "float" ]; then
    sketchybar --remove /.*\.command/
    sketchybar --set leftmost.left popup.drawing=true \
      --add item float.left.third.command popup.leftmost.left \
      --set float.left.third.command label="Left third" \
      background.corner_radius=5 \
      icon=h \
      --add item float.middle.third.command popup.leftmost.left \
      --set float.middle.third.command label="Middle third" \
      background.corner_radius=5 \
      icon=space \
      --add item float.right.third.command popup.leftmost.left \
      --set float.right.third.command label="Right third" \
      background.corner_radius=5 \
      icon=l \
      --add item float.left.two-thirds.command popup.leftmost.left \
      --set float.left.two-thirds.command label="Left two-thirds" \
      background.corner_radius=5 \
      icon=H \
      --add item float.right.two-thirds.command popup.leftmost.left \
      --set float.right.two-thirds.command label="Right two-thirds" \
      background.corner_radius=5 \
      icon=L \
      --add item float.left.half.command popup.leftmost.left \
      --set float.left.half.command label="Left half" \
      background.corner_radius=5 \
      icon="ctrl + h" \
      --add item float.right.half.command popup.leftmost.left \
      --set float.right.half.command label="Right half" \
      background.corner_radius=5 \
      icon="ctrl + l" \
      --add item float.fullscreen.command popup.leftmost.left \
      --set float.fullscreen.command label="Fullscreen" \
      background.corner_radius=5 \
      icon=return
  elif [ "$MODE" = "workspace" ]; then
    sketchybar --remove /.*\.command/
    sketchybar --set leftmost.left popup.drawing=true \
      --add item workspace.focus.command popup.leftmost.left \
      --set workspace.focus.command label="Focus workspace [n]" \
      background.corner_radius=5 \
      icon="[n]" \
      --add item workspace.focus.next.command popup.leftmost.left \
      --set workspace.focus.next.command label="Focus next workspace" \
      background.corner_radius=5 \
      icon=l \
      --add item workspace.focus.prev.command popup.leftmost.left \
      --set workspace.focus.prev.command label="Focus prev workspace" \
      background.corner_radius=5 \
      icon=h \
      --add item workspace.move.window.command popup.leftmost.left \
      --set workspace.move.window.command label="Move window to workspace [n]" \
      background.corner_radius=5 \
      icon="shift + [n]" \
      --add item workspace.move.window.next.command popup.leftmost.left \
      --set workspace.move.window.next.command label="Move window to next workspace" \
      background.corner_radius=5 \
      icon=H \
      --add item workspace.move.window.prev.command popup.leftmost.left \
      --set workspace.move.window.prev.command label="Move window to prev workspace" \
      background.corner_radius=5 \
      icon=L \
      --add item workspace.create.command popup.leftmost.left \
      --set workspace.create.command label="Create workspace" \
      background.corner_radius=5 \
      icon=c \
      --add item workspace.delete.command popup.leftmost.left \
      --set workspace.delete.command label="Delete workspace" \
      background.corner_radius=5 \
      icon=x
  fi
fi
