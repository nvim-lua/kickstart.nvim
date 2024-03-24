
--The following code defines a function called ExitNetrw(), that checks if the current filetype is "netrw" (i.e. if you are currently in netrw), and if so, it changes the current working directory of the terminal to the directory of the current file or directory you are looking at in netrw, and then exits Neovim. If the current filetype is not "netrw", it will simply exit Neovim.

--It also maps the <C-q> key to call this function, so when you press <C-q> it will change the working directory and exit netrw, but if you're not in netrw it will exit Neovim directly.

--You can change the keybinding to your preferred key, just replace <C-q> with your preferred key.

local nvim_command = vim.api.nvim_command
local nvim_call_function = vim.api.nvim_call_function

function ExitNetrw()
  if vim.bo.filetype == "netrw" then
    cwd = nvim_call_function("expand", {"%:p:h"})
    nvim_command("!cd " .. cwd)
    nvim_command("qa!")
  else
    nvim_command("qa!")
  end
end
-- need to remap this at some point
--vim.cmd("nnoremap <silent> <C-q> :lua ExitNetrw()<CR>")



--exit neovim to the $NVIM_PWD
--local nvim_set_option = vim.api.nvim_set_option
--local os_getenv = os.getenv
--

local os = require('os')
local os_execute = os.execute
local os_getenv = os.getenv

local pwd = os.getenv('PWD')
--print(pwd)

--
--
--os_execute = vim.loop.os_execute
--os_getenv = vim.loop.os_getenv

--vim.cmd("autocmd BufLeave * lua os_execute(\"cd \".. os_getenv(\"NVIM_PWD\"))")
--local os = require('os')
--local os_execute = os.execute
--local os_getenv = os.getenv

--vim.cmd("autocmd BufLeave * lua os_execute("cd ".. os_getenv("NVIM_PWD"))")
