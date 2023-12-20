#!/bin/sh

files=("$HOME/.config/wezterm" "$HOME/.config/nvim" "$HOME/.config/yabai" "$HOME/.config/skhd" "$HOME/.zshrc" "$HOME/.config/starship.toml" "$HOME/.config/zellij" "$HOME/.config/rtx" "$HOME/Library/Application Support/nushell")
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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

IFS=$'\n'
set -f
for i in $(cat brew.txt); do
  brew install "$i"
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
    if [[ $i =~ .*(wezterm|starship).* ]]; then
      src="$(pwd)/shell/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*(zsh).* ]]; then
      src="$(pwd)/shell/$val"
      dest="$HOME/$val"
    elif [[ $i =~ .*(yabai|skhd|rtx).* ]]; then
      src="$(pwd)/util/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*nvim.* ]]; then
      src="$(pwd)/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*(nushell).* ]]; then
      src="$(pwd)/shell/$val"
      dest="$HOME/Library/Application Support/"
    fi
    ln -s $src $dest
    echo "Linked $src to $dest"
  fi
done

rtx install
