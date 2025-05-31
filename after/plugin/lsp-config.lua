require('mason').setup()
require('mason-lspconfig').setup()

vim.lsp.enable 'rust_analyzer'
vim.lsp.enable 'pyright'

vim.lsp.enable 'jdtls'

vim.lsp.enable 'lua_ls'

vim.lsp.enable 'gopls'
vim.lsp.enable 'templ'

vim.lsp.enable 'dartls'
-- vim.lsp.enable 'htmx'

-- vim.lsp.enable 'jsonls'
-- vim.lsp.enable 'html'

vim.lsp.enable 'tsserver'
vim.lsp.enable 'eslint'

-- vim.lsp.enable 'tsserver'
vim.lsp.enable 'tailwindcss'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local function on_attach(bufnr)
  -- 'opts' table to avoid repetition for buffer and remap settings
  local opts = { buffer = bufnr, remap = false }

  -- Require Telescope for LSP-related functions
  local tele = require 'telescope.builtin'

  -- Set up keymaps with clear descriptions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Lsp: Goto Declaration', buffer = bufnr, remap = false })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Lsp: Hover Documentation', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, { desc = 'Lsp: Workspace Symbols', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, { desc = 'Lsp: View Line Diagnostic', buffer = bufnr, remap = false })
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, { desc = 'Lsp: Next Diagnostic', buffer = bufnr, remap = false })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, { desc = 'Lsp: Previous Diagnostic', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = 'Lsp: List Diagnostics', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = 'Lsp: Open Diagnostic Float', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Lsp: Code Action', buffer = bufnr, remap = false })
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = 'Lsp: Goto Definition', buffer = bufnr, remap = false })
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Lsp: Goto References', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Lsp: Rename Symbol', buffer = bufnr, remap = false })

  vim.keymap.set('n', '<leader>lf', function()
    require('conform').format { bufnr = bufnr }
  end, { buffer = bufnr, desc = 'Lsp: Format Buffer' })

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Lsp: Add Workspace Folder', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Lsp: Remove Workspace Folder', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = 'Lsp: List Workspace Folders', buffer = bufnr, remap = false })

  local tele = require 'telescope.builtin'

  vim.keymap.set('n', '<leader>fs', tele.lsp_document_symbols, { desc = 'Lsp: Document Symbols (Current File)', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>fS', tele.lsp_dynamic_workspace_symbols, { desc = 'Lsp: Workspace Symbols (Dynamic)', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>ft', tele.lsp_type_definitions, { desc = 'Lsp: Goto Type Definition', buffer = bufnr, remap = false })
  vim.keymap.set('n', '<leader>fi', tele.lsp_implementations, { desc = 'Lsp: Goto Implementations', buffer = bufnr, remap = false })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    on_attach(ev.buf)
  end,
})
