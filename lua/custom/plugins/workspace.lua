return {
  {
    'KrzysiekWyka/workspace.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('workspace').setup {
        workspaces = {
          { name = 'Work', path = '~/development/nodejs/work', keymap = { '<leader>w' } },
        },
      }

      local workspace = require 'workspace'
      vim.keymap.set('n', '<leader>ps', workspace.tmux_sessions)
    end,
  },
}
