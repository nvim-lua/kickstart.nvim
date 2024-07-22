-- Set buffer-local options for Go files
vim.opt_local.expandtab = true
vim.opt_local.commentstring = '// %s'
vim.opt_local.comments = 's1:/*,mb:*,ex:*/,://'

-- Define a key mapping to trigger Go debugging
vim.keymap.set('n', '<leader>td', function()
  require('dap-go').debug_test()
end, { buffer = 0 }) -- Set buffer-local key mapping

