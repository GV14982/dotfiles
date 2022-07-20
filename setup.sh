#!/bin/bash

files=("$HOME/.config/kitty" "$HOME/.config/nvim" "$HOME/.config/yabai" "$HOME/.config/skhd" "$HOME/.zshrc" "$HOME/.tmux.conf" "$HOME/.config/starship.toml" "$HOME/antigen.zsh")
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

brew bundle

if [[ $1 == "clean" ]]; then
  for i in "${files[@]}"; do
    rm -rf $i
  done
fi

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
    if [[ $i =~ .*(kitty|starship).* ]]; then
      src="$(pwd)/shell/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*(zsh|tmux|antigen).* ]]; then
      src="$(pwd)/shell/$val"
      dest="$HOME/$val"
    elif [[ $i =~ .*(yabai|skhd).* ]]; then
      src="$(pwd)/util/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*nvim.* ]]; then
      src="$(pwd)/$val"
      dest="$HOME/.config/$val"
    fi
    echo "Linked $src to $dest"
    ln -s $src $dest
  fi
done
