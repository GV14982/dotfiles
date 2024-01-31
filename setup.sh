#!/bin/sh

# Check if homebrew is installed
command -v brew &> /dev/null && brewInstalled=true || brewInstalled=false
#
# If Homebrew is not installed, install it!
if [ $brewInstalled = false ]; then
  echo "\033[32;m\033[0m Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Installing brew packages/casks/taps
IFS=$'\n'
set -f
brew_list="$(brew list)"
for i in $(cat tap.txt); do
  echo "\033[32;m\033[0m Brew tapping $i"
  brew tap "$i"
done

for i in $(cat brew.txt); do
  if [[ $brew_list =~ $i ]]; then
    echo "\033[33;m!\033[0m Package already installed: $i"
  else
    echo "\033[32;m\033[0m Installing package: $i"
    brew install $i
  fi
done

for i in $(cat cask.txt); do
  if [[ $brew_list =~ $i ]]; then
    echo "\033[33;m!\033[0m Cask already installed: $i"
  else
    echo "\033[32;m\033[0m Installing cask: $i"
    brew install --cask $i
  fi
done

for i in $(cat gh.txt); do
  gh extension install $i
done

echo "\033[34;m\033[0m Setup symlinks with stow"
# stow -t ~ */
./stow.sh

# Setup programs managed by mise
echo "\033[35;m\033[0m Install mise plugins/runtimes"
mise install

# Setting some global git configs to use delta as a pager
echo "\033[31;m\033[0m Setting up delta as git pager"
git config --global core.pager delta
git config --global pager.blame delta
git config --global merge.conflictstyle diff3
git config --global interactive.diffFilter "delta --color-only --features=interactive"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global delta.hyperlinks true
git config --global delta.syntax-theme "Catppuccin-frappe"

if [[ $(uname -a) =~ .*x86_64.* ]]; then
  echo "\033[34;m\033[0m Symlink fish if x86"
  mkdir -p /opt/homebrew/bin
  ln -s /usr/local/bin/fish /opt/homebrew/bin/fish
else
  echo "\033[33;m!\033[0m Skipping symlinking fish"
fi
