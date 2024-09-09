return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    keys = {
      {
        '<leader>ccq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'CopilotChat Buffer chat',
      },
      {
        '<leader>cct',
        '<cmd>CopilotChatToggle<CR>',
        desc = 'Copilot Chat Toggle',
      },
      -- {
      --   '<leader>ccs',
      --   'CopilotChatSave',
      --   desc = 'CopilotChat - Quick chat',
      -- },
    },
    opts = {
      debug = false, -- Enable debug logging
      window = {
        layout = 'float',
        relative = 'editor',
        title = 'Copilot',
        footer = '<C-i> to toggle chat | <C-l> to clean chat',
        width = 0.6,
        height = 0.5,
        row = 0,
        border = 'rounded', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      },
    },
  },
}
