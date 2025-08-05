-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'AndrewRadev/tagalong.vim',
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true,           -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = false,
          },
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local conform = require('conform')

      conform.setup({
        formatters_by_ft = {
          lua = { 'stylelua' },
          typescript = { 'prettierd', 'prettier', 'biome' },
          typescriptreact = { 'prettierd', 'prettier', 'biome' },
          javascript = { 'prettierd', 'prettier', 'biome' },
          javascriptreact = { 'prettierd', 'prettier', 'biome' },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        }
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = 'Format file or range (in visual mode)' })
    end,
  },
}
