local tools = require 'utils.tools'

-- Get LSP capabilities with cmp support
local capabilities = tools.get_lsp_capabilities()

-- Setup gopls LSP using autocmd
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    local gopls_path = tools.find_executable 'gopls'

    if gopls_path then
      vim.lsp.start {
        name = 'gopls',
        cmd = { gopls_path },
        root_dir = vim.fs.dirname(vim.fs.find({ 'go.mod', 'go.work', '.git' }, { upward = true })[1]),
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
            completeUnimported = true,
            usePlaceholders = true,
            experimentalPostfixCompletions = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      }
    end
  end,
})

-- Return empty config since we handle gopls LSP manually via autocmd above
return {}
