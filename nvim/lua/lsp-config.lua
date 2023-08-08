local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.ensure_installed({
    'tsserver',
    'eslint',
    'solc',
    'angularls',
    'gopls',
    'html',
    'jsonls',
    'graphql',
    'cssls',
    'emmet_ls',
    'svelte',
    'dockerls',
    'prismals',
    'taplo',
    'lua_ls',
    'sqlls',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({select = true}),
})

lsp.set_preferences({
    sign_icons = {}
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

-- config.rust_analyzer.setup({
--     inlayHints = {
--         enable = true,
--         chainingHint = true,
--         typeHints = false,
--         parameterHints = false
--     }
-- })

lsp.on_attach(function (client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()
