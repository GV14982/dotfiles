return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    vim.defer_fn(function()
      vim.treesitter.language.register("markdown", { "markdown.presenterm", "presenterm" })
      vim.treesitter.language.register("markdown", { "markdown.mdx", "mdx" })
    end, 0)
  end,
}
