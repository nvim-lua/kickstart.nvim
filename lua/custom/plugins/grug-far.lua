return {
  {
    'MagicDuck/grug-far.nvim',
    init = function()
      -- vim.g.copilot_enabled = false
      vim.keymap.set('n', '<leader>g', ':GrugFar<CR>')
    end,
    config = function()
      require('grug-far').setup {
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      }
    end,
  },
}
