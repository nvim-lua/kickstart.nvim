-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Core Neovim keymaps (non-plugin)
-- These are basic Neovim operations like:
-- - Window navigation (Ctrl + hjkl)
-- - Window resizing (Ctrl + Arrow keys)
-- - Line/selection movement (Alt + jk)
-- - Quick save and quit (<leader>w, <leader>W, <leader>Q)
local core_keymaps = {
  -- Clear highlights on search when pressing <Esc> in normal mode
  { mode = 'n', lhs = '<Esc>', rhs = '<cmd>nohlsearch<CR>', opts = { desc = 'Clear search highlights' } },

  -- Exit terminal mode with a more discoverable shortcut
  { mode = 't', lhs = '<C-/>', rhs = '<C-\\><C-n>', opts = { desc = 'Exit terminal mode' } },

  -- Window navigation (Ctrl + hjkl)
  { mode = 'n', lhs = '<C-h>', rhs = '<C-w><C-h>', opts = { desc = 'Focus: Window left' } },
  { mode = 'n', lhs = '<C-l>', rhs = '<C-w><C-l>', opts = { desc = 'Focus: Window right' } },
  { mode = 'n', lhs = '<C-j>', rhs = '<C-w><C-j>', opts = { desc = 'Focus: Window down' } },
  { mode = 'n', lhs = '<C-k>', rhs = '<C-w><C-k>', opts = { desc = 'Focus: Window up' } },

  -- Window resizing (Ctrl + Arrow keys)
  { mode = 'n', lhs = '<C-Up>', rhs = '<cmd>resize +2<CR>', opts = { desc = 'Window: Increase height' } },
  { mode = 'n', lhs = '<C-Down>', rhs = '<cmd>resize -2<CR>', opts = { desc = 'Window: Decrease height' } },
  { mode = 'n', lhs = '<C-Left>', rhs = '<cmd>vertical resize -2<CR>', opts = { desc = 'Window: Decrease width' } },
  { mode = 'n', lhs = '<C-Right>', rhs = '<cmd>vertical resize +2<CR>', opts = { desc = 'Window: Increase width' } },

  -- Move lines up and down (Alt + jk)
  { mode = 'n', lhs = '<A-j>', rhs = ':m .+1<CR>==', opts = { desc = 'Move line down', silent = true } },
  { mode = 'n', lhs = '<A-k>', rhs = ':m .-2<CR>==', opts = { desc = 'Move line up', silent = true } },
  { mode = 'v', lhs = '<A-j>', rhs = ":m '>+1<CR>gv=gv", opts = { desc = 'Move selection down', silent = true } },
  { mode = 'v', lhs = '<A-k>', rhs = ":m '<-2<CR>gv=gv", opts = { desc = 'Move selection up', silent = true } },

  -- Quick save and quit
  { mode = 'n', lhs = '<leader>w', rhs = '<cmd>w<CR>', opts = { desc = 'Save file' } },
  { mode = 'n', lhs = '<leader>W', rhs = '<cmd>wa<CR>', opts = { desc = 'Save all files' } },
  { mode = 'n', lhs = '<leader>Q', rhs = '<cmd>qa<CR>', opts = { desc = 'Quit all' } },
}

