#!/bin/sh

echo "Setting up delta as git pager"
# Setting some global git configs to use delta as a pager
git config --global core.pager delta
git config --global pager.blame delta
git config --global merge.conflictstyle diff3
git config --global interactive.diffFilter "delta --color-only --features=interactive"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global delta.hyperlinks true
git config --global delta.syntax-theme "Catppuccin-frappe"
# Insert empty newline
echo ""
