return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      'ghassan0/telescope-glyph.nvim',
      'xiyaowong/telescope-emoji.nvim',
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local telescope = require('telescope')
      telescope.setup {
        defaults = {
          mappings = {
            n = {
              ['<C-d>'] = "results_scrolling_down",
              ['<C-u>'] = "results_scrolling_up",
            },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      telescope.load_extension('project')
      telescope.load_extension('file_browser')
      telescope.load_extension('emoji')
      telescope.load_extension('glyph')
    end
  },
}
