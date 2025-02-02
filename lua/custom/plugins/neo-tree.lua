return {
  {
    -- Add neo-tree
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
        window = {
          width = 30,
          mappings = {
            ['<space>'] = {
              'toggle_node',
              nowait = false,
            },
            ['<cr>'] = 'open',
            ['P'] = { 'toggle_preview', config = { use_float = true } },
            ['l'] = 'focus_preview',
          },
        },
      }

      -- Keymaps
      vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { silent = true })
      vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { silent = true })
    end,
  },
}
