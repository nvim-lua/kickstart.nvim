return { -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      mappings = {
        -- Use tab for completion
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '',
        },
        show_diff = {
          full_diff = true,
        },
      },
    },
  },
}
