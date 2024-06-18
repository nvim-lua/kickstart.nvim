return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 24,
      open_mapping = [[<c-t>]],
    },
    init = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
        desc = 'Detect buffer and setup oil nnn flag',
        pattern = 'term://*',
        callback = function(params)
          local winnr = vim.fn.bufwinid(params.buf)
          vim.api.nvim_set_option_value('cursorline', false, { win = winnr })
        end,
      })
    end,
  },
}
