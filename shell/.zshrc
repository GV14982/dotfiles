# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/gvqz/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/Users/gvqz/flutter/bin:/Applications:/Users/gvqz/go/bin"
export EDITOR=$(which vim)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gvqz/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/gvqz/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gvqz/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/gvqz/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

HASURA_LOCAL="http://localhost:8080"
HASURA_DEV="https://aww-rats-dev.hasura.app"
HASURA_PROD="http://aww-rats.hasura.app"
HASURA_LOCAL_SECRET="adminsecret"
HASURA_DEV_SECRET="HCXnUaex1CkhJimvZziBOiwRnRyxSIrXev57aCojAsBFl14ffk00wkvoSy9HUny9"
HASURA_PROD_SECRET="GRJyeTo6ESb60oZG3mhEXtDTQWwgzCGIz65Vc4KWTjJUvXzr5F7oaCRMF1zQ6CuY"
HASURA_BASE_URL=$HASURA_LOCAL
NEXT_PUBLIC_HASURA_ADMIN_SECRET=$HASURA_BASE_URL
HASURA_ADMIN_SECRET=$HASURA_LOCAL_SECRET

function set-hasura-dev() {
  export HASURA_ADMIN_SECRET=$HASURA_DEV_SECRET
  export HASURA_BASE_URL=$HASURA_DEV
  export NEXT_PUBLIC_HASURA_BASE_URL=$HASURA_DEV
}


function set-hasura-prod() {
  export HASURA_ADMIN_SECRET=$HASURA_PROD_SECRET
  export HASURA_BASE_URL=$HASURA_PROD
  export NEXT_PUBLIC_HASURA_BASE_URL=$HASURA_PROD
}

function set-hasura-local() {
  export HASURA_ADMIN_SECRET=$HASURA_LOCAL_SECRET
  export HASURA_BASE_URL=$HASURA_LOCAL
  export NEXT_PUBLIC_HASURA_BASE_URL=$HASURA_LOCAL
}
alias y="yarn"
alias yd="yarn dev"
alias yyd="y && yd"
alias yc="yarn codegen"
function mkcdir() {
	mkdir -p $1
	cd $1
}
alias pubsub-local="gcloud beta emulators pubsub start --project=awwrats --verbosity=debug --log-http"
#[ -f "/Users/gvqz/.ghcup/env" ] && source "/Users/gvqz/.ghcup/env" # ghcup-env

GCP_CREDENTIALS='{"type": "service_account","project_id": "awwrats","private_key_id": "db767de824456896c1734a9095d17208bf09518e","private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1dMWFw3vV2wLZ\nyOlAKLgEnAHTaJpLIpGOwrK+etJ5kC8A8NUs4Xkf8s0mn3ox7pT4xAzYZlk5NNaq\nk+nPWXR9dPWAg4QayXJ+vdxPwRgQy9VlIASqmEOEkf9xoAD4ZDXno4rlIvvmAXcH\nDz0sBhpdvBO9YtE6UWG1E6av7jiZjkSQnqqBVo80cuixeEy/Q3gPQim5XOQjs7QL\nXUMV+K4KAp/jcw1gAnmnkJj8UdfzS8/Pp96J42Jbi08oisWGt/ixQn2LrOyRNqg4\nYQZdlY/IvvJbtkqOZ84NvdWoL4OJRUG8C2btc1VtCDG5sLY2YBOn8ueDpyoKXiAi\nrbSuiGhfAgMBAAECggEARuPRXSJTaWeQNAxBT/74cViPgAvAJ7VgH2FiGnd6beKN\n8nSkG84Ul44wZrPsNcCrM4rIJ+zIU8iYSvjRYd/lWjQMy4HV5O8pi2laPlBGOh2g\nB0tcd1dYHV06aiYj6uafhpkGZOFnfuK4oSnrcJ0LxO362kTWT83GecstFlNfimF3\nwpquf5JlrP1+vgHAbCojL8mYmJG9fMJ3y+FzMc8ZSDbJLBoiM3WCSXjG/JGR2KhT\n+ZjpD28JhbXm7eUuZUWtUaTeJkCQTnKVkHFnoUNWcXlcGbGWMIqP9pc3l6lRk3Sy\n3ljSrn888HAxIFK0Dw/jGZqxi5uFOu+s9v35myQTWQKBgQD4ONgnKNEc3ju0Wfgw\neQ+oI9SuY0v9NCenW0WXhUo0nQOElhUyfdUPB6DsZPJt2i8NeyVF8y4/6kJjAIXl\ngRkvAsY4KkIpAK5D8pFoNnJKCMognJnWkOHJESQwkQ2tgs6KE9o4nsiPHXBmOvMf\nDGhuVahSKOQJqoXPr6fVR+R1uQKBgQC7JFphv3LAb+4v5wLIhYIVPaxweJU7wla0\nz7c2bbfoOPU78Fntce4/Z+XzcCrh6hjWm6vrOA31NMs7t6xdQVs7LEBZ7TDYpD8F\nh8b8/P0mjlSAII0LOnZxClizsc/ZkSgzLLZK2u3ASjt8pAWuiweWRMKgIUtelNGU\nxz31gbra1wKBgFZDqxsw3DukICu1eMOfzwkoKqnQaIA+t+k5lx3pfLh8ONTDM+qw\nQHNQu2RsULRMtz2AJpwAv3oG97tgWyg/jXkBBdJPHV8SlX2Xt2D4Sw/frh9XTT98\nantuMZ2PS6mZZB4oeBZlWF4kZQOiSQvpTAHMUwr6mwWg9ZAQA8vjiEpBAoGATRCP\nV6lrK+vr/jX3Y3P3OaAIHtjJO66v3g2buQI9tZefBWvY3HsKTXoPq8wJHLc2O0on\n5dlThiKTfqgIhu6fDyMN7PpMHyqj+TcMrqnP5cy+53SAIJuWor5MANO8cC/iihBj\nkTfOqFzpWk6BOHtwSGVQcHjFfNFz7PyPe0ZNGEkCgYEA5HZhcei9kiK6T3LN2b0F\niklFVYPyCuVL8saqEkN5924xZgpzJINK2gkH7HbWZukmGcQpk5rxdRFwVO6Ick8s\nZUJEro0ryuoMZiFUFTBL8KG8xk8LT13/7wcnMK68dEIxHxoww1wE/WmJ5P46z7ES\ni/DdaSddHq/vo9CCBdjNfOE=\n-----END PRIVATE KEY-----\n","client_email": "awwrats-pubsub-functions@awwrats.iam.gserviceaccount.com","client_id": "112016897056494573707","auth_uri": "https://accounts.google.com/o/oauth2/auth","token_uri": "https://oauth2.googleapis.com/token","auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs","client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/awwrats-pubsub-functions%40awwrats.iam.gserviceaccount.com"}'
export PATH="$PATH:/Users/gvqz/.looks"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gvqz/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

[ -f "/Users/gvqz/.ghcup/env" ] && source "/Users/gvqz/.ghcup/env" # ghcup-env