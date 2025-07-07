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
  "yorickpeterse/nvim-pqf",
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons", "ravitemer/mcphub.nvim" },
    config = function()
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        -- The following line is needed to fix the background color
        -- Set it to the lualine section you want to use
        hl_group = "lualine_c_normal",
      })
      local M = require("lualine.component"):extend()

      M.processing = false
      M.spinner_index = 1

      local spinner_symbols = {
        "⠋",
        "⠙",
        "⠹",
        "⠸",
        "⠼",
        "⠴",
        "⠦",
        "⠧",
        "⠇",
        "⠏",
      }
      local spinner_symbols_len = 10

      -- Initializer
      function M:init(options)
        M.super.init(self, options)

        local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequest*",
          group = group,
          callback = function(request)
            if request.match == "CodeCompanionRequestStarted" then
              self.processing = true
            elseif request.match == "CodeCompanionRequestFinished" then
              self.processing = false
            end
          end,
        })
      end

      -- Function that runs every time statusline is updated
      function M:update_status()
        if self.processing then
          self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
          return spinner_symbols[self.spinner_index]
        else
          return nil
        end
      end

      local opts = {
        theme = "catppuccin-macchiato",
        sections = {
          lualine_c = {},
          lualine_y = { M, "progress" },
          lualine_z = { require('mcphub.extensions.lualine'), "location" },
        },
      }

      table.insert(opts.sections.lualine_c, { symbols.get, cond = symbols.has })

      require('lualine').setup(opts)
    end
  },
  {

    'brianhuster/live-preview.nvim',
    dependencies = {
      -- You can choose one of the following pickers
      'nvim-telescope/telescope.nvim',
    },
  }
}
