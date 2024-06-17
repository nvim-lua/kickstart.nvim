-- [[ General Keymaps ]]

local nmap = require 'core.utils'.createNmap()

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Stop yanking on paste
vim.keymap.set('x', 'p', 'P')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local function nohClear()
  -- Removes highlight search
  vim.cmd.noh()
  -- Clear terminal notification below
  vim.notify("")
end

vim.keymap.set("n", "<Esc>", nohClear, { silent = true })
vim.keymap.set("n", "<C-L>", nohClear, { silent = true })

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)


--[[
  NOTE To use Meta key as Option in mac inside iterm
  it should be set to work as +ESC in iterm settings
--]]

-- Split resize
--  nmap('<M-j>', ':res +1<cr>', 'Resize split')
--  nmap('<M-k>', ':res -1<cr>', 'Resize split')
--  nmap('<M-h>', ':vertical res -1<cr>', 'Resize split vertically')
--  nmap('<M-l>', ':vertical res +1<cr>', 'Resize split vertically')
--  nmap('<M-v>', '<C-w>|<cr>', 'Maximize Split Vertically')
--  nmap('<M-s>', '<C-w>_<cr>', 'Maximize Split Horizontally')
--  nmap('<M-e>', '<C-w>=<cr>', 'Reset Split Size')
