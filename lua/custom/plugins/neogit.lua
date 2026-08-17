return {
  'NeogitOrg/neogit',
  lazy = true,
  dependencies = {
    -- Only one of these is needed.
    {
      'sindrets/diffview.nvim', -- optional
      opts = {
        keymaps = {
          view = { q = '<cmd>DiffviewClose<CR>' },
          file_panel = { q = '<cmd>DiffviewClose<CR>' },
          file_history_panel = { q = '<cmd>DiffviewClose<CR>' },
        },
      },
    },

    -- For a custom log pager
    'm00qek/baleia.nvim', -- optional

    -- Only one of these is needed.
    'nvim-telescope/telescope.nvim', -- optional
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
  },
}
