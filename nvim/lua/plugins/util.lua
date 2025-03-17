return {
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup({
        copy_sync = {
          enable = false
        }
      })
    end
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {}
  },
  'akinsho/toggleterm.nvim',
  'norcalli/nvim-colorizer.lua',
  {
    'https://codeberg.org/esensar/nvim-dev-container',
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      function _G.get_oil_winbar()
        local dir = require("oil").get_current_dir()
        print(dir)
        if dir then
          return vim.fn.fnamemodify(dir, ":~")
        else
          return vim.api.nvim_buf_get_name(0)
        end
      end

      local detail = false
      local oil = require("oil")
      ---@module 'oil'
      ---@type oil.SetupOpts
      local opts = {
        delete_to_trash = true,
        win_options = {
          winbar = "%!v:lua.get_oil_winbar()"
        },
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["<BS>"] = "actions.parent",
          ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
              detail = not detail
              if detail then
                oil.set_columns({ "icon", "permissions", "size", "mtime" })
              else
                oil.set_columns({ "icon" })
              end
            end
          }
        }
      }
      oil.setup(opts)
    end
  },
  "sputnick1124/uiua.vim",
}
