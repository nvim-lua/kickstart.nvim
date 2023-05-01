local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained" ,"InsertLeave"}, {
    command = "set relativenumber",
    group = my_group
  }
)

vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
    command = "set norelativenumber",
    group = my_group
  }
)

return {}
