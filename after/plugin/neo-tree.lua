-- Autocmd to open Neo-tree automatically on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.isdirectory(vim.fn.getcwd()) == 1 then
      require('neo-tree.command').execute({ toggle = false, dir = vim.loop.cwd() })
      vim.cmd('wincmd p')  -- Switch back to the previous buffer
    end
  end
})

