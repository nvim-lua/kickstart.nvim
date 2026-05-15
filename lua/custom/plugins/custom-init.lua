-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

package.path = package.path .. ";?.lua"

-- Set the blinking cursor settings
vim.o.guicursor = 'n-v:block,i:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250'

-- Adjust the split that it makes sense
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Make sure, that when we exit nvim the previous cursor settings get restored
vim.cmd([[
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:block20
    augroup END
]])

-- Adding relative line numbers
vim.opt.relativenumber = true

-- Fix the cursor in the middle of windows when scrolling
vim.opt.scrolloff = 6

-- Remap for dealing with word wrap in v mode (see init.lua:284)
vim.keymap.set('v', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true})
vim.keymap.set('v', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true})

-- Provide function and keymap binding to show not saved changes of current buffer
function showBufferDiff()
vim.cmd([[w !diff % - ]])
end
-- ":vim.cmd([[w !diff % - ]])"
vim.keymap.set('n', '<leader>pd', showBufferDiff, { expr = true, silent = true, desc = "Print diff between buffer and file"})


-- Mimic the tmux config here. S for vertical split, v for horizontal:
-- - Remap for easier window control access
-- - Remap general the window control access to <A-w>.
-- - Remap (swapping) particular "s" to "v" when entering window control access.
--   (Bear in mind that you have to release <A-w> keys, and then press "s" or "v". 
--   Otherwise the swapping of "s" and "v" does not work.
local map = vim.api.nvim_set_keymap
map('n', '<A-w>', '<C-w>', {noremap = false})
map('n', '<C-w>s', '<C-w>v', {noremap = true})
map('n', '<C-w>v', '<C-w>s', {noremap = true})
return {
}
