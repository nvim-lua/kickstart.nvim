return {
  {
    'ray-x/go.nvim',
    ft = { 'go', 'gomod' },
    dependencies = {
      'ray-x/guihua.lua',
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('go').setup {
        lsp_cfg = true,
        lsp_on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('GoFormat', { clear = true }),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
  },
}
