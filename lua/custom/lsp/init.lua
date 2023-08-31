local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end


require "custom.lsp.mason"
require "custom.lsp.null-ls"
