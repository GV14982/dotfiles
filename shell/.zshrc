source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle httpie
antigen bundle history
antigen bundle golang
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle jeffreytse/zsh-vi-mode

antigen apply

export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$(tty)
eval "$(starship init zsh)"

# aliases
alias zrc="$EDITOR ~/.zshrc"
alias nvimconf="$EDITOR ~/.config/nvim/init.lua"
alias alacrittyconf="$EDITOR ~/.config/alacritty/alacritty.yml"
alias pip="pip3"

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
fpath+=$(brew --prefix)/share/zsh/site-functions

# pnpm
export PNPM_HOME="/Users/gvqz/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
eval "$(~/.cargo/bin/rtx activate zsh)"
autoload -U compinit; compinit

