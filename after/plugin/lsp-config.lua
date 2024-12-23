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
  -- 'jdtls',
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

lsp.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set('n', 'gD', function()
    vim.lsp.buf.declaration()
  end, opts)
  vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set('n', '<leader>vws', function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set('n', '<leader>vd', function()
    vim.diagnostic.open_float()
  end, opts)

  vim.keymap.set('n', '[d', function()
    vim.diagnostic.goto_next()
  end, opts)

  vim.keymap.set('n', ']d', function()
    vim.diagnostic.goto_prev()
  end, opts)

  vim.keymap.set('n', '<leader>dd', function()
    vim.diagnostic.setloclist()
  end, opts)

  vim.keymap.set('n', '<leader>do', function()
    vim.diagnostic.open_float()
  end, opts)

  vim.keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, opts)

  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)

  vim.keymap.set('n', '<leader>rn', function()
    vim.lsp.buf.rename()
  end, opts)

  vim.keymap.set('n', '<leader>lf', function()
    require('conform').format()
  end, { desc = 'Format Buffer' })

  -- Add WorkSpace
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)

  -- Remove WorkSpace
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)

  -- List WorkSpace
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
end)

lsp.setup()

vim.diagnostic.config {
  virtual_text = true,
}
