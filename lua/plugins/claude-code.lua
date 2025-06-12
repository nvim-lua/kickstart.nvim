return {
  'greggh/claude-code.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for git operations
  },
  config = function()
    require('claude-code').setup {
      window = {
        split_ratio = 0.5,
        position = 'botright',
        enter_insert = true,
        hide_numbers = true,
        hide_signcolumn = true,
      },
    }
  end,
  keys = {
    { '<leader>lc', '<cmd>ClaudeCode<cr>', desc = '[C]laude Code' },
  },
}
