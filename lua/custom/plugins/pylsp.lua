local lspconfig = require 'lspconfig'
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = false },
        autopep8 = { enabled = true },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = false, executable = 'pylint' },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = true, maxLineLength = 200 },
        -- type checker
        pylsp_mypy = { enabled = true, live_mode = true, strict = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
        rope_autoimport = {
          enabled = false,
          completions = { enabled = true },
          code_actions = { enabled = true },
        },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = lsp_capabilities,
}

return {}
