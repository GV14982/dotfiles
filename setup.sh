#!/bin/sh

# Setup Homebrew
./scripts/brew.sh

# Setup Github CLI
./scripts/gh.sh

# Handle symlinks with stow
echo "Creating symlinks to ~/.config"
stow .

if [ ! -d "~/.tmux/plugins/tpm" ]; then
	echo "Installing TPM"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "Installing tmux plugins"
~/.tmux/plugins/tpm/bin/install_plugins

# Setup programs managed by mise
./scripts/mise.sh

# Setup delta diff
./scripts/delta.sh
