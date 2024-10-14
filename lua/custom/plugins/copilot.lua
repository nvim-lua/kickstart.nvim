return {
  {
    'github/copilot.vim',
    init = function()
      -- vim.g.copilot_enabled = false
      vim.keymap.set('i', '<M-;>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<M-/>', '<Plug>(copilot-dismiss)')
    end,
    --
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'github/copilot.vim' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'float',
        relative = 'cursor',
        width = 1,
        height = 0.4,
        row = 1,
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
    --
    -- keys = {
    --   {
    --     '<leader>ccq',
    --     function()
    --       local input = vim.fn.input 'Quick Chat: '
    --       if input ~= '' then
    --         -- require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
    --         require('CopilotChat').ask(input)
    --       end
    --     end,
    --     desc = 'CopilotChat - Quick chat',
    --   },
    -- },
  },
}
