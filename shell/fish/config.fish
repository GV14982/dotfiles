eval (/opt/homebrew/bin/brew shellenv)

if status is-interactive
    set -g GPG_TTY (tty)
    abbr -a fexec "exec fish"
    abbr -a fishconf "$EDITOR ~/.config/fish/config.fish"
    abbr -a nvimconf "$EDITOR ~/.config/nvim/init.lua"
    abbr -a wezconf "$EDITOR ~/.config/wezterm/init.lua"
    abbr -a tmuxconf "$EDITOR ~/.config/tmux/tmux.conf"
    abbr -a pip "pip3"
    abbr -a python "python3"
    abbr -a ls 'lsd'
    abbr -a la 'lsd -a'
    abbr -a cat 'bat'
    # Set vi mode
    set -g fish_vi_force_cursor 1
    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    # Set FZF to use Catppuccin
    set -gx FZF_DEFAULT_OPTS "\
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
    # Set FISH theme to catppuccin
    # fish_config theme save "Catppuccin Frappe"
    set -g theme "Catppuccin Frappe"
    # Init starship
    starship init fish | source
    # Init Zoxide
    zoxide init fish | source
end
