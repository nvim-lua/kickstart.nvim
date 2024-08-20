return {
  'theprimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader>ef',  ":lua require('refactoring').refactor('Extract Function')<CR>",         mode = 'x',          desc = 'Extract Function' },
    { '<leader>eff', ":lua require('refactoring').refactor('Extract Function To File')<CR>", mode = 'x',          desc = 'Extract Function To File' },
    { '<leader>ev',  ":lua require('refactoring').refactor('Extract Variable')<CR>",         mode = 'x',          desc = 'Extract Variable' },
    { '<leader>eI',  ":lua require('refactoring').refactor('Inline Function')<CR>",          mode = 'n',          desc = 'Inline Function' },
    { '<leader>ei',  ":lua require('refactoring').refactor('Inline Variable')<CR>",          mode = { 'n', 'x' }, desc = 'Inline Variable' },
    { '<leader>eb',  ":lua require('refactoring').refactor('Extract Block')<CR>",            mode = 'n',          desc = 'Extract Block' },
    { '<leader>ebf', ":lua require('refactoring').refactor('Extract Block To File')<CR>",    mode = 'n',          desc = 'Extract Block To File' },
  },
  config = function()
    require('refactoring').setup({
      show_success_message = true,
    })
  end,
}

