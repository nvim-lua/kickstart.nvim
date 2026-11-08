-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Command line navigation
vim.keymap.set('c', '<C-a>', '<Home>', { desc = 'Home' })
vim.keymap.set('c', '<C-j>', '<C-n>', { desc = 'Next item' })
vim.keymap.set('c', '<C-k>', '<C-p>', { desc = 'Previous item' })

-- Windows style habits
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'select all' })
vim.keymap.set('v', 'p', '"_dP', { desc = 'paste without yanking in visual mode' })

-- Diagnostic keymaps ([d / ]d are Neovim 0.11+ defaults)
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Show diagnostic Error messages' })
vim.keymap.set('n', '<leader>xq', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })

-- Undotree (simplified to one keymap)
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle, { desc = 'Toggle Undo Tree' })

-- Increment/decrement
vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '_', '<C-x>')

-- Stay in indent mode
vim.keymap.set('n', '<', '<S-V><')
vim.keymap.set('n', '>', '<S-V>>')
vim.keymap.set('v', '<', '<gv^')
vim.keymap.set('v', '>', '>gv^')

-- Visual line selection with shift
vim.keymap.set('n', '<S-up>', 'V<up>')
vim.keymap.set('n', '<S-down>', 'V<down>')
vim.keymap.set('v', '<S-up>', '<up>')
vim.keymap.set('v', '<S-down>', '<down>')
vim.keymap.set('i', '<S-up>', '<esc>V<up>')
vim.keymap.set('i', '<S-down>', '<esc>V<down>')

-- Oil file manager
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Oil parent directory' })

-- Terminal mode keymaps
vim.keymap.set('t', '<S-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window management
vim.keymap.set('n', '|', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '\\', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>|', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>\\', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make splits equal size' })
vim.keymap.set('n', '<leader>wc', '<cmd>close<CR>', { desc = 'Close current window' })
vim.keymap.set('n', '<leader>c', '<cmd>close<CR>', { desc = 'Close current window' })

-- Window navigation (See `:help wincmd` for a list of all window commands)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Package manager
vim.keymap.set('n', '<leader>pl', '<cmd>Lazy<CR>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>pm', '<cmd>Mason<CR>', { desc = 'Mason' })

-- Better up/down movement
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Insert newline without leaving normal mode
vim.keymap.set('n', '<leader>o', 'o<esc>', { desc = 'insert newline below', silent = true })
vim.keymap.set('n', '<leader>O', 'O<esc>', { desc = 'insert newline above', silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Move Lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Buffer management (consolidated)
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Previous Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>:bd<cr>', { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', { desc = 'Telescope Buffers' })
vim.keymap.set('n', '<leader>ba', '<cmd>%bd<CR><cmd>e#<CR><cmd>bd#<CR>', { desc = 'Close all but current' })
vim.keymap.set('n', '<leader>bc', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'Close buffer (smart)' })

-- Colorscheme quick access
vim.keymap.set('n', '<leader>um', '<cmd>colorscheme catppuccin-mocha<CR>', { desc = 'catppuccin-mocha' })
vim.keymap.set('n', '<leader>ul', '<cmd>colorscheme catppuccin-latte<CR>', { desc = 'catppuccin-latte' })
vim.keymap.set('n', '<leader>un', '<cmd>colorscheme tokyonight-night<CR>', { desc = 'tokyonight-night' })
vim.keymap.set('n', '<leader>ugl', '<cmd>colorscheme github_light<CR>', { desc = 'github_light' })
vim.keymap.set('n', '<leader>ugd', '<cmd>colorscheme github_dark_default<CR>', { desc = 'github_dark' })
vim.keymap.set('n', '<leader>us', '<cmd>set laststatus=3<bar>hi WinSeparator guifg=#ff0000<CR>', { desc = 'add red window seperators' })

-- Quickfix
vim.keymap.set('n', '[q', '<cmd>cprevious<cr>', { desc = 'Prev quickfix' })
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix' })
vim.keymap.set('n', '[Q', '<cmd>cfirst<cr>', { desc = 'First quickfix' })
vim.keymap.set('n', ']Q', '<cmd>clast<cr>', { desc = 'last quickfix' })

-- Which-key group descriptions
vim.keymap.set('n', '<leader>x', '', { desc = 'quicklist' })
vim.keymap.set('n', '<leader>b', '', { desc = 'buffer' })
vim.keymap.set('n', '<leader>d', '', { desc = 'debug' })
vim.keymap.set('n', '<leader>f', '', { desc = 'find' })
vim.keymap.set('n', '<leader>l', '', { desc = 'language' })
vim.keymap.set('n', '<leader>w', '', { desc = 'workspace' })
vim.keymap.set('n', '<leader>t', '', { desc = 'toggle' })
vim.keymap.set('n', '<leader>g', '', { desc = 'git' })
vim.keymap.set('n', '<leader>p', '', { desc = 'plugins' })
vim.keymap.set('n', '<leader>u', '', { desc = 'ux' })

-- [[ Custom commands ]]
-- This function finds the root git directory of a current buffer
local function get_git_root()
  local dot_git_path = vim.fn.finddir('.git', '.;')
  return vim.fn.fnamemodify(dot_git_path, ':h')
end

-- Command to change the CWD to the git root of the buffer
vim.api.nvim_create_user_command('CdGitRoot', function()
  vim.api.nvim_set_current_dir(get_git_root())
end, {})

-- Keymap for the CdGitRoot command
vim.keymap.set('n', '<leader>br', '<cmd>CdGitRoot<CR>', { desc = 'change CWD to git root of buffer' })