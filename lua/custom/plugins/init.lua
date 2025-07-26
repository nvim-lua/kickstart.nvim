-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Bootstrap lazy.nvim
return {
  {
    {
      'ray-x/go.nvim',
      dependencies = {
        'ray-x/guihua.lua', -- required UI library
        'nvim-treesitter/nvim-treesitter',
        'neovim/nvim-lspconfig',
      },
      ft = { 'go', 'gomod' },
      config = function()
        require('go').setup {
          lsp_cfg = true, -- auto-setup gopls
          lsp_on_attach = function(client, bufnr)
            -- Auto format on save
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
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = true,
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
  },
}
