source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle httpie
antigen bundle history
antigen bundle golang
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme dracula/zsh dracula

antigen apply

export EDITOR=nvim
export VISUAL=nvim

eval "$(starship init zsh)"

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

# functions
mkcdir ()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
