local rt = require('rust-tools')

rt.setup({
    tools = {
        inlay_hints = {
            auto = true,
        },
    },
    server = {
        on_attach = function (client, bufnr)
            local opts = {buffer = bufnr, remap = false}
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
        end
    }
})
