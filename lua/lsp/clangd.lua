local tools = require 'utils.tools'

-- Get LSP capabilities with cmp support
local capabilities = tools.get_lsp_capabilities()

-- Setup clangd LSP using autocmd
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'h', 'hpp' },
  callback = function()
    local clangd_path = tools.find_executable 'clangd'

    if clangd_path then
      vim.lsp.start {
        name = 'clangd',
        cmd = {
          clangd_path,
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        root_dir = vim.fs.dirname(vim.fs.find({ 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git' }, { upward = true })[1]),
        capabilities = capabilities,
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      }
    end
  end,
})

-- Return empty config since we handle clangd LSP manually via autocmd above
return {}
