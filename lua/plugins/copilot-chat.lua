return {
  'CopilotC-Nvim/CopilotChat.nvim',
  cmd = { 'CopilotChat', 'CopilotChatToggle', 'CopilotChatOpen' },
  dependencies = {
    'zbirenbaum/copilot.lua',
    'nvim-lua/plenary.nvim',
  },
  opts = {
    window = {
      layout = 'vertical',
    },
  },
}
