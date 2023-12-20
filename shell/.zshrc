export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$(tty)
eval "$(starship init zsh)"

# aliases
alias zrc="$EDITOR ~/.zshrc"
alias nvimconf="$EDITOR ~/.config/nvim/init.lua"
alias wezconf="$EDITOR ~/.config/wezterm/init.lua"
alias nuconf="$EDITOR ~/Library/Application\ Support/nushell/config.nu"
alias pip="pip3"
alias ls="exa"
alias cat="bat"

# functions
mkcdir ()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

export FZF_DEFAULT_COMMAND="fd --type d --no-ignore-vcs --exclude node_modules --exclude .git"
export PATH="$PATH:$HOME/.local/bin:$HOME/go/bin"
eval "$(rtx activate zsh)"
