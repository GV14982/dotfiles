return {
  "saghen/blink.cmp",
  opts = {
    completion = { list = { selection = { auto_insert = true } } },
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
  },
}
