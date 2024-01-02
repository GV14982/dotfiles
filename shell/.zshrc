export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh
# Zplug setup
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gh", from:oh-my-zsh
zplug "plugins/zoxide", from:oh-my-zsh
zplug "marlonrichert/zsh-autocomplete"
zplug "jeffreytse/zsh-vi-mode"
zplug "fdellwing/zsh-bat"
zplug "torifat/npms"
zplug "MohamedElashri/exa-zsh", hook-load:"alias ls='exa --icons'"
zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions", defer:2

zplug load

# Editor setup
export EDITOR=nvim
export VISUAL=nvim

# Fix for gpg breaking
export GPG_TTY=$(tty)

# Setup starship prompt
eval "$(starship init zsh)"

# aliases
alias zrc="$EDITOR ~/.zshrc"
alias zource="source ~/.zshrc"
alias nvimconf="$EDITOR ~/.config/nvim/init.lua"
alias wezconf="$EDITOR ~/.config/wezterm/init.lua"
alias nuconf="$EDITOR ~/Library/Application\ Support/nushell/config.nu"
alias pip="pip3"
alias python="python3"
alias cd="z"
alias j="joshuto"

# functions
mkcdir ()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Include zfunc homebrew site-functions in function path
fpath+=~/.zfunc
fpath+=$(brew --prefix)/share/zsh/site-functions

# Fzf
export FZF_DEFAULT_COMMAND="fd --type d --no-ignore-vcs --exclude node_modules --exclude .git"

# Include the go bin path
export PATH="$PATH:$HOME/.local/bin:$HOME/go/bin"

# Setup rtx
eval "$(rtx activate zsh)"

# Set brew to use bat
export HOMEBREW_BAT=true

# Setup zsh-autocompletion
zstyle ':autocomplete:*' delay 0.1  # seconds (float)
zstyle ':autocomplete:*' ignored-input '..##'
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
