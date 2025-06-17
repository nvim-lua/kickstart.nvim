return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sidlatau/neotest-dart"
  },
  config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-dart') {
          command = 'flutter', -- Command being used to run tests. Defaults to `flutter`
          -- Change it to `fvm flutter` if using FVM
          -- change it to `dart` for Dart only tests
          use_lsp = true, -- When set Flutter outline information is used when constructing test name.
          -- Useful when using custom test names with @isTest annotation
          custom_test_method_names = {},
        },
      },
    })

    local neotest = require('neotest')

    vim.keymap.set('n', '<leader>tu', function()
      neotest.summary.toggle()
    end, { desc = 'Test: [T]oggle [S]ummary unit tests' })
    vim.keymap.set('n', '<leader>to', function()
      neotest.output.open()
    end, { desc = 'Test: [T]oggle [O]utput' })


    vim.keymap.set('n', '<leader>rtD', function()
      -- neotest.run.run()
      neotest.run.run({ strategy = 'dap' })
    end, { desc = 'Test: [R]un [T]ests' })

    vim.keymap.set('n', '<leader>rt', function()
      neotest.run.run()
    end, { desc = 'Test: [R]un [T]ests' })
  end
}
