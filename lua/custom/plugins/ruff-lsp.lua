return {
    "astral-sh/ruff-lsp",
    config = function()
        local on_attach = function(client, bufnr)
            client.server_capabilities.hoverProvider = false
        end

        require("lspconfig").ruff_lsp.setup {
            on_attach = on_attach,
        }
    end
}
