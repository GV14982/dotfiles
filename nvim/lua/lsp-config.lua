-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  require('lsp_signature').on_attach()
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

require('nvim-lsp-installer').setup {
  automatic_installation = true,
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4
}

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      telemety = {
        enable = false
      }
    }
  }
}

local lsp_opts = { on_attach = on_attach, capabilities = capabilities }


lspconfig.gopls.setup(lsp_opts)
lspconfig.tsserver.setup(lsp_opts)
lspconfig.sqls.setup(lsp_opts)
lspconfig.solc.setup(lsp_opts)
lspconfig.html.setup(lsp_opts)
lspconfig.jsonls.setup(lsp_opts)
lspconfig.emmet_ls.setup(lsp_opts)
lspconfig.graphql.setup(lsp_opts)
lspconfig.eslint.setup(lsp_opts)
lspconfig.dockerls.setup(lsp_opts)
lspconfig.taplo.setup(lsp_opts)
lspconfig.rust_analyzer.setup(lsp_opts)
lspconfig.svelte.setup(lsp_opts)
lspconfig.angularls.setup(lsp_opts)
lspconfig.cssls.setup(lsp_opts)
lspconfig.prismals.setup(lsp_opts)

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
})
