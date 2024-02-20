-- require 'lspconfig'.grammarly.setup {
--   filetypes = { "markdown", "tex", "go" },
-- }
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '»' })

-- lspconfig = require 'lspconfig'
-- lspconfig.tailwindcss.setup({
--   -- on_attach = on_attach,
--   -- capabilities = capabilities,
--   filetypes = { "html", "templ", "astro", "javascript", "typescript", "react" },
-- })

vim.filetype.add({ extension = { templ = "templ" } })
