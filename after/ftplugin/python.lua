local macchiato_line_length = 80
if (vim.o.textwidth or 0) > 0 then
   macchiato_line_length = vim.o.textwidth
end
vim.opt_local.formatprg = 'black-macchiato -l ' .. macchiato_line_length
