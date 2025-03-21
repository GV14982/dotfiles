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
set -gx DYLD_LIBRARY_PATH "/opt/homebrew/lib:$DYLD_LIBRARY_PATH"
if status is-interactive
    fish_add_path -P ~/.local/bin/

    set -gx EDITOR "nvim"
    # ALIASES
    abbr -a fexec "exec fish"
    abbr -a fishconf "$EDITOR ~/.config/fish/config.fish"
    abbr -a nvimconf "$EDITOR ~/.config/nvim/init.lua"
    abbr -a wezconf "$EDITOR ~/.config/wezterm/wezterm.lua"
    abbr -a tmuxconf "$EDITOR ~/.config/tmux/tmux.conf"
    abbr -a ls "lsd"
    abbr -a la "lsd -a"
    abbr -a cat "bat"

    bind --preset -e -a \cl
    bind --preset -e -a \ca
    bind -M insert \cl forward-word
    bind -M insert \ca accept-autosuggestion

    eval (/opt/homebrew/bin/brew shellenv fish)

    # Set GPG_TTY to fix broken commit signing: https://github.com/fish-shell/fish-shell/issues/6643
    set -gx GPG_TTY (tty)

    # Tell Homebrew to use bat instead of cat
    set -gx HOMEBREW_BAT true

    # Set DOCKER_HOST to work with colima
    set -gx DOCKER_HOST unix://$XDG_CONFIG_HOME/colima/default/docker.sock

    set -gx DYLD_LIBRARY_PATH (brew --prefix)/lib:$DYLD_LIBRARY_PATH

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

    # Init mise
    mise activate fish | source
end


# Added by Radicle.
export PATH="$PATH:/Users/gvqz/.radicle/bin"
