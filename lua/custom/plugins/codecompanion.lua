return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- The following are optional:
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat<cr>', desc = 'Start chat' },
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
  end,
}
