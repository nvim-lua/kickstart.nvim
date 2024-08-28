return {
  {
    'David-Kunz/jester',
    config = function()
      local jester = require 'jester'
      require('which-key').register({
        j = {
          name = '[J]ester',
          s = {
            name = '[S]ingle test',
          },
          f = {
            name = '[F]ile test',
          },
          ['1'] = 'which_key_ignore',
        },
      }, { prefix = '<leader>' })

      jester.setup {
        cmd = "npm t -- -t '$result' $file",
        identifiers = { 'test', 'it' },
        prepend = { 'describe' },
        expressions = { 'call_expression' },
        path_to_jest_run = 'jest',
        path_to_jest_debug = './node_modules/.bin/jest',
        terminal_cmd = ':vsplit | terminal',
        dap = {
          type = 'pwa-node',
          request = 'launch',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { '--inspect-brk', '~/n/bin/npm', 't', '--', '--no-coverage', '-t', '$result', '--', '$file' },
          args = { '--no-cache' },
          sourceMaps = false,
          protocol = 'inspector',
          skipFiles = { '<node_internals>/**/*.js' },
          console = 'integratedTerminal',
          port = 9229,
          disableOptimisticBPs = true,
        },
      }

      vim.keymap.set('n', '<leader>jsr', jester.run, { desc = 'Single test Run' })
      vim.keymap.set('n', '<leader>jsd', jester.debug, { desc = 'Single test debug' })
      vim.keymap.set('n', '<leader>jfr', jester.run, { desc = 'File test Run' })
      vim.keymap.set('n', '<leader>jfd', jester.debug, { desc = 'File test debug' })
    end,
  },
}
