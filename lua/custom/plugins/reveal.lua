vim.api.nvim_create_user_command('Reveal',
  function()
    -- local sysname = vim.loop.os_uname().sysname

    local currentBuffer = vim.api.nvim_get_current_buf()
    local bufName = vim.api.nvim_buf_get_name(currentBuffer)
    local ftype = vim.fn.getftype(bufName)

    if ftype == "dir" then
      os.execute("xdg-open " .. bufName)
    else
      os.execute("xdg-open " .. vim.fn.expand("%:p:h"))
    end
  end,
  {}
)

vim.keymap.set('n', '<leader>R', ":Reveal<CR>", { noremap = true, desc = '[R]eveal with xdg-open' })

return {
}
