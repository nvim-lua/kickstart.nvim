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

    vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[CodeCompanion] Toggle chat' })
    vim.keymap.set('v', '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[CodeCompanion] Toggle chat' })
    vim.keymap.set('n', '<leader>cp', '<cmd>CodeCompanionActions<cr>', { desc = '[CodeCompanion] Action' })
    vim.keymap.set('v', '<leader>ca', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true, desc = '[CodeCompanion] Add selection to chat' })
  end,
}
