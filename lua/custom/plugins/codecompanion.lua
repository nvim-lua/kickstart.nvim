return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim',
    -- The following are optional:
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },
  init = function()
    require('custom.plugins.codecompanion.fidget-spinner'):init()
  end,
  config = function()
    require('codecompanion').setup {
      adapters = {
        anthropic = require('codecompanion.adapters').extend('anthropic', {
          env = {
            api_key = 'CODECOMP_ANTHROPIC_API_KEY',
          },
        }),
        deepseek = require('codecompanion.adapters').extend('deepseek', {
          env = {
            api_key = 'CODECOMP_DEEPSEEK_API_KEY',
          },
        }),
      },
      strategies = {
        chat = {
          adapter = 'anthropic',
          slash_commands = {
            ['file'] = {
              -- Location to the slash command in CodeCompanion
              callback = 'strategies.chat.slash_commands.file',
              description = 'Select a file using FZF',
              opts = {
                provider = 'fzf_lua', -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                contains_code = true,
              },
            },
          },
        },
        inline = {
          adapter = 'anthropic',
        },
      },
    }

    vim.keymap.set('n', '<leader>mc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[CodeCompanion] Toggle chat' })
    vim.keymap.set('v', '<leader>mc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = '[CodeCompanion] Toggle chat' })
    vim.keymap.set('n', '<leader>mp', '<cmd>CodeCompanionActions<cr>', { desc = '[CodeCompanion] Action' })
    vim.keymap.set('v', '<leader>ma', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true, desc = '[CodeCompanion] Add selection to chat' })
  end,
}
