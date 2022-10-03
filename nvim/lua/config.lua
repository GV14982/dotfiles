vim.g.mapleader = " "
local set = vim.opt
local home = os.getenv("HOME")

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.autoindent = true
set.number = true
set.wrap = false
set.relativenumber = true
set.termguicolors = true
vim.g.catppuccin_flavour = "frappe"
require('catppuccin').setup()
vim.cmd [[colorscheme catppuccin]]

require('dressing').setup({
  select = {
    enabled = true,
    backend = "telescope"
  }
})
require('todo-comments').setup {}
require("nvim-autopairs").setup {}
require('colorizer').setup {}
require('bufferline').setup {
  options = {
    clickabl = false,
    closable = false,
    auto_hide = true,
    tabpages = true
  }
}
local db = require('dashboard')
db.preview_command = 'cat | lolcat -F 0.3'
db.preview_file_path = home .. '/.config/nvim/neovim.txt'
db.preview_file_width = 68
db.preview_file_height = 7
db.custom_center = {
  { icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f' },
  { icon = '  ',
    desc = 'File Browser                            ',
    action = 'Telescope file_browser',
    shortcut = 'SPC f b' },
  { icon = '  ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w' },
  { icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'e ~/dotfiles',
    shortcut = 'SPC f d' },
}
