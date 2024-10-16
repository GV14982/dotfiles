return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      -- Import mini plugins
      local comment = require "mini.comment"
      local indentscope = require "mini.indentscope"
      local pairs = require "mini.pairs"
      local surround = require "mini.surround"
      local trailspace = require "mini.trailspace"

      -- Setup mini plugins
      comment.setup()
      indentscope.setup({
        draw = {
          animation = indentscope.gen_animation.none(),
          delay = 0,
          priority = 1
        },
        options = {
          indent_at_cursor = true,
          try_as_border = true,
        },
        symbol = "▌"
      })
      pairs.setup()
      surround.setup()
      trailspace.setup()

      -- Mini keymaps
      vim.keymap.set('n', '<C-t>', trailspace.trim, { desc = '[T]rim Trailing Whitespace' })
    end
  },
}
