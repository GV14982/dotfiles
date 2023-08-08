vim.g.mapleader = " "
local keymap = vim.keymap.set
vim.api.nvim_create_user_command('Ws', 'w | so %', {})
keymap("n", "x", '"_x')
keymap("n", "<leader>fb", vim.cmd.Ex)
keymap("n", "<leader>y", "\"+y")
keymap("v", "<leader>y", "\"+y")
keymap("n", "<leader>Y", "\"+Y")
keymap("x", "<leader>p", "\"_dP")
keymap("n", "<leader>t", ":NvimTreeToggle\n")
