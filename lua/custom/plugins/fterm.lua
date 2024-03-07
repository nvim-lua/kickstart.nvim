return {
  'numToStr/FTerm.nvim',
  config = function()
    require('FTerm').setup {
      dimensions = {
        height = 0.6,
        width = 0.6,
      },
      cmd = 'Powershell.exe',
    }
  end,
  vim.keymap.set('n', '<leader>tt', ':lua require("FTerm").toggle()<CR>', { noremap = true, silent = true, desc = '[T]oggle [T]erminal' }),
}
