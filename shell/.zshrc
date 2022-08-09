ZSH_TMUX_AUTOSTART=true

bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word
bindkey "\e\b" backward-kill-word

source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle httpie
antigen bundle history
antigen bundle golang
antigen bundle git
antigen bundle thefuck
antigen bundle tmux
antigen bundle asdf
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle jeffreytse/zsh-vi-mode

antigen theme dracula/zsh dracula

antigen apply

export EDITOR=nvim
export VISUAL=nvim

eval "$(starship init zsh)"
eval "$(thefuck --alias)"
eval "$(fnm env --use-on-cd)"
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# RPROMPT=\$vcs_info_msg_0
# zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%r%f'
# zstyle ':vcs_info:*' enable git
# PROMPT='%F{green}%n%f>%F{cyan}%3~%f>'

# aliases
alias zrc="$EDITOR ~/.zshrc"
alias nvimconf="$EDITOR ~/.config/nvim/init.lua"

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
