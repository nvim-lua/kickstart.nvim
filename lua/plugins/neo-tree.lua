return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      window = {
        position = 'right', -- Ensure Neo-Tree opens on the right
      },
      filesystem = {
        follow_current_file = true, -- Automatically reveal the current file
        use_libuv_file_watcher = true, -- Auto-refresh when files change
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
        },
      },
    },
    keys = {
      {
        '<leader>fe',
        function()
          vim.cmd 'Neotree toggle right' -- Open Neo-Tree on the right side
        end,
        desc = 'Toggle Neo-Tree (Right Side)',
      },
      {
        '<leader>fE',
        function()
          vim.cmd 'Neotree focus' -- Focus on the Neo-Tree window
        end,
        desc = 'Focus Neo-Tree',
      },
      { '<leader>e', '<leader>fe', desc = 'Toggle Neo-Tree', remap = true },
      { '<leader>E', '<leader>fE', desc = 'Focus Neo-Tree',  remap = true },
    },
  },
}
