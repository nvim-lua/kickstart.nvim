-- [[ Configure LSP ]]
local lsp = require 'lsp-zero'

lsp.preset 'recommended'

lsp.ensure_installed {
  'rust_analyzer',
  -- Python
  -- 'mypy',
  -- 'black',
  -- 'isort',
  -- 'ruff_lsp',
  'pyright',
  -- Java Stuffs
  'jdtls',
  -- 'google-java-format',
  -- Golang
  -- 'gofumpt',
  -- 'goimports-reviser',
  -- 'golines',
  'gopls',
  'templ',
  'htmx',
  -- Typescript
  -- 'prettier',
  -- 'prettierd',
  -- 'tsserver',
  -- Others
  'tailwindcss',
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm { select = true },
  ['<C-Space>'] = cmp.mapping.complete(),
}

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp {
  mapping = cmp_mappings,
}

lsp.set_preferences {
  suggest_lsp_servers = false,
  sign_icons = {
    error = '⛔️',
    warn = '⚠️',
    hint = '🧐',
    info = 'I',
  },
}

local function on_attach(client, bufnr)
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

lsp.on_attach(on_attach)
lsp.setup()

vim.diagnostic.config {
  virtual_text = true,
}

local function on_attach(client, bufnr)
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

lsp.on_attach(on_attach)
lsp.setup()

vim.diagnostic.config {
  virtual_text = true,
}

return {
  capabilities = capabilities,
  on_attach = on_attach,
}
