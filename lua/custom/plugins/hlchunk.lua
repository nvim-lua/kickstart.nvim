return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup {
      chunk = {
        enable = true,
        duration = 150,
        delay = 1,
      },
    }
  end,
}
