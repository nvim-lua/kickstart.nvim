local plugin = {"akinsho/toggleterm.nvim"}
plugin.version = "*"
plugin.config = {
  open_mapping = [[<c-\>]],
  direction = "float",
  close_on_exit = true
}

return plugin

