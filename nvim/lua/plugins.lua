return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.g.catppuccin_flavour = "frappe"
            require("catppuccin").setup()
            vim.cmd.colorscheme("catppuccin")
        end
    }
    use {'norcalli/nvim-colorizer.lua'}
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'windwp/nvim-autopairs'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'catppuccin'
                }
            }
        end
    }
    use 'mechatroner/rainbow_csv'
    use 'folke/lsp-colors.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }
    use 'f-person/git-blame.nvim'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }
    use 'tpope/vim-surround'
    use {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
    }
    -- Rust
    use 'simrat39/rust-tools.nvim'
    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'windwp/nvim-ts-autotag'
    use 'theHamsta/nvim-treesitter-pairs'
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- Telescope 
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons'} }
    }
    use 'stevearc/dressing.nvim'
    use "gbrlsnchs/telescope-lsp-handlers.nvim"
    use 'nvim-telescope/telescope-project.nvim'
    use 'nvim-telescope/telescope-symbols.nvim'
    use "nvim-telescope/telescope-github.nvim"
    use "benfowler/telescope-luasnip.nvim"
    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            -- Linter/Formatter
            {'jose-elias-alvarez/null-ls.nvim'},
        }
    }

    vim.opt.completeopt = { "menu", "menuone", "noselect" }
end)
