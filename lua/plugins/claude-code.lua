return {
  {
    'greggh/claude-code.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for git operations
    },
    config = function()
      require('claude-code').setup {
        window = {
          position = 'float',
        },
        keymaps = {
          toggle = {
            normal = '<leader>c', -- Normal mode keymap for toggling Claude Code, false to disable
            terminal = 'false', -- Terminal mode keymap for toggling Claude Code, false to disable
            -- variants = {
            --   continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
            --  verbose = "<leader>cV",  -- Normal mode keymap for Claude Code with verbose flag
            --},
          },
          window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
          scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
        },
      }
    end,
  },
}
