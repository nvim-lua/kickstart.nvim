local keybinds = {
  vim.api.nvim_set_keymap('n', ';', ':', { noremap = true }),
  vim.cmd 'command! QQ q!',
  vim.cmd 'command! Q q',
  vim.cmd 'command! WQ wq',
}

return keybinds
