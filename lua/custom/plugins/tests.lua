return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
  },
  opts = {},
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-go',
      },
      output_panel = {
        enabled = true,
        open = 'botright split | resize 15',
      },
      quickfix = {
        open = false,
      },
    }
    vim.keymap.set('n', '<leader>t', "<cmd>lua require('neotest').run.run()<CR>", { desc = 'Run Test' })
    vim.keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = 'Run Test File' })
    vim.keymap.set('n', '<leader>td', "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<CR>", { desc = 'Run Current Test Directory' })
    vim.keymap.set('n', '<leader>tp', "<cmd>lua require('neotest').output_panel.toggle()<CR>", { desc = 'Toggle Test Output Panel' })
    vim.keymap.set('n', '<leader>tl', "<cmd>lua require('neotest').run.run_last()<CR>", { desc = 'Run Last Test' })
    vim.keymap.set('n', '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = 'Toggle Test Summary' })
  end,
}
