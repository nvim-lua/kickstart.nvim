local opt = vim.opt

opt.autoindent = true
opt.background = "dark"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.iskeyword:append("-")
opt.iskeyword:append("_")
opt.number = true
opt.relativenumber = true
opt.shiftwidth = 2
opt.signcolumn = "yes"
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.wrap = false
opt.timeoutlen = 222
-- opt.conceallevel = 1


-- if vim.fn.has("win32") == 1 then
--   vim.o.shell = 'bash.exe'
--   vim.o.shellcmdflag = '-c'
--   vim.o.shellredir = '>%s 2>&1'
--   vim.o.shellquote = ''
--   vim.o.shellxescape = ''
--   -- vim.o.shelltemp = false
--   vim.o.shellxquote = ''
--   vim.o.shellpipe = '2>&1| tee'
-- end

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  -- windows only, convert \ to / when expanding file names
  opt.shellslash = true
  -- defaults to cmd.exe
  -- opt.shell = vim.fs.normalize("~/scoop/apps/git/current/bin/bash.exe")
  -- opt.shell = "bash.exe" -- WARN: sometimes mistakenly points to wsl bash

  -- defaults to "/s /c" for cmd.exe
  opt.shellcmdflag = "-c"
  -- default value works
  opt.shellpipe = "2>&1| tee"
  -- Windows: may default to "\"" when 'shell' contains 'sh'
  opt.shellquote = ""
  opt.shellxquote = ""
  -- defaults to ">", 'bash' uses:
  opt.shellredir = ">%s 2>&1"
  -- defualt value works
  opt.shellxescape = ""
end
