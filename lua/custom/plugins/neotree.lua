return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  init = function()
    -- Neotree:
    vim.keymap.set('n', '<leader>nt', '<Cmd>Neotree toggle<CR>', { desc = '[N]eo[t]ree toggle' })
    vim.keymap.set('n', '<leader>ntr', '<Cmd>Neotree reveal<CR>', { desc = 'N[E]eo[t]ree toggle cu[r]rent' })
  end,
  config = function()
    require('neo-tree').setup {
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
    }
  end,
}
