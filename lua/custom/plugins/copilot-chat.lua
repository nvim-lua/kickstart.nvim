return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    init = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      map('n', '<leader>ch', '<Cmd>CopilotChatToggle<CR>', opts)
    end,
    opts = {
      -- See Configuration section for options
    },
  },
}