-- LSP keymaps - these will be set up when LSP attaches to a buffer
-- Navigation:
-- - gd: Go to definition
-- - gr: Find references
-- - gI: Go to implementation
-- - gy: Go to type definition
--
-- Workspace:
-- - <leader>ls: Document symbols
-- - <leader>lS: Workspace symbols
--
-- Code Actions:
-- - <leader>lr: Rename symbol
-- - <leader>la: Code action
-- - <leader>lf: Format code
--
-- Documentation:
-- - K: Show documentation
local M = {}
function M.setup_lsp_keymaps(bufnr)
  local keymaps = {
    -- Go to definitions
    { mode = 'n', lhs = 'gd', rhs = function() require('telescope.builtin').lsp_definitions() end, opts = { desc = 'LSP: Go to definition' } },
    { mode = 'n', lhs = 'gr', rhs = function() require('telescope.builtin').lsp_references() end, opts = { desc = 'LSP: Find references' } },
    { mode = 'n', lhs = 'gI', rhs = function() require('telescope.builtin').lsp_implementations() end, opts = { desc = 'LSP: Go to implementation' } },
    { mode = 'n', lhs = 'gy', rhs = function() require('telescope.builtin').lsp_type_definitions() end, opts = { desc = 'LSP: Go to type definition' } },
    
    -- Symbol navigation
    { mode = 'n', lhs = '<leader>ls', rhs = function() require('telescope.builtin').lsp_document_symbols() end, opts = { desc = 'LSP: Document symbols' } },
    { mode = 'n', lhs = '<leader>lS', rhs = function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, opts = { desc = 'LSP: Workspace symbols' } },
    
    -- Code actions
    { mode = 'n', lhs = '<leader>lr', rhs = vim.lsp.buf.rename, opts = { desc = 'LSP: Rename symbol' } },
    { mode = 'n', lhs = '<leader>la', rhs = vim.lsp.buf.code_action, opts = { desc = 'LSP: Code action' } },
    { mode = 'n', lhs = '<leader>lf', rhs = function() vim.lsp.buf.format({ async = true }) end, opts = { desc = 'LSP: Format code' } },
    
    -- Documentation
    { mode = 'n', lhs = 'K', rhs = vim.lsp.buf.hover, opts = { desc = 'LSP: Show documentation' } },
  }

  -- First clear any existing LSP keymaps for this buffer
  local lsp_maps = { 'gd', 'gr', 'gI', 'gy', 'K',
                     '<leader>ls', '<leader>lS', '<leader>lr', '<leader>la', '<leader>lf' }
  for _, lhs in ipairs(lsp_maps) do
    pcall(vim.keymap.del, 'n', lhs, { buffer = bufnr })
  end

  -- Then set our keymaps with buffer local
  for _, mapping in ipairs(keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, vim.tbl_extend('force', mapping.opts, {
      buffer = bufnr,
      replace_keycodes = false,
      nowait = true,
      silent = true,
    }))
  end
end

-- Telescope keymaps (all under <leader>s for Search)
-- Help:
-- - <leader>sh: Search help tags
-- - <leader>sk: Search keymaps
--
-- Files:
-- - <leader>sf: Find files
-- - <leader>sr: Recent files
--
-- Text Search:
-- - <leader>sg: Live grep in workspace
-- - <leader>sw: Search word under cursor
-- - <leader>/: Fuzzy find in current buffer
-- - <leader>s/: Live grep in open files
--
-- Workspace:
-- - <leader>sd: Search diagnostics
-- - <leader>sb: Search buffers
M.telescope_keymaps = {
  -- Help
  { mode = 'n', lhs = '<leader>sh', rhs = function() require('telescope.builtin').help_tags() end, opts = { desc = 'Search: Help' } },
  { mode = 'n', lhs = '<leader>sk', rhs = function() require('telescope.builtin').keymaps() end, opts = { desc = 'Search: Keymaps' } },
  
  -- Files
  { mode = 'n', lhs = '<leader>sf', rhs = function() require('telescope.builtin').find_files() end, opts = { desc = 'Search: Files' } },
  { mode = 'n', lhs = '<leader>sr', rhs = function() require('telescope.builtin').oldfiles() end, opts = { desc = 'Search: Recent files' } },
  
  -- Text
  { mode = 'n', lhs = '<leader>sg', rhs = function() require('telescope.builtin').live_grep() end, opts = { desc = 'Search: Text in workspace' } },
  { mode = 'n', lhs = '<leader>sw', rhs = function() require('telescope.builtin').grep_string() end, opts = { desc = 'Search: Word under cursor' } },
  { mode = 'n', lhs = '<leader>/', rhs = function() 
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, opts = { desc = 'Search: Text in buffer' } },
  { mode = 'n', lhs = '<leader>s/', rhs = function()
    require('telescope.builtin').live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, opts = { desc = 'Search: Text in open files' } },
  
  -- Workspace
  { mode = 'n', lhs = '<leader>sd', rhs = function() require('telescope.builtin').diagnostics() end, opts = { desc = 'Search: Diagnostics' } },
  { mode = 'n', lhs = '<leader>sb', rhs = function() require('telescope.builtin').buffers() end, opts = { desc = 'Search: Buffers' } },
}

