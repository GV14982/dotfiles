return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'mofiqul/dracula.nvim'
  use 'theacodes/witchhazel'
  use 'norcalli/nvim-colorizer.lua'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'windwp/nvim-ts-autotag'
  use 'theHamsta/nvim-treesitter-pairs'
  use 'p00f/nvim-ts-rainbow'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'windwp/nvim-autopairs'
  use {
    'akinsho/bufferline.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup{
        options = {
          theme = 'dracula'
        }
      }
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'} }
  }
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use 'stevearc/dressing.nvim'
  use "gbrlsnchs/telescope-lsp-handlers.nvim"
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
  }
  use {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    "rafamadriz/friendly-snippets",
  }
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lua',
  }
  use 'mechatroner/rainbow_csv'
  use 'folke/lsp-colors.nvim'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use 'nvim-telescope/telescope-project.nvim'
  use 'nvim-telescope/telescope-symbols.nvim'
  use "nvim-telescope/telescope-github.nvim"
  use 'glepnir/dashboard-nvim'
  use "ray-x/lsp_signature.nvim"
  use "benfowler/telescope-luasnip.nvim"
  use 'f-person/git-blame.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  use 'itchyny/vim-cursorword'
  use 'tpope/vim-surround'

  vim.opt.completeopt = { "menu", "menuone", "noselect" }
end)
