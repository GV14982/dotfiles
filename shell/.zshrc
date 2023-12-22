export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh
# Zplug setup
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/ripgrep", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/jump", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", as:plugin, defer:2
zplug "zsh-users/zsh-autosuggestions", as:plugin, defer:2
zplug "zsh-users/zsh-completions", as:plugin, defer:2
zplug "jeffreytse/zsh-vi-mode", as:plugin
zplug "fdellwing/zsh-bat", as:plugin
zplug "MohamedElashri/exa-zsh", as:plugin, hook-load:"alias ls='exa --icons'"
zplug "torifat/npms", as:plugin

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
