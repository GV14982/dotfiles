return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      local enabled_modules = {
        { name = 'align' },
        {
          name = 'clue',
          config = function(plugin)
            return {
              window = {
                delay = 500,
              },
              triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Marks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },
              },

              clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                plugin.gen_clues.builtin_completion(),
                plugin.gen_clues.g(),
                plugin.gen_clues.marks(),
                plugin.gen_clues.registers(),
                plugin.gen_clues.windows(),
                plugin.gen_clues.z(),
                { mode = 'n', keys = '<Leader>s', desc = '[S]earch' },
                { mode = 'n', keys = '<Leader>t', desc = '[T]rouble' },
                { mode = 'n', keys = '<Leader>w', desc = '[W]orkspace' },
                { mode = 'n', keys = '<Leader>c', desc = '[C]ode' },
              },
            }
          end
        },
        { name = 'comment' },
        { name = 'cursorword' },
        { name = 'diff' },
        { name = 'git' },
        {
          name = 'indentscope',
          config = function(plugin)
            return {
              draw = {
                animation = plugin.gen_animation.none(),
                delay = 0,
                priority = 1
              },
              options = {
                indent_at_cursor = true,
                try_as_border = true,
              },
              symbol = '▌'
            }
          end,
        },
        { name = 'pairs' },
        { name = 'statusline' },
        { name = 'surround' },
        {
          name = 'trailspace',
          config = function(plugin)
            vim.keymap.set('n', '<C-t>', plugin.trim, { desc = '[T]rim Trailing Whitespace' })
            return {}
          end
        },
      }

      for _, value in pairs(enabled_modules) do
        local name = value.name
        local configFunc = value.config
        local plugin = require('mini.' .. name)
        local _, result = pcall(configFunc, plugin)
        if type(result) ~= 'table' then
          result = {}
        end
        plugin.setup(result)
      end
    end
  },
}
