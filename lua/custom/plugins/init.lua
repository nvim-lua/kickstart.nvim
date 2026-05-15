-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Disabled netrw plugin, because we will use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make sure, that when we exit nvim the previous cursor settings get restored
vim.cmd [[
    augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:block20
    augroup END
]]

-- Set the blinking cursor settings
vim.opt.guicursor = 'n-v:block,i:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250'

-- Remap for dealing with word wrap in v mode
vim.keymap.set('v', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('v', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Provide function and keymap binding to show not saved changes of current buffer
function showBufferDiff()
  vim.cmd [[w !diff % - ]]
end
-- ":vim.cmd([[w !diff % - ]])"
vim.keymap.set('n', '<leader>pd', showBufferDiff, { expr = true, silent = true, desc = 'Print diff between buffer and file' })

-- Mimic the tmux config here. S for vertical split, v for horizontal:
-- - Remap for easier window control access
-- - Remap general the window control access to <A-w>.
-- - Remap (swapping) particular "s" to "v" when entering window control access.
--   (Bear in mind that you have to release <A-w> keys, and then press "s" or "v".
--   Otherwise the swapping of "s" and "v" does not work.
local map = vim.api.nvim_set_keymap
map('n', '<A-w>', '<C-w>', { noremap = false })
map('n', '<C-w>s', '<C-w>v', { noremap = true })
map('n', '<C-w>v', '<C-w>s', { noremap = true })

-- Mapping for delete into black hole register in normal mode
-- and replace visual selection with yanked text (unnamed register) without losing it.
-- Example: yiw or yi" to yank some text => <leader>xiwP or <leader>xiw"P to replace.
--                                       => visual select and <leader>x to replace.
vim.keymap.set('n', '<leader>x', '"_d', { desc = 'Delete to black hole register' })
vim.keymap.set('v', '<leader>x', '"_dP', { desc = 'Replace selection with yanked text' })


-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end

return {}
