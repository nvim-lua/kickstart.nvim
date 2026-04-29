return {
  'coffebar/neovim-project',
  opts = {
    projects = { -- define project roots
      '~/project/dinobits/games/*',
      '~/project/dinobits/work/*/*',
      '~/project/linux/*',
      '~/project/jams/*/*',
      '~/.config/*',
    },
    picker = {
      type = 'telescope', -- one of "telescope", "fzf-lua", or "snacks"
    },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    -- optional picker
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
    -- optional picker
    { 'ibhagwan/fzf-lua' },
    -- optional picker
    { 'folke/snacks.nvim' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
  keys = {
    { '<leader>sp', ':NeovimProjectDiscover<CR>', desc = 'Neovim [P]roject Discover ([S]earch)', silent = true },
  },
}
