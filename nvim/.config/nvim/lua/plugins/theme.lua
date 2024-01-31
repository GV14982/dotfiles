return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = -1,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        integrations = {
          cmp = true,
          fidget = true,
          gitsigns = true,
          lsp_trouble = true,
          markdown = true,
          mason = true,
          mini = {
            enabled = true,
            indentscope_color = "overlay0"
          },
          native_lsp = {
            enabled = true,
          },
          notify = true,
          rainbow_delimiters = true,
          semantic_tokens = true,
          telescope = {
            enabled = true
          },
          treesitter = true,
          treesitter_context = true,
          ufo = true,
          which_key = true,
        }
      })
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
