return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = false,
  config = function()
    require('refactoring').setup {
      prompt_func_return_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true, -- shows a message with information about the refactor on success
      -- i.e. [Refactor] Inlined 3 variable occurrences
    }
  end,
  vim.keymap.set({ 'n', 'x' }, '<leader>cr', function()
    return require('refactoring').refactor 'Code Refactor'
  end, { expr = true, desc = '[C]ode [R]efactor' }),
  vim.keymap.set({ 'n', 'x' }, '<leader>cre', function()
    return require('refactoring').refactor 'Extract Function'
  end, { expr = true, desc = '[R]efactor [E]xtract Function' }),
  vim.keymap.set({ 'n', 'x' }, '<leader>crf', function()
    return require('refactoring').refactor 'Extract Function To File'
  end, { expr = true, desc = '[R]efactor Extract Function To [F]ile' }),
  vim.keymap.set({ 'n', 'x' }, '<leader>crv', function()
    return require('refactoring').refactor 'Extract Variable'
  end, { expr = true, desc = '[R]efactor Extract [V]ariable' }),
  vim.keymap.set({ 'n', 'x' }, '<leader>crI', function()
    return require('refactoring').refactor 'Inline Function'
  end, { expr = true, desc = '[R]efactor [I]nline Function' }),
  vim.keymap.set({ 'n', 'x' }, '<leader>cri', function()
    return require('refactoring').refactor 'Inline Variable'
  end, { expr = true, desc = '[R]efactor [I]nline Variable' }),

  vim.keymap.set({ 'n', 'x' }, '<leader>crbb', function()
    return require('refactoring').refactor 'Extract Block'
  end, { expr = true, desc = '[R]efactor Extract [B]lock' }),
  vim.keymap.set({ 'n', 'x' }, '<leader>crbf', function()
    return require('refactoring').refactor 'Extract Block To File'
  end, { expr = true, desc = '[R]efactor Extract [B]lock To [F]ile' }),
}
