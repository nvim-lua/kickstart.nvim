-- my basic session management

local session_file = 'session.vim'
local auto_save = false

vim.api.nvim_create_autocmd({'VimEnter'}, {
  callback = function ()
    if vim.fn.argc() == 0 and vim.fn.filereadable(session_file) == 1 then
      vim.cmd('source ' .. session_file)
      auto_save = true
      vim.notify("Session restored from " .. session_file, vim.log.levels.INFO, {title = "Sessions"})
    end
  end,
  desc = "Load session file on start up - start vim with no args to load the session file in current working directory"
})

vim.api.nvim_create_autocmd({'VimLeave'}, {
  callback = function ()
    if vim.fn.argc() == 0 or auto_save == true then
      vim.cmd('mks! ' .. session_file)
    end
  end,
  desc = "Write session file on close"
})
