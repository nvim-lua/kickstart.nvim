--[[
  Centralized keymaps configuration
  
  This file contains all the keybindings for the Neovim configuration,
  organized by category for better readability and maintenance.
  
  Structure:
  1. General keymaps (save, quit, etc.)
  2. Navigation keymaps (windows, tabs, etc.)
  3. UI keymaps (toggle elements, etc.)
  4. Editing keymaps (formatting, etc.)
  5. Plugin-specific keymaps
]]

local M = {}

-- Helper function for setting keymaps with proper labels
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Initialize keymaps
function M.setup()
  --------------------------------------------------
  -- 1. GENERAL KEYMAPS
  --------------------------------------------------

  -- Save and quit
  map('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
  -- map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
  map('n', '<leader>Q', ':qa!<CR>', { desc = 'Force quit all' })
  map('n', '<leader>W', ':wq<CR>', { desc = 'Save and quit' })

  -- Common operations
  map('n', '<leader>/', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
  map('n', '<Esc>', '<cmd>noh<CR>', { desc = 'Clear highlights' })

  --------------------------------------------------
  -- 2. NAVIGATION KEYMAPS
  --------------------------------------------------

  -- Window navigation
  map('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
  map('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the down window' })
  map('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the up window' })
  map('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })

  -- Window management
  map('n', '<leader>[', ':vsplit<CR>', { desc = 'Split window vertically' })
  map('n', '<leader>]', ':split<CR>', { desc = 'Split window horizontally' })
  map('n', '<leader>wq', '<C-w>q', { desc = 'Close current window' })
  map('n', '<leader>wo', '<C-w>o', { desc = 'Close other windows' })

  -- Window resizing
  map('n', '<M-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
  map('n', '<M-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
  map('n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
  map('n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

  -- Tab management (see also plugin-specific keymaps below)
  map('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
  map('n', '<leader>to', ':tabnew<CR>:Telescope find_files<CR>', { desc = 'New tab with file' })
  map('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
  map('n', '<C-PgDn>', 'gt', { desc = 'Next tab' })
  map('n', '<C-PgUp>', 'gT', { desc = 'Previous tab' })

  -- Buffer navigation
  map('n', '<leader>bb', "<cmd>lua require('telescope.builtin').buffers()<CR>", { desc = 'Browse buffers' })
  map('n', '<leader>bd', ':bd<CR>', { desc = 'Delete buffer' })
  map('n', '<leader>bn', ':bn<CR>', { desc = 'Next buffer' })
  map('n', '<leader>bp', ':bp<CR>', { desc = 'Previous buffer' })

  --------------------------------------------------
  -- 3. UI KEYMAPS
  --------------------------------------------------

  -- File explorer
  map('n', '<leader>e', ':Explore<CR>', { desc = 'Open file explorer' })

  -- Terminal
  map('n', '<leader>tt', ':ToggleTerm<CR>', { desc = 'Toggle terminal' })
  map('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal' })
  map('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', { desc = 'Toggle horizontal terminal' })
  map('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', { desc = 'Toggle vertical terminal' })
  map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

  -- Diagnostics
  map('n', '<leader>xd', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
  map('n', '<leader>xl', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
  map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
  map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

  --------------------------------------------------
  -- 4. EDITING KEYMAPS
  --------------------------------------------------

  -- Move lines
  map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
  map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
  map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
  map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

  -- Better indenting
  map('v', '<', '<gv', { desc = 'Decrease indent and reselect' })
  map('v', '>', '>gv', { desc = 'Increase indent and reselect' })

  return M
end

return M
