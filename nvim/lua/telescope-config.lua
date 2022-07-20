local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
telescope.setup {
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
local opts = { noremap = true }
vim.keymap.set('n', '<C-p>', builtin.find_files, opts)
vim.keymap.set('n', '<leader>buf', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
