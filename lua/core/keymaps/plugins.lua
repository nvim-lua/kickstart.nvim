---@diagnostic disable: undefined-global
-- Plugin keymaps (dadbod, session, scratch, snacks, leap, elixir, mini-surround)

local M = {}

-- Database keymaps
M.dadbod = {
  { mode = 'n', lhs = '<leader>Dt', rhs = '<cmd>DBUIToggle<CR>', opts = { desc = 'Database: Toggle UI' } },
  { mode = 'n', lhs = '<leader>Df', rhs = '<cmd>DBUIFindBuffer<CR>', opts = { desc = 'Database: Find buffer' } },
  { mode = 'n', lhs = '<leader>Dr', rhs = '<cmd>DBUIRenameBuffer<CR>', opts = { desc = 'Database: Rename buffer' } },
  { mode = 'n', lhs = '<leader>Dl', rhs = '<cmd>DBUILastQueryInfo<CR>', opts = { desc = 'Database: Last query' } },
}

-- Session keymaps
M.session = {
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
M.scratch = {
  { mode = 'n', lhs = '<leader>.', rhs = function() require("snacks").scratch() end, opts = { desc = 'Toggle scratch buffer' } },
  { mode = 'n', lhs = '<leader>S', rhs = function() require("snacks").scratch.select() end, opts = { desc = 'Select scratch buffer' } },
  { mode = 'n', lhs = '<leader>nh', rhs = function() require("snacks.notifier").show_history() end, opts = { desc = 'Show notification history' } },
}

-- Snacks keymaps (explorer and terminal)
M.snacks = {
  { mode = 'n', lhs = '<leader>e', rhs = function() require('snacks').explorer.open() end, opts = { desc = 'Explorer: Toggle' } },
  { mode = 'n', lhs = '<leader>E', rhs = function() require('snacks').explorer.reveal() end, opts = { desc = 'Explorer: Focus current file' } },
  { mode = 'n', lhs = '<leader>o', rhs = function() vim.cmd('tab split %') end, opts = { desc = 'Open current file in new tab' } },
  { mode = 'n', lhs = '<leader>f', rhs = function()
    vim.cmd('tabnew')
    require('snacks').explorer.open()
  end, opts = { desc = 'Explorer: Open in new tab' } },
  { mode = 'n', lhs = '<C-/>', rhs = function() require('snacks').terminal.toggle() end, opts = { desc = 'Terminal: Toggle float window' } },
  { mode = 'n', lhs = '<leader>tc', rhs = function() require('snacks').terminal.toggle() end, opts = { desc = 'Terminal: Toggle console' } },
}

-- Leap keymaps
M.leap = {
  { mode = { 'n', 'x', 'o' }, lhs = 's', rhs = function() require('leap').leap {} end, opts = { desc = 'Leap: Search bidirectional' } },
  { mode = { 'n', 'x', 'o' }, lhs = 'S', rhs = function()
    require('leap').leap { target_windows = vim.tbl_filter(
      function (win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )}
  end, opts = { desc = 'Leap: Search across windows' } },
}

-- Elixir keymaps
M.elixir = {
  { mode = 'n', lhs = '<leader>xt', rhs = function() require('elixir').run_test_file() end, opts = { desc = 'Elixir: Test file' } },
  { mode = 'n', lhs = '<leader>xn', rhs = function() require('elixir').run_nearest_test() end, opts = { desc = 'Elixir: Test nearest' } },
  { mode = 'n', lhs = '<leader>xm', rhs = function() vim.cmd('Telescope elixir mix') end, opts = { desc = 'Elixir: Mix tasks' } },
}

-- Mini-surround keymaps (used by mini.surround config)
M.mini_surround = {
  add = 'sa',
  delete = 'sd',
  find = 'sf',
  find_left = 'sF',
  highlight = 'sh',
  replace = 'sr',
  update_n_lines = '',
  suffix_last = 'l',
  suffix_next = 'n',
}

-- Setup functions
function M.setup_dadbod()
  for _, mapping in ipairs(M.dadbod) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

function M.setup_session()
  for _, mapping in ipairs(M.session) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

function M.setup_scratch()
  for _, mapping in ipairs(M.scratch) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

function M.setup_snacks()
  for _, mapping in ipairs(M.snacks) do
    if mapping.lhs ~= '<leader>e' and mapping.lhs ~= '<leader>E' then
      vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
    end
  end
end

function M.setup_leap()
  for _, mapping in ipairs(M.leap) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

function M.setup_elixir()
  for _, mapping in ipairs(M.elixir) do
    vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
  end
end

return M
