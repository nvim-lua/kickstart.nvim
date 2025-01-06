return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    require('neo-tree').setup {
      close_if_last_window = true,
    }

    vim.keymap.set('n', '<leader>nf', ':Neotree show float toggle<CR>', { desc = '[N]eoTree [F]loat Toggle' })
    vim.keymap.set('n', '<leader>nr', ':Neotree show toggle<CR>', { desc = '[N]eoTree [R]eveal Toggle' })
  end,
}
