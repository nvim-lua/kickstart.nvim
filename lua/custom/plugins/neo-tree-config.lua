return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', desc = 'Open NeoTree' },
      { '<leader>n', desc = 'Focus NeoTree' },
    },
    config = function()
      local toggle_tree = function()
        vim.cmd 'Neotree toggle'
        vim.opt.relativenumber = true -- Use relative line numbers
      end

      -- Set up your custom keymaps
      vim.keymap.set('n', '<leader>e', toggle_tree, { desc = 'Open NeoTree' })
      vim.keymap.set('n', '<leader>n', function()
        vim.cmd 'Neotree focus'
      end, { desc = 'Focus NeoTree' })

      -- Setup neo-tree
      require('neo-tree').setup {}
    end,
  },
}
