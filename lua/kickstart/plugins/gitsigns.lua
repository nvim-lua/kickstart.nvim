-- Adds git related signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns` to understand what the configuration keys do

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
