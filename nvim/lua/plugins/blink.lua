return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      providers = {
        snippets = {
          opts = {
            -- Required: specify where to find snippets
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            -- Required: include extended filetypes at the right level
            extended_filetypes = {
              ["markdown.presenterm"] = { "markdown" }, -- presenterm inherits markdown snippets
            },
            -- Optional: other useful defaults
            friendly_snippets = true,
            global_snippets = { "all" },
          },
        },
      },
    },
    completion = { list = { selection = { auto_insert = true } } },
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
  },
}
