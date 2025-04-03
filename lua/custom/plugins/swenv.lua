return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-dap-python', --optional
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  },
  lazy = false,
  branch = 'regexp', -- This is the regexp branch, use this for the new version
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select Python Viertual Environment' },
    { '<leader>vc', '<cmd>VenvSelectCached<cr>', desc = 'Load Python Virtual Environment From Cache' },
  },
  ---@type venv-selector.Config
  opts = {},
}
