return {
  {
    'gbprod/yanky.nvim',
    opts = {
      ystem_clipboard = {
        sync_with_ring = true,
        clipboard_register = nil,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
    },
  },
}
