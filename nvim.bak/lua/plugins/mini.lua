return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      local enabled_modules = {
        { name = 'ai' },
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
                { mode = 'n', keys = '<Leader>a',  desc = '[A]vante' },
                { mode = 'n', keys = '<Leader>s',  desc = '[S]earch' },
                { mode = 'n', keys = '<Leader>t',  desc = '[T]rouble' },
                { mode = 'n', keys = '<Leader>w',  desc = '[W]orkspace' },
                { mode = 'n', keys = '<leader>l',  desc = '[L]sp' },
                { mode = 'n', keys = '<leader>lg', desc = '[G]oto' },
                { mode = 'n', keys = '<leader>lw', desc = '[W]orkspace' },
                { mode = 'n', keys = '<leader>ld', desc = '[D]ocument' },
                { mode = 'n', keys = '<Leader>d',  desc = '[D]AP' },
                { mode = 'n', keys = '<Leader>ds', desc = '[S]tep' },
                { mode = 'n', keys = '<Leader>du', desc = '[U]I' },
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
        { name = 'jump' },
        { name = 'jump2d' },
        { name = 'pairs' },
        { name = 'surround' },
        {
          name = 'trailspace',
          config = function(plugin)
            vim.keymap.set('n', '<C-t>', plugin.trim, { desc = '[T]rim Trailing Whitespace' })
            return {}
          end
        },
        { name = 'visits' }
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
