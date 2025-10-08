fish_add_path "$HOME/bin"

# add it to your ~/.config/fish/config.fish

# retrieve command cheat sheets from cheat.sh
# fish version by @tobiasreischmann

function cht.sh
    curl cht.sh/$argv
end

# register completions (on-the-fly, non-cached, because the actual command won't be cached anyway
complete -c cht.sh -xa '(curl -s cheat.sh/:list)'
set -gx XDG_CONFIG_HOME "$HOME/.config"
if status is-interactive
    fish_add_path -P ~/.local/bin/

    set -gx EDITOR nvim
    # ALIASES
    abbr -a fexec "exec fish"
    abbr -a fishconf "$EDITOR ~/.config/fish/config.fish"
    abbr -a nvimconf "$EDITOR ~/.config/nvim/init.lua"
    abbr -a wezconf "$EDITOR ~/.config/wezterm/wezterm.lua"
    abbr -a tmuxconf "$EDITOR ~/.config/tmux/tmux.conf"
    set -gx EZA_ICONS_AUTO true
    alias cat bat
    alias ls eza

    bind --preset -e -a \cl
    bind --preset -e -a \ca
    bind -M insert \cl forward-word
    bind -M insert \ca accept-autosuggestion

    # Set GPG_TTY to fix broken commit signing: https://github.com/fish-shell/fish-shell/issues/6643
    set -gx GPG_TTY (tty)

    # Set vi mode
    set -g fish_vi_force_cursor 1
    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore

    # Set FZF to use Catppuccin Frappe
    set -gx FZF_DEFAULT_OPTS "\
    --color=bg+:-1,bg:-1,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

    # Set FISH theme to catppuccin
    set -g theme "Catppuccin Macchiato"

    # Init starship prompt
    starship init fish | source

    # Init Zoxide
    zoxide init fish | source

    # Init Mise
    mise activate fish | source

    set -gx PATH $PATH /Users/gvqz/.ghcup/bin

    eval $(ssh-agent -c)
    ssh-add ~/.ssh/id_rsa
end

# Added by Radicle.
export PATH="$PATH:/Users/gvqz/.radicle/bin"

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/gvqz/.opam/opam-init/init.fish' && source '/Users/gvqz/.opam/opam-init/init.fish' >/dev/null 2>/dev/null; or true
# END opam configuration

# pnpm
set -gx PNPM_HOME /Users/gvqz/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx DOCKER_HOST "unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"
