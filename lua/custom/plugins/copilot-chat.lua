return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    event = 'VeryLazy',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {},
    keys = {
      { '<leader>ho', '<cmd>CopilotChat<cr>', mode = { 'n', 'v' }, desc = 'CopilotChat - Open' },
      { '<leader>he', '<cmd>CopilotChatExplain<cr>', mode = { 'n', 'v' }, desc = 'CopilotChat - Explain code' },
      { '<leader>hr', '<cmd>CopilotChatReview<cr>', mode = { 'n', 'v' }, desc = 'CopilotChat - Review code' },
      -- { '<leader>hR', '<cmd>CopilotChatRefactor<cr>', mode = { 'n', 'v' }, desc = 'CopilotChat - Refactor code' },
      {
        '<leader>hf',
        '<cmd>CopilotChatFixDiagnostic<cr>', -- Get a fix for the diagnostic message under the cursor.
        desc = 'CopilotChat - Fix diagnostic',
      },
      {
        '<leader>hr',
        '<cmd>CopilotChatReset<cr>', -- Reset chat history and clear buffer.
        desc = 'CopilotChat - Reset chat history and clear buffer',
      },
    },
  },
}
