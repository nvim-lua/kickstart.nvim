-- Navigation and file management plugins
return {
  -- Tmux integration
  { 'christoomey/vim-tmux-navigator' },

  -- File explorer (edit directories like buffers)
  {
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
    config = function()
      require('oil').setup {
        view_options = { show_hidden = true },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  -- File tagging/bookmarks
  {
    'cbochs/grapple.nvim',
    dependencies = { { 'nvim-tree/nvim-web-devicons', lazy = true } },
    opts = {
      scope = 'git_branch',
      icons = false,
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<leader>k', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple toggle tags' },
      { '<leader>K', '<cmd>Grapple toggle_scopes<cr>', desc = 'Grapple toggle scopes' },
      { '<leader>j', '<cmd>Grapple cycle forward<cr>', desc = 'Grapple cycle forward' },
      { '<leader>J', '<cmd>Grapple cycle backward<cr>', desc = 'Grapple cycle backward' },
      { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Grapple select 1' },
      { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Grapple select 2' },
      { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select 3' },
      { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Grapple select 4' },
      { '<leader>5', '<cmd>Grapple select index=5<cr>', desc = 'Grapple select 5' },
    },
  },

  -- Jump motions
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },
}
