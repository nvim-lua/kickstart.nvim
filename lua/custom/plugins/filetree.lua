vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {
      window = {
        width = 30,
        mappings = {
          ["o"] = "open",
          ["sv"] = "open_vsplit",
        }
      }
    }
    vim.keymap.set('n', '<leader>sn', ':Neotree filesystem reveal float<CR>', { noremap = true, silent = true })
  end,
}
