return {
  { -- LazyGit
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    opts = {
      default_mappings = false, -- mappings live in lua/config/keymaps.lua
      default_commands = true,
      disable_diagnostics = false,
      list_opener = 'copen',
      highlights = { -- Must have a background color
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    },
  },
}
