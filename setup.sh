#!/bin/sh

files=(
  "$HOME/.config/wezterm"
  "$HOME/.config/nvim"
  "$HOME/.config/yabai"
  "$HOME/.config/skhd"
  "$HOME/.config/fish"
  "$HOME/.config/starship.toml"
  "$HOME/.config/mise"
  "$HOME/.config/bottom"
  "$HOME/.config/tmux"
  "$HOME/.config/xplr"
  "$HOME/.config/bat"
)
exists=""

command -v brew &> /dev/null && brewInstalled=true || brewInstalled=false

function checkFileLinkDir() {
  if [ -d "$1" ]; then
    exists="folder"
  elif [ -L "$1" ]; then
    exists="link"
  elif [ -f "$1" ]; then
    exists="file"
  else
    exists=""
  fi
}

if [ $brewInstalled = false ]; then
  echo "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

IFS=$'\n'
set -f
brew_list="$(brew list)"
for i in $(cat tap.txt); do
  echo "Brew tapping $i"
  brew tap "$i"
done

for i in $(cat brew.txt); do
  if [[ $brew_list =~ $i ]]; then
    echo "Package already installed: $i"
  else
    echo "Installing package: $i"
    brew install $i
  fi
done

for i in $(cat cask.txt); do
  if [[ $brew_list =~ $i ]]; then
    echo "Cask already installed: $i"
  else
    echo "Installing cask: $i"
    brew install --cask $i
  fi
done

if [[ $1 == "clean" ]]; then
  echo "Removing existing files/folders/links"
  for i in "${files[@]}"; do
    rm -rf $i
  done
fi

echo "Checking and recreating symlinks"
for i in "${files[@]}"
do
  :
  checkFileLinkDir $i
  if [[ $i =~ (\/[^\/]*$){1} ]]; then
    match=${BASH_REMATCH[0]}
    len=${#match}
    val="${match:1: len - 1}"
  fi
  if [[ $exists == "" ]]; then
    if [[ $i =~ .*(wezterm|starship|fish|tmux).* ]]; then
      src="$(pwd)/shell/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*(yabai|skhd|mise|bottom|xplr|bat).* ]]; then
      src="$(pwd)/util/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*nvim.* ]]; then
      src="$(pwd)/$val"
      dest="$HOME/.config/$val"
    fi
    ln -s $src $dest
    echo "Linked $src to $dest"
  else
    echo "$i already linked"
  fi
done

echo "Install mise plugins/runtimes"
mise install

echo "Setting up delta as git pager"
git config --global core.pager delta
git config --global pager.blame delta
git config --global merge.conflictstyle diff3
git config --global interactive.diffFilter "delta --color-only --features=interactive"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global delta.hyperlinks true
git config --global delta.syntax-theme "Catppuccin-frappe"
