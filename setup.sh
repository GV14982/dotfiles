#!/bin/bash

files=("$HOME/.config/kitty" "$HOME/.config/nvim" "$HOME/.config/yabai" "$HOME/.config/skhd" "$HOME/.zshrc" "$HOME/.asdfrc" "$HOME/.tool-versions" "$HOME/.tmux.conf" "$HOME/.config/starship.toml" "$HOME/antigen.zsh")
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
  echo "Installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing brew packages"
brew bundle -v

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
    if [[ $i =~ .*(kitty|starship).* ]]; then
      src="$(pwd)/shell/$val"
      dest="$HOME/.config/$val"
    elif [[ $i =~ .*(zsh|tmux|antigen|asdf|tool-versions).* ]]; then
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

ceckFileLinkDir "$HOME/.local/share/nvim/site/pack/packer"
if [[ $exists == "" ]]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

echo "Installing rust"
rustup-init
source "$HOME/.cargo/env"

echo "Setup asdf"
IFS='
'
for plugin in $(cat asdf.plugins)
do
  stripped=$(echo $plugin | sed 's/ \{1,\}/ /g')
  echo installing plugin $stripped
  # Idk why it wouldn't let me just run the command, so this is kind of a hacky workaround
  echo asdf plugin-add $stripped | sh
done
asdf install
