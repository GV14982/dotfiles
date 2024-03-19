#!/bin/sh

echo "Setup gh cli"

# Set our word separator to only newline
IFS=$'\n'
set -f

# Get installed gh cli extensions
gh_list="$(gh extension list | awk -F'\t' '{print $2}')"

# Install gh cli extensions
for i in $(cat gh/extensions.txt); do
  if [[ $gh_list =~ $i ]]; then
    echo "Extension already installed: $i"
  else
    echo "Installing extension: $i"
    gh extension install $i
  fi
done

# Insert empty newline
echo ""
