return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        marksman = {
          filetypes = { "markdown", "markdown.mdx", "markdown.presenterm" },
        },
        graphql = {
          mason = true,
        },
        html = {
          mason = true,
        },
        cssls = {
          mason = true,
        },
      },
    },
  },
}
