#!/bin/sh
echo "Setup homebrew"

# Check if homebrew is installed
command -v brew &> /dev/null && brewInstalled=true || brewInstalled=false
#
# If Homebrew is not installed, install it!
if [ $brewInstalled = false ]; then
  echo "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv zsh)"
echo "$(/opt/homebrew/bin/brew shellenv zsh)" >> ~/.zprofile

# Set our word separator to only newline
IFS=$'\n'
set -f

# List currently installed homebrew packages
brew_list="$(brew list)"

# Setup brew taps
for i in $(cat brew/tap.txt); do
  echo "Brew tapping $i"
  brew tap "$i"
done

# Install brew formulae
for i in $(cat brew/formulae.txt); do
  if [[ $brew_list =~ $i ]]; then
    echo "Package already installed: $i"
  else
    echo "Installing package: $i"
    brew install $i
  fi
done

# Install brew casks
for i in $(cat brew/cask.txt); do
  if [[ $brew_list =~ $i ]]; then
    echo "Cask already installed: $i"
  else
    echo "Installing cask: $i"
    brew install --cask $i
  fi
done

# Insert empty newline
echo ""
