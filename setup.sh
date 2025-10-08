#!/bin/sh

# Setup yay
./scripts/yay.sh

# Setup Github CLI
./scripts/gh.sh

# Handle symlinks with stow
echo "Creating symlinks to ~/.config"
stow .

# Setup tmux and tpm
./scripts/tmux.sh

# Setup programs managed by mise
./scripts/mise.sh

# Setup delta diff
./scripts/delta.sh
