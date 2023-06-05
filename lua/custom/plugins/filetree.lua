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
    require('neo-tree').setup {}
  end,

  -- Keymaping
  init = function()
    vim.keymap.set('n', '<leader>te', '<Cmd>Neotree toggle<CR>', {desc = '[T]oggle Neotree [E]xplorer'})
  end,
}
