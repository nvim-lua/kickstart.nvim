-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Bootstrap lazy.nvim
return {
  {
    -- If you want neo-tree's file operations to work with LSP (updating imports, etc.), you can use a plugin like
    -- https://github.com/antosha417/nvim-lsp-file-operations:
    -- {
    --   "antosha417/nvim-lsp-file-operations",
    --   dependencies = {
    --     "nvim-lua/plenary.nvim",
    --     "nvim-neo-tree/neo-tree.nvim",
    --   },
    --   config = function()
    --     require("lsp-file-operations").setup()
    --   end,
    -- },

    -- Add this in the plugins table

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
