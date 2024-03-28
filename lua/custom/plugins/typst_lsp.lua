return { require 'lspconfig'.typst_lsp.setup {
    settings = {
        exportPdf = "never" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
    }
} }
