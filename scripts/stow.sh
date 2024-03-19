#!/bin/sh

echo "Setup symlinks with stow"
stow -t ~ .
# Insert empty newline
echo ""
