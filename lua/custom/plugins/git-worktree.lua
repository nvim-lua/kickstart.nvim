-- Git worktree management with Telescope integration
-- https://github.com/ThePrimeagen/git-worktree.nvim

return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('git-worktree').setup {
      -- change_directory_command = 'cd',  -- default
      -- update_on_change = true,          -- default
      -- clearjumps_on_change = true,      -- default
    }
    require('telescope').load_extension 'git_worktree'
  end,
  keys = {
    {
      '<leader>gw',
      function()
        require('telescope').extensions.git_worktree.git_worktrees()
      end,
      desc = 'Git [W]orktrees',
    },
    {
      '<leader>gc',
      function()
        require('telescope').extensions.git_worktree.create_git_worktree()
      end,
      desc = 'Git [C]reate worktree',
    },
  },
}

