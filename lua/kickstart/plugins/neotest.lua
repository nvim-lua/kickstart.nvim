return {
  'nvim-neotest/neotest',
  dependencies = { 'haydenmeade/neotest-jest' },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    }
  end,
}
