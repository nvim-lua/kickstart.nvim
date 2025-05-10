return {
  'vim-test/vim-test',
  dependencies = {
    'tpope/vim-dispatch',
    'mikelue/vim-maven-plugin',
  },
  init = function()
    vim.g['test#strategy'] = 'dispatch'
    -- vim.g.test_echo_command = 1 -- Adicionado para mostrar o comando de teste
    vim.g['test#java#maventest#options'] = '-B'

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'java' },
      callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ef', '<cmd>TestFile<cr>', { desc = 'Test entire file' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>en', '<cmd>TestNearest<cr>', { desc = 'Test nearest method' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>es', '<cmd>TestSuite<cr>', { desc = 'Test entire suite of tests' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>edn', '<cmd>TestNearest -Dmaven.surefire.debug=true<cr>', { desc = 'Debug nearest method' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>edf', '<cmd>TestFile -Dmaven.surefire.debug=true<cr>', { desc = 'Debug entire file' })
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>eds', '<cmd>TestSuite -Dmaven.surefire.debug=true<cr>', { desc = 'Debug entire suite of tests' })
      end,
    })

    local wk = require 'which-key'
    wk.add {
      { '<leader>e', group = 'T[e]sts' },
      { '<leader>ed', group = '[D]ebug' },
    }
  end,
}
