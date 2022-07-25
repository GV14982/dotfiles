local keymap = vim.keymap.set
local silent = {silent = true}
keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', silent)
vim.api.nvim_create_user_command('Ws', 'w | so %', {})
keymap('n', '<leader><', ':BufferLineCyclePrev<CR>', silent)
keymap('n', '<leader>>', ':BufferLineCycleNext<CR>', silent)
