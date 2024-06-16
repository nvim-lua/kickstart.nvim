return {
  {
    'David-Kunz/jester',
    config = function()
      local jester = require 'jester'
      require('which-key').register({
        j = {
          name = '[J]ester',
          s = {
            function()
              jester.run()
            end,
            '[S]ingle test',
          },
          f = {
            function()
              jester.run_file()
            end,
            '[F]ile test',
          },
          -- s = {
          --   name = '[S]ingle test',
          --   r = {
          --     function()
          --       jester.run()
          --     end,
          --     '[R]un',
          --   },
          --   d = {
          --     function()
          --       jester.debug()
          --     end,
          --     '[D]ebug',
          --   },
          --   ['1'] = 'which_key_ignore',
          -- },
          -- f = {
          --   name = '[F]ile test',
          --   r = {
          --     function()
          --       jester.run_file()
          --     end,
          --     '[R]un',
          --   },
          --   d = {
          --     function()
          --       jester.debug_file()
          --     end,
          --     '[D]ebug',
          --   },
          --   ['1'] = 'which_key_ignore',
          -- },
          ['1'] = 'which_key_ignore',
        },
      }, { prefix = '<leader>' })

      jester.setup {
        cmd = "npm t -- -t '$result' $file", -- run command
        identifiers = { 'test', 'it' }, -- used to identify tests
        prepend = { 'describe' }, -- prepend describe blocks
        expressions = { 'call_expression' }, -- tree-sitter object used to scan for tests/describe blocks
        path_to_jest_run = 'jest', -- used to run tests
        path_to_jest_debug = './node_modules/.bin/jest', -- used for debugging
        terminal_cmd = ':vsplit | terminal', -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
        dap = { -- debug adapter configuration
          type = 'node2',
          request = 'launch',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { '--inspect-brk', '$path_to_jest', '--no-coverage', '-t', '$result', '--', '$file' },
          args = { '--no-cache' },
          sourceMaps = false,
          protocol = 'inspector',
          skipFiles = { '<node_internals>/**/*.js' },
          console = 'integratedTerminal',
          port = 9229,
          disableOptimisticBPs = true,
        },
      }

      vim.keymap.set('n', '<leader>js', jester.run, { desc = 'Single test Run' })
      -- vim.keymap.set('n', '<leader>jsd', jester.debug, { desc = 'Single test debug' })
      vim.keymap.set('n', '<leader>jf', jester.run, { desc = 'File test Run' })
      -- vim.keymap.set('n', '<leader>jfd', jester.debug, { desc = 'File test debug' })
    end,
  },
}
