-- Display a character as the colorcolumn
return {
  'lukas-reineke/virt-column.nvim',
  opts = {
    char = '▕', -- This line is the whole idea of using virt-column
    virtcolumn = '80,100',
    highlight = 'CursorLineNr', -- match CursorLineNr highlight
    exclude = {
      filetypes = { 'oil' },
    },
  },
}
