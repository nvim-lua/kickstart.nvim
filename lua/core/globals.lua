vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if vim.fn.exists 'g:os' == 0 then
  local is_windows = vim.fn.has 'win64' == 1 or vim.fn.has 'win32' == 1 or vim.fn.has 'win16' == 1
  if is_windows then
    vim.g.os = 'Windows'
  else
    local uname_output = vim.fn.system 'uname'
    vim.g.os = string.gsub(uname_output, '\n', '')
  end
end

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
