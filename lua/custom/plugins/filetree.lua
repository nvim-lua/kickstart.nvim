return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    local neo_tree = require('neo-tree')
    local command = require('neo-tree.command')

    neo_tree.setup {}

    vim.keymap.set('n', '<leader>ff', function ()
      command.execute({ action = 'focus', reveal = true })
    end, { desc = 'Filetree: Open file tree' })
    vim.keymap.set('n', '<leader>fb', function ()
      command.execute({ action = 'focus', source = 'buffers', reveal = true })
    end, { desc = 'Filetree: Open Buffers' })
  end,
}
