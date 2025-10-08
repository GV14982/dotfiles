#!/bin/sh
echo "Setup yay"

# Check if homebrew is installed
command -v yay -h &> /dev/null && yayInstalled=true || yayInstalled=false
#
# If Homebrew is not installed, install it!
if [ $yayInstalled = false ]; then
  echo "Installing Homebrew"
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
fi

# Set our word separator to only newline
IFS=$'\n'
set -f

# Install packages
for i in $(cat packages.txt); do
  echo "Installing package: $i"
  yay -S --noconfirm $i
done

# Insert empty newline
echo ""
