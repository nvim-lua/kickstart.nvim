return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup {
      indent = {
        enable = true,
        style = { { fg = '#3c6370' } },
      },
      chunk = {
        enable = true,
        style = { { fg = '#abb2bf' } },
      },
      line_num = {
        enable = true,
      },
      blank = {
        enable = false,
      },
    }
  end,
}
