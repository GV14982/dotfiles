vim.g.mapleader = " "
local set = vim.opt
local global = vim.g
-- nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup()
set.clipboard:append("unnamedplus")
set.backspace = "indent,eol,start"
set.cursorline = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.autoindent = true
set.number = true
set.wrap = false
set.relativenumber = true
set.termguicolors = true

require('dressing').setup({
    input = {
        enabled = true
    },
    select = {
        enabled = true,
        backend = "telescope"
    }
})
require('todo-comments').setup {}
require('nvim-autopairs').setup {}
require('colorizer').setup {}