-- Diagnostic keymaps
-- Navigation:
-- - [d: Previous diagnostic
-- - ]d: Next diagnostic
--
-- Viewing:
-- - <leader>tt: Show diagnostic details in float
-- - <leader>tl: Show diagnostics in location list
M.diagnostic_keymaps = {
  -- Navigation
  { mode = 'n', lhs = '[d', rhs = vim.diagnostic.goto_prev, opts = { desc = 'Diagnostic: Previous' } },
  { mode = 'n', lhs = ']d', rhs = vim.diagnostic.goto_next, opts = { desc = 'Diagnostic: Next' } },
  
  -- Viewing diagnostics
  { mode = 'n', lhs = '<leader>tt', rhs = vim.diagnostic.open_float, opts = { desc = 'Diagnostic: Show details' } },
  { mode = 'n', lhs = '<leader>tl', rhs = vim.diagnostic.setloclist, opts = { desc = 'Diagnostic: Show list' } },
}

-- Database keymaps (all under <leader>D for Database)
-- UI:
-- - <leader>Dt: Toggle database UI
-- - <leader>Df: Find database buffer
-- - <leader>Dr: Rename database buffer
-- - <leader>Dl: Show last query info
M.dadbod_keymaps = {
  { mode = 'n', lhs = '<leader>Dt', rhs = '<cmd>DBUIToggle<CR>', opts = { desc = 'Database: Toggle UI' } },
  { mode = 'n', lhs = '<leader>Df', rhs = '<cmd>DBUIFindBuffer<CR>', opts = { desc = 'Database: Find buffer' } },
  { mode = 'n', lhs = '<leader>Dr', rhs = '<cmd>DBUIRenameBuffer<CR>', opts = { desc = 'Database: Rename buffer' } },
  { mode = 'n', lhs = '<leader>Dl', rhs = '<cmd>DBUILastQueryInfo<CR>', opts = { desc = 'Database: Last query' } },
}

-- Session management keymaps (all under <leader>m for Memory)
-- Session Operations:
-- - <leader>mw: Write/save current session
-- - <leader>mr: Read/restore saved session
-- - <leader>md: Delete saved session
M.session_keymaps = {
  { mode = 'n', lhs = '<leader>mw', rhs = function() 
    local name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    require('mini.sessions').write(name, { force = true })
  end, opts = { desc = 'Memory: Write session' } },
  { mode = 'n', lhs = '<leader>mr', rhs = function()
    local name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    require('mini.sessions').read(name)
  end, opts = { desc = 'Memory: Read session' } },
  { mode = 'n', lhs = '<leader>md', rhs = function()
    local name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    require('mini.sessions').delete(name)
  end, opts = { desc = 'Memory: Delete session' } },
}

-- Scratch buffer keymaps
-- Buffer Operations:
-- - <leader>.: Toggle scratch buffer
-- - <leader>S: Select scratch buffer
-- - <leader>nh: Show notification history
M.scratch_keymaps = {
  { mode = 'n', lhs = '<leader>.', rhs = function() require("snacks").scratch() end, 
    opts = { desc = 'Toggle scratch buffer' } },
  { mode = 'n', lhs = '<leader>S', rhs = function() require("snacks").scratch.select() end,
    opts = { desc = 'Select scratch buffer' } },
  { mode = 'n', lhs = '<leader>nh', rhs = function() require("snacks.notifier").show_history() end,
    opts = { desc = 'Show notification history' } },
}

