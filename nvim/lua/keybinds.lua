vim.keymap.set('n', '<C-t>', '<ESC>:ToggleTerm<CR>', {noremap = true})
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', {noremap = true})
vim.api.nvim_create_user_command('Ws', 'w | so %', {})
