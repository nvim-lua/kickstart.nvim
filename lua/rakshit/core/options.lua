-- Change the :Explore option to show in a tree styled format
vim.cmd("let g:netrw_liststyle = 3")

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Really smart 😎

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Allow backspace on indent, end of line or insert mode start position
vim.opt.backspace = "indent,eol,start"

-- Enable break indent
vim.opt.breakindent = true

-- Function to rename the current tmux window based on the directory name
local function rename_tmux_window()
  if vim.env.TMUX then
    local cwd = vim.loop.cwd() -- Get the current working directory
    local dirname = vim.fn.fnamemodify(cwd, ":t") -- Extract the last part of the directory path
    os.execute("tmux rename-window " .. dirname)
  end
end

-- Automatically rename tmux window when starting Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    rename_tmux_window()
  end,
})
