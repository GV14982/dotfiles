return {
  {
    "kevalin/mermaid.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = {
      format = {
        shift_width = 2,
      },
      lint = {
        enabled = true,
      },
      preview = {
        renderer = "mermaid.js",
        theme = "dark",
      },
    },
  },
}
