return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.taplo,
          null_ls.builtins.formatting.templ,
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.todo_comments,
          null_ls.builtins.diagnostics.trail_space,
        }
      })
    end
  }
}
