require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  ignore_install = { 'phpdoc' },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  indentation = {
    enable = true
  },
  incremental_selection = {
    enable = true
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
