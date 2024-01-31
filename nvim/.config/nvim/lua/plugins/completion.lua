return {
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    priority = -1,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- Adds git support
      {
        'petertriho/cmp-git',
        dependencies = {
          'nvim-lua/plenary.nvim'
        }
      }
    },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local ls = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_snipmate').lazy_load()
      ls.filetype_extend("templ", { "go" })
      ls.filetype_extend("typescript", { "tsdoc" })
      ls.filetype_extend("javascript", { "jsdoc" })
      ls.filetype_extend("lua", { "luadoc" })
      ls.add_snippets("templ", {
        ls.s("templ",
          {
            ls.t("templ "),
            ls.i(1, "name"),
            ls.t("("),
            ls.i(2, "args"),
            ls.t(")"),
            ls.t({ "{", "\t" }),
            ls.i(3, "body"),
            ls.t({ "", "}" }),
          })
      })
      ls.setup({
        updateevents = "TextChanged,TextChangedI",
      })

      -- Check if there are any words before your current position on a line
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- Function for handling tab functionality with completion, returns a handler function that `cmp.mapping` is expecting
      local handle_cmp_tab = function(keys)
        -- Actual mapping handler function
        return function(fallback)
          vim.notify(tostring(ls.expand_or_locally_jumpable()), 0, nil)
          if keys == "<Tab>" and ls.expand_or_locally_jumpable() then
            ls.expand_or_jump()
          elseif keys == "<Tab>" and cmp.visible() then
            cmp.select_next_item()
          elseif keys == "<S-Tab>" and ls.expand_or_locally_jumpable(-1) then
            ls.expand_or_jump(-1)
          elseif keys == "<S-Tab>" and cmp.visible() then
            cmp.select_prev_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            ls.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(handle_cmp_tab("<Tab>"), { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(handle_cmp_tab("<S-Tab>"), { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'git' },
        },
      }

      require('cmp_git').setup();
    end
  },
}
