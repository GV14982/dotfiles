vim.g.mapleader = " "

local set = vim.opt

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.autoindent = true
set.number = true
set.relativenumber = true
set.termguicolors = true
vim.cmd[[colorscheme dracula]]

require('colorizer').setup {}
require('bufferline').setup {
  clickabl = false,
  closable = false,
  auto_hide = true,
  tabpages = true
}
require('nvim-tree').setup{
  view = {
    adaptive_size = true
  }
}