-- Snacks keymaps (explorer and other features)
-- File Explorer:
-- - <leader>e: Toggle explorer
-- - <leader>E: Focus current file in explorer
-- - <leader>o: Alternative key to focus current file
-- 
-- Terminal:
-- - <C-/>: Toggle terminal in float window
M.snacks_keymaps = {
  -- Explorer
  { mode = 'n', lhs = '<leader>e', rhs = function() require('snacks.picker').explorer() end, opts = { desc = 'Explorer: Toggle' } },
  { mode = 'n', lhs = '<leader>E', rhs = function() require('snacks.picker').explorer({ reveal = true }) end, opts = { desc = 'Explorer: Focus current file' } },
  { mode = 'n', lhs = '<leader>o', rhs = function() require('snacks.picker').explorer({ reveal = true }) end, opts = { desc = 'Explorer: Focus current file' } },
  
  -- Terminal
  { mode = 'n', lhs = '<C-/>', rhs = function() require('snacks').terminal.toggle() end, opts = { desc = 'Terminal: Toggle float window' } },
}

-- Git signs keymaps (all under <leader>g for Git)
-- Navigation:
-- - ]c: Next hunk
-- - [c: Previous hunk
--
-- Actions:
-- - <leader>gh: Preview hunk
-- - <leader>gs: Stage hunk
-- - <leader>gu: Undo stage hunk
-- - <leader>gr: Reset hunk
-- - <leader>gS: Stage buffer
-- - <leader>gR: Reset buffer
-- - <leader>gb: Blame line
-- - <leader>gd: Diff this
M.gitsigns_keymaps = {
  -- Navigation
  { mode = 'n', lhs = ']c', rhs = function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() require('gitsigns').next_hunk() end)
    return '<Ignore>'
  end, opts = { desc = 'Git: Next hunk', expr = true } },

  { mode = 'n', lhs = '[c', rhs = function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() require('gitsigns').prev_hunk() end)
    return '<Ignore>'
  end, opts = { desc = 'Git: Previous hunk', expr = true } },

  -- Actions
  { mode = 'n', lhs = '<leader>gh', rhs = function() require('gitsigns').preview_hunk() end, opts = { desc = 'Git: Preview hunk' } },
  { mode = 'n', lhs = '<leader>gb', rhs = function() require('gitsigns').blame_line() end, opts = { desc = 'Git: Blame line' } },
  { mode = 'n', lhs = '<leader>gd', rhs = function() require('gitsigns').diffthis() end, opts = { desc = 'Git: Show diff' } },
  { mode = { 'n', 'v' }, lhs = '<leader>gs', rhs = function() require('gitsigns').stage_hunk() end, opts = { desc = 'Git: Stage hunk' } },
  { mode = { 'n', 'v' }, lhs = '<leader>gr', rhs = function() require('gitsigns').reset_hunk() end, opts = { desc = 'Git: Reset hunk' } },
  { mode = 'n', lhs = '<leader>gS', rhs = function() require('gitsigns').stage_buffer() end, opts = { desc = 'Git: Stage buffer' } },
  { mode = 'n', lhs = '<leader>gu', rhs = function() require('gitsigns').undo_stage_hunk() end, opts = { desc = 'Git: Undo stage' } },
  { mode = 'n', lhs = '<leader>gR', rhs = function() require('gitsigns').reset_buffer() end, opts = { desc = 'Git: Reset buffer' } },
}

-- Setup function for git signs keymaps
function M.setup_gitsigns_keymaps()
  for _, mapping in ipairs(M.gitsigns_keymaps or {}) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

