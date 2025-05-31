require('mason').setup()
require('mason-lspconfig').setup()

vim.lsp.enable 'rust_analyzer'
vim.lsp.enable 'pyright'

vim.lsp.enable 'jdtls'

vim.lsp.enable 'lua_ls'

vim.lsp.enable 'gopls'
vim.lsp.enable 'templ'
vim.lsp.enable 'htmx'

vim.lsp.enable 'jsonls'
vim.lsp.enable 'html'

vim.lsp.enable 'ts_ls'
vim.lsp.enable 'eslint'

vim.lsp.enable 'tailwindcss'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local function on_attach(bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>lf', function()
    require('conform').format()
  end, { buffer = bufnr, desc = 'Format Buffer' })
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    on_attach(ev.buf)
    -- local map = function(keys, func, desc)
    --   vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = 'Lsp: ' .. desc })
    -- end

    -- local tele = require 'telescope.builtin'
    -- map('gd', tele.lsp_definitions, 'Goto Definition')
    -- map('gr', tele.lsp_references, 'Goto References')
    --
    -- map('K', vim.lsp.buf.hover, 'hover')
    --
    -- map('n', '<leader>vws', vim.lsp.buf.workspace_symbol, 'Workspace Symbols')
    --
    -- map('n', '<leader>vd', vim.diagnostic.open_float, 'View Diagnostic')
    --
    -- map('n', '[d', vim.diagnostic.goto_next, 'Goto Next Diagnostic')
    -- map('n', ']d', vim.diagnostic.goto_prev, 'Goto Preview Diagnostic')
    -- map('n', '<leader>dd', vim.diagnostic.setloclist, 'List Diagnostics')
    -- map('n', '<leader>do', vim.diagnostic.open_float, 'List All Diagnostics')
    -- map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    --
    -- map('<leader>fs', tele.lsp_document_symbols, 'Doc Symbols')
    -- map('<leader>fS', tele.lsp_dynamic_workspace_symbols, 'Dynamic Symbols')
    -- map('<leader>ft', tele.lsp_type_definitions, 'Goto Type')
    -- map('<leader>fi', tele.lsp_implementations, 'Goto Impl')
    --
    -- map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
    -- map('n', '<leader>lf', function()
    --   require('conform').format()
    -- end, 'Format Buffer')
    --
    -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add WorkSpace')
    -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove WorkSpace')
    -- map('n', '<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, 'List Work Spaces')
  end,
})
-- vim.lsp.on_attach(on_attach)
-- vim.lsp.setup()
--
-- vim.diagnostic.config {
--   virtual_text = true,
-- }

-- Fix Undefined global 'vim'
-- vim.lsp.nvim_workspace()

-- local cmp = require 'cmp'
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = vim.lsp.defaults.cmp_mappings {
--   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--   ['<C-y>'] = cmp.mapping.confirm { select = true },
--   ['<C-Space>'] = cmp.mapping.complete(),
-- }

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

-- vim.lsp.setup_nvim_cmp {
--   mapping = cmp_mappings,
-- }

-- vim.lsp.set_preferences {
--   suggest_lsp_servers = false,
--   sign_icons = {
--     error = '⛔️',
--     warn = '⚠️',
--     hint = '🧐',
--     info = 'I',
--   },
-- }
