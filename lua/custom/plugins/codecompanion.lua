return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- The following are optional:
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },
  config = function()
    require('codecompanion').setup {
      adapters = {
        anthropic = require('codecompanion.adapters').extend('anthropic', {
          env = {
            api_key = 'CODECOMP_ANTHROPIC_API_KEY',
          },
        }),
      },
      strategies = {
        chat = {
          adapter = 'anthropic',
        },
        inline = {
          adapter = 'anthropic',
        },
      },
    }

    vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat<cr>', { desc = '[CodeCompanion] Start chat' })
    vim.keymap.set('v', '<leader>ca', '<cmd>CodeCompanion<cr>', { desc = '[CodeCompanion] Inline chat' })
  end,
}
