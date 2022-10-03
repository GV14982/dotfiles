source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle httpie
antigen bundle history
antigen bundle golang
antigen bundle git
antigen bundle thefuck
antigen bundle asdf
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle jeffreytse/zsh-vi-mode

antigen apply

export EDITOR=nvim
export VISUAL=nvim

eval "$(starship init zsh)"
eval "$(thefuck --alias)"
eval "$(fnm env --use-on-cd)"

# aliases
alias zrc="$EDITOR ~/.zshrc"
alias nvimconf="$EDITOR ~/.config/nvim/init.lua"
alias kittyconf="$EDITOR ~/.config/kitty/kitty.conf"
alias icat="kitty +kitten icat"
alias d="kitty +kitten diff"

# functions
mkcdir ()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

export FZF_DEFAULT_COMMAND="fd --type d --no-ignore-vcs --exclude node_modules --exclude .git"
export PATH="$PATH:$HOME/.local/bin:$HOME/go/bin"
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gvqz/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/gvqz/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gvqz/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/gvqz/google-cloud-sdk/completion.zsh.inc'; fi
fpath+=~/.zfunc

# pnpm
export PNPM_HOME="/Users/gvqz/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end