return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-jest',
    'marilari88/neotest-vitest',
    'alfaix/neotest-gtest',
  },
  keys = {
    {
      '<leader>nr',
      function()
        require('neotest').run.run()
      end,
      desc = '[N]eotest run nea[r]est',
    },
    {
      '<leader>nf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = '[N]eotest run [F]ile',
    },
    {
      '<leader>ns',
      function()
        require('neotest').run.run(vim.fn.getcwd())
      end,
      desc = '[N]eotest run [S]uite',
    },
    {
      '<leader>nd',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = '[N]eotest [D]ebug nearest',
    },
    {
      '<leader>nn',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[N]eotest summary',
    },
    {
      '<leader>no',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = '[N]eotest [O]utput',
    },
    {
      '<leader>nO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = '[N]eotest [O]utput panel',
    },
    {
      '<leader>na',
      function()
        require('neotest').run.attach()
      end,
      desc = '[N]eotest [A]ttach',
    },
    {
      '<leader>nS',
      function()
        require('neotest').run.stop()
      end,
      desc = '[N]eotest [S]top',
    },
  },
  config = function()
    local adapters = {}

    local ok_jest, jest = pcall(require, 'neotest-jest')
    if ok_jest then
      table.insert(adapters, jest {})
    end

    local ok_vitest, vitest = pcall(require, 'neotest-vitest')
    if ok_vitest then
      table.insert(adapters, vitest {})
    end

    local ok_gtest, gtest = pcall(require, 'neotest-gtest')
    if ok_gtest then
      table.insert(adapters, gtest.setup {})
    end

    require('neotest').setup {
      adapters = adapters,
    }
  end,
}
