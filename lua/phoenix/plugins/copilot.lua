return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = "InsertEnter",
    build = ':Copilot auth',
    config = function()
      require('copilot').setup {
        -- panel = {
        --   enabled = false, -- using nvim-cmp to do this
        --   -- enabled = true,
        --   -- keymap = { open = '<C-t>' },
        --   -- layout = { position = "right", ratio = 0.2 }
        -- },
        suggestion = { enabled = true, auto_trigger = true, keymap = { accept = '<Tab>' } },
        -- filetypes = { markdown = true, gitcommit = true, help = true },
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' },  -- for curl, log wrapper
    },
    opts = {},
    keys = {
      -- lazy.nvim keys

      -- Quick chat with Copilot
      {
        '<leader>ccq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },

      -- lazy.nvim keys

      -- Show help actions with telescope
      {
        '<leader>cch',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ccp',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
    },
  },
}
