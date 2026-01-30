return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        marksman = {
          enabled = true,
          filetypes = { "markdown", "markdown.mdx", "markdown.presenterm" },
        },
        graphql = {
          enabled = true,
          mason = true,
        },
        html = {
          enabled = true,
          mason = true,
        },
        cssls = {
          enabled = true,
          mason = true,
        },
        arduino_language_server = {
          enabled = true,
          mason = true,
        },
        harper_ls = {
          enabled = true,
          mason = true,
        },
      },
    },
  },
}
