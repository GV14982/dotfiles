#!/bin/sh

# Setup Homebrew
./scripts/brew.sh

# Setup Github CLI
./scripts/gh.sh

# Handle symlinks with stow
./scripts/stow.sh

# Setup programs managed by mise
./scripts/mise.sh

# Setup delta diff
./scripts/delta.sh

# Symlink fish on x86 systems so my scripts work :)
if [[ $(uname -a) =~ .*x86_64.* ]]; then
  echo "Symlink fish if x86"
  mkdir -p /opt/homebrew/bin
  ln -s /usr/local/bin/fish /opt/homebrew/bin/fish
else
  echo "Skipping symlinking fish"
fi
