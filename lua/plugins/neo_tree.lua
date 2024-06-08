return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    {
      '<leader>nt',
      function()
        require('neo-tree.command').execute { toggle = true }
      end,
      desc = 'Explorer NeoTree (Root Dir)',
    },
  },
  opts = {
    close_if_last_window = true,
    use_libuv_file_watcher = true,
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.cmd [[
              setlocal relativenumber
            ]]
        end,
      },
    },
  },
}
