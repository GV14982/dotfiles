local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
telescope.setup {
  extensions = {
    project = {
      hidden_files = true,
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    }
  },
  defaults = {
    prompt_prefix = '  ',
    color_devicons = true,
    layout_strategy = 'horizontal',
    layout_config = {
      preview_cutoff = 1
    },
    mappings = {
      n = {
        ['<C-d>'] = actions.delete_buffer
      },
      i = {
        ['<C-d>'] = actions.delete_buffer
      }
    }
  },
}
telescope.load_extension "project"
telescope.load_extension "gh"
telescope.load_extension "luasnip"
telescope.load_extension "lsp_handlers"
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>p', builtin.find_files, opts)
vim.keymap.set('n', '<leader>b', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fk', builtin.keymaps, opts)