-- Leap keymaps
-- 's' for bidirectional search (both forward and backward)
-- 'S' for searching in all windows
M.leap_keymaps = {
  -- 's' for bidirectional search (both forward and backward)
  { mode = { 'n', 'x', 'o' }, lhs = 's', rhs = function() require('leap').leap {} end,
    opts = { desc = 'Leap: Search bidirectional' } },
  
  -- 'S' for searching in all windows
  { mode = { 'n', 'x', 'o' }, lhs = 'S', rhs = function() 
    require('leap').leap { target_windows = vim.tbl_filter(
      function (win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )}
  end, opts = { desc = 'Leap: Search across windows' } },
}

-- Setup function for leap keymaps
function M.setup_leap_keymaps()
  for _, mapping in ipairs(M.leap_keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

-- Setup functions for keymaps
function M.setup_dadbod_keymaps()
  local keymaps = M.dadbod_keymaps or {}
  for _, mapping in ipairs(keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

function M.setup_session_keymaps()
  local keymaps = M.session_keymaps or {}
  for _, mapping in ipairs(keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

-- Initialize keymaps
local function init_keymaps()
  -- Create an autocmd group for our keymaps
  local keymap_group = vim.api.nvim_create_augroup('custom_keymaps', { clear = true })

  -- Handle snacks explorer during buffer writes
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = keymap_group,
    callback = function()
      -- Pause snacks explorer updates during write
      pcall(function()
        local picker = require('snacks.picker')
        if picker.is_open() then
          picker.pause_updates()
          vim.schedule(function()
            picker.resume_updates()
          end)
        end
      end)
    end,
  })

  -- Function to set up snacks explorer keymaps
  local function setup_explorer_keymaps()
    -- First remove any existing mappings
    for _, key in ipairs({ '<leader>e', '<leader>E' }) do
      pcall(vim.keymap.del, 'n', key)
      pcall(vim.keymap.del, 'n', key, { buffer = true })
    end
    
    -- Set our mappings with high priority
    for _, mapping in ipairs(M.snacks_keymaps or {}) do
      if mapping.lhs == '<leader>e' or mapping.lhs == '<leader>E' then
        vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, vim.tbl_extend('force', mapping.opts, {
          replace_keycodes = false,
          nowait = true,
          silent = true,
        }))
      end
    end
  end

  -- Set up autocmds to maintain our keymaps
  vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter' }, {
    group = keymap_group,
    callback = setup_explorer_keymaps,
  })

  -- Set up LSP keymaps on attach
  vim.api.nvim_create_autocmd('LspAttach', {
    group = keymap_group,
    callback = function(args)
      M.setup_lsp_keymaps(args.buf)
    end,
  })

  -- Set up core keymaps
  for _, mapping in ipairs(core_keymaps) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  -- Set up plugin keymaps
  for _, mapping in ipairs(M.telescope_keymaps or {}) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  for _, mapping in ipairs(M.diagnostic_keymaps or {}) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  for _, mapping in ipairs(M.buffer_keymaps or {}) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  -- Set up snacks keymaps
  for _, mapping in ipairs(M.snacks_keymaps or {}) do
    -- Skip explorer keymaps as they're handled by setup_explorer_keymaps
    if mapping.lhs ~= '<leader>e' and mapping.lhs ~= '<leader>E' then
      vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
    end
  end

  -- Set up scratch buffer keymaps
  for _, mapping in ipairs(M.scratch_keymaps or {}) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end

  -- Set up database keymaps
  M.setup_dadbod_keymaps()

  -- Set up session keymaps
  M.setup_session_keymaps()

  -- Set up git signs keymaps
  M.setup_gitsigns_keymaps()

  -- Set up leap keymaps
  M.setup_leap_keymaps()
end

-- Initialize all keymaps
init_keymaps()

-- Export `init_keymaps` as `M.setup` so `require('core.keymaps').setup()` works
M.setup = init_keymaps

-- Return the module
return M
