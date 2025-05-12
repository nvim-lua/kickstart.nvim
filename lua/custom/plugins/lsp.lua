return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = { 'lua_ls', 'pyright', 'tsserver' },
    }

    local lspconfig = require 'lspconfig'
    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end

    -- Example: Lua Language Server
    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        },
      },
    }
  end,
}
