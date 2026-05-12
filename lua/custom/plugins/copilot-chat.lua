-- CopilotChat: in-nvim chat using your existing GitHub Copilot auth.
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    'github/copilot.vim',
    'nvim-lua/plenary.nvim',
  },
  build = 'make tiktoken',
  cmd = { 'CopilotChat', 'CopilotChatOpen', 'CopilotChatToggle', 'CopilotChatExplain', 'CopilotChatReview', 'CopilotChatFix', 'CopilotChatTests', 'CopilotChatCommit' },
  opts = {
    model = 'gpt-4o',
    window = {
      layout = 'float',
      width = 0.8,
      height = 0.8,
      border = 'rounded',
    },
    show_help = true,
    auto_follow_cursor = false,
  },
  keys = {
    { '<leader>cc', '<cmd>CopilotChatToggle<cr>',  mode = { 'n', 'x' }, desc = '[C]opilot [C]hat' },
    { '<leader>ce', '<cmd>CopilotChatExplain<cr>', mode = { 'n', 'x' }, desc = '[C]opilot [E]xplain' },
    { '<leader>cf', '<cmd>CopilotChatFix<cr>',     mode = { 'n', 'x' }, desc = '[C]opilot [F]ix' },
    { '<leader>cr', '<cmd>CopilotChatReview<cr>',  mode = { 'n', 'x' }, desc = '[C]opilot [R]eview' },
    { '<leader>ct', '<cmd>CopilotChatTests<cr>',   mode = { 'n', 'x' }, desc = '[C]opilot [T]ests' },
    { '<leader>cm', '<cmd>CopilotChatCommit<cr>',                     desc = '[C]opilot co[M]mit msg' },
  },
}
