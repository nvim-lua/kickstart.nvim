
-- previous binding
--  runs selected code in FSI, exit fsi with "i<cr>" after done scrolling/viewing
vim.keymap.set('v', '<A-CR>', 'y:new<CR>:term<CR>idotnet fsi <CR><C-\\><C-n>pGA;;<CR>#quit;;<CR>exit<CR><C-\\><C-n>G')