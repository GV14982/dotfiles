local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
telescope.setup{
  defaults = {
    mappings = {
      n = {
        ['<C-d>'] = actions.delete_buffer
      },
      i = {
        ['<C-d>'] = actions.delete_buffer
      }
    }
  }
}
telescope.load_extension "file_browser"
local opts = {noremap = true}
vim.keymap.set('n', '<C-p>', builtin.find_files, opts)
vim.keymap.set('n', '<C-b>', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', telescope.extensions.file_browser.file_browser, opts)
