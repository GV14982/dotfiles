return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0
            }
          }
        }
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    config = function()
      -- Switch for controlling whether you want autoformatting.
      --  Use :AutoFormatToggle to toggle autoformatting on or off
      local format_is_enabled = true
      vim.api.nvim_create_user_command('AutoFormatToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      end, {})

      -- Create an augroup that is used for managing our formatting autocmds.
      --      We need one augroup per client to make sure that multiple clients
      --      can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = 'lsp-format-' .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      -- Whenever an LSP attaches to a buffer, we will run this function.
      --
      -- See `:help LspAttach` for more information about this autocmd event.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          if client == nil then
            return
          end

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Tsserver usually works poorly. Ideally this should be handled by prettier
          if client.name == 'ts_ls' or client.name == 'html' or client.name == 'jsonls' or client.name == 'cssls' then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
            end,
          })
        end,
      })
      -- [[ Configure LSP ]]
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        local builtin = require('telescope.builtin')

        -- See `:help K` for why this keymap
        nmap('K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, 'Hover Documentation')
        nmap('<C-k>', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, 'Signature Documentation')
        nmap('<leader>le', function() vim.diagnostic.open_float({ border = 'rounded' }) end, 'Show [E]rror')
        nmap('<leader>lr', vim.lsp.buf.rename, '[R]ename')
        nmap('<leader>lc', vim.lsp.buf.code_action, '[C]ode action')
        -- Goto
        nmap('<leader>lgd', builtin.lsp_definitions, 'Goto [D]efinition')
        nmap('<leader>lgr', builtin.lsp_references, 'Goto [R]eferences')
        nmap('<leader>lgi', builtin.lsp_implementations, 'Goto [I]mplementation')
        nmap('<leader>lgD', builtin.lsp_type_definitions, 'Goto Type [D]efinition')
        -- Workspace
        nmap('<leader>lws', builtin.lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')
        nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, 'Workspace [A]dd Folder')
        nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'Workspace [R]emove Folder')
        nmap('<leader>lwl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        nmap('<leader>lds', builtin.lsp_document_symbols, 'Document [S]ymbols')
        nmap('<leader>ldt', function()
          if vim.lsp.inlay_hint.is_enabled(bufnr) then
            vim.lsp.inlay_hint.disable(bufnr)
          else
            vim.lsp.inlay_hint.enable(bufnr)
          end
        end, 'Document Inlay Hint [T]oggle')
      end

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      local servers = {
        -- Web
        html = {},
        cssls = {},
        cssmodules_ls = {},
        htmx = {},
        tailwindcss = {},
        angularls = {},
        emmet_language_server = {},
        graphql = {},
        astro = {},
        ts_ls = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          },
        },
        -- Config
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            hint = {
              enable = true
            }
          },
        },
        dockerls = {},
        docker_compose_language_service = {},
        jsonls = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true }
          }
        },
        taplo = {},
        yamlls = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
        -- System
        gopls = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            }
          }
        },
        rust_analyzer = {},
        -- Other
        templ = {},
        bashls = {},
        eslint = {},
        marksman = {},
        lemminx = {},
        typos_lsp = {},
      }

      local serverNames = {}
      for server, _ in pairs(servers) do
        table.insert(serverNames, server)
      end

      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      require('mason-lspconfig').setup({
        ensure_installed = serverNames,
        automatic_installation = true,
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
              on_attach = on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            }
          end,
        }
      })

      require('lspconfig').gleam.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        -- Uncomment this to use the glas LSP
        -- cmd = { "glas", "--stdio" },
        filetypes = { "gleam" },
        single_file_support = true
      }
      require('lspconfig').postgres_lsp.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "sql" },
      }
    end,
  },
}
