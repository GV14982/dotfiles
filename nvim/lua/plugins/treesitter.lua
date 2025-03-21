vim.filetype.add({
  extension = {
    mdx = "mdx"
  },
  filename = {
    skhdrc = "skhdrc",
    yabairc = "yabairc"
  }
})
return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          languages = {
            gleam = "// %s",
          }
        }
      }

    },
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
      vim.defer_fn(function()
        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.uiua = {
          install_info = {
            url = "https://github.com/shnarazk/tree-sitter-uiua",
            files = { "src/parser.c" },
            branch = "main",
          },
        }
        vim.treesitter.language.register("uiua", "ua")
        vim.treesitter.language.register("markdown", "mdx")
        vim.treesitter.language.register("markdown", "presenterm")
        vim.treesitter.language.register("bash", "skhdrc")
        vim.treesitter.language.register("bash", "yabairc")
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = true
        vim.opt.foldlevel = 100
        require('nvim-treesitter.configs').setup {
          -- Add languages to be installed here tat you want installed for treesitter
          modules = {},
          ignore_install = {},
          sync_install = false,
          ensure_installed = {
            -- Web
            'html',
            'css',
            'scss',
            'jsdoc',
            'javascript',
            'typescript',
            'tsx',
            'graphql',
            -- Config
            'luadoc',
            'lua',
            'vimdoc',
            'vim',
            'json',
            'kdl',
            'yaml',
            'toml',
            'make',
            -- System
            'go',
            'gomod',
            'gosum',
            'gowork',
            'rust',
            -- Other
            'gleam',
            'templ',
            'regex',
            'sql',
            'markdown',
            'markdown_inline',
            'gitcommit',
            'xml',
            'bash'
          },

          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,

          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-space>',
              node_incremental = '<c-space>',
              scope_incremental = '<c-s>',
              node_decremental = '<M-space>',
            },
          },
          autotag = {
            enable = true,
            enable_rename = true,
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }
      end, 0)
    end
  },
  {
    -- Highlight, edit, and navigate code
    'LhKipp/nvim-nu',
    build = ':TSInstall nu',
  },
}
