local M = {
  'kevinhwang91/nvim-bqf',
  event = 'VeryLazy',
}

function M.config()
  require('bqf').setup({
    auto_enable = true,
    magic_window = true,
    auto_resize_height = false,
    preview = {
      auto_preview = true,
      show_title = true,
      delay_syntax = 50,
      wrap = true,
    },
    func_map = {
      tab = 't',
      openc = 'o',
      drop = 'O',
      split = 's',
      vsplit = 'v',
      stoggleup = 'M',
      stoggledown = 'm',
      stogglevm = 'm',
      filterr = 'f',
      filter = 'F',
      prevhist = '<',
      nexthist = '>',
      sclear = 'c',
      ptoggleitem = 'p',
      ptoggleauto = 'a',
      ptogglemode = 'P',
    },
  })
end

return M
