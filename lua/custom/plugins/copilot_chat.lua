return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      context = 'buffer',
    },
    keys = {
      {
        '<leader>aa',
        function()
          local chat = require 'CopilotChat'
          chat.toggle()
        end,
        desc = 'Copilot toggle chat',
      },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'Copilot quick chat',
      },
      {
        '<leader>ax',
        function()
          local chat = require 'CopilotChat'
          chat.reset()
        end,
        desc = 'Copilot chat reset',
      },
      {
        '<leader>ap',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'Copilot chat prompt actions',
      },
    },
  },
}
