-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end
--custom keymaps i will set here
--
--1) this one is for moving lines like in vscode, up and down with alt j or down with alt-k
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set('n', '<leader>tv', '<Cmd>vsplit | terminal<CR>i', { desc = 'Open terminal vertical split and enter insert' })

-- Enable the autocomplete pop-up menu to appear automatically as you type
vim.opt.autocomplete = true

-- Set a minimal delay (in milliseconds) before the menu pops up
-- 100ms-150ms is usually the sweet spot to prevent it from flickering on every keystroke
vim.opt.autocompletedelay = 200

-- Scan only the current buffer for auto-completion matches
-- '.' tells Vim to only scan the current buffer
vim.opt.complete = "."

-- Configure the completion menu to use fuzzy matching and adjust behavior
-- 'menuone' shows the popup even if there's only one match
-- 'noselect' prevents automatically selecting/inserting the first match until you choose it
-- 'fuzzy' enables the matching logic you requested
vim.opt.completeopt = { "menuone", "noselect", "fuzzy" }

-- Helper function to check if the popup menu (pum) is visible
local pumvisible = function()
  return vim.fn.pumvisible() == 1
end

-- Use Tab to cycle down the menu (if open), otherwise insert a literal Tab
vim.keymap.set("i", "<Tab>", function()
  if pumvisible() then
    return "<C-n>"
  else
    return "<Tab>"
  end
end, { expr = true })

-- Use Shift+Tab to cycle up the menu (if open)
vim.keymap.set("i", "<S-Tab>", function()
  if pumvisible() then
    return "<C-p>"
  else
    return "<S-Tab>"
  end
end, { expr = true })

-- Force a global statusline across all windows (or 2 for split-specific)
vim.opt.laststatus = 3 

-- Customize the native statusline to ONLY show the file path and the line:col
-- %f = relative path, %= = separation point to push items right, %l:%c = line:col
vim.opt.statusline = "%f  %{mode()} %l:%c"
-- set esc keybind to jj
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit Insert mode' })
