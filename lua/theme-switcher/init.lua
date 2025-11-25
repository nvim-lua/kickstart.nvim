local M = {}

-- Configuration
local config = {
  save_on_select = true,
  preview_on_navigate = true,
  restore_on_startup = true,
}

-- Store original theme for preview cancellation
local original_theme = nil
local preview_enabled = false
local all_themes = {}
local filtered_themes = {}
local query = ''

-- Setup function
function M.setup(user_config)
  config = vim.tbl_deep_extend('force', config, user_config or {})

  -- Restore saved theme on startup
  if config.restore_on_startup then
    local persistence = require 'theme-switcher.persistence'
    local themes = require 'theme-switcher.themes'
    local saved_theme = persistence.load_theme()
    if saved_theme then
      themes.apply_theme(saved_theme)
    end
  end

  -- Create user commands
  vim.api.nvim_create_user_command('ThemeSwitcher', function()
    M.open()
  end, {})

  vim.api.nvim_create_user_command('ThemeSwitcherSave', function()
    local themes = require 'theme-switcher.themes'
    local persistence = require 'theme-switcher.persistence'
    local current = themes.get_current_theme()
    persistence.save_theme(current)
    vim.notify('Saved theme: ' .. current, vim.log.levels.INFO)
  end, {})
end

-- Open theme switcher
function M.open()
  local themes = require 'theme-switcher.themes'
  local ui = require 'theme-switcher.ui'

  all_themes = themes.get_available_themes()
  filtered_themes = all_themes
  query = ''

  local current_theme = themes.get_current_theme()

  -- Store original for preview cancellation
  original_theme = current_theme
  preview_enabled = config.preview_on_navigate

  local buf, win = ui.create_window(filtered_themes, current_theme)

  M.setup_keymaps(buf)
end

function M.setup_keymaps(buf)
  local opts = { buffer = buf, nowait = true, silent = true }

  -- Close and cancel
  vim.keymap.set('n', 'q', function()
    M.cancel()
  end, opts)

  vim.keymap.set('n', '<Esc>', function()
    M.cancel()
  end, opts)

  -- Select and apply
  vim.keymap.set('n', '<CR>', function()
    M.select()
  end, opts)

  -- Navigation with preview
  vim.keymap.set('n', 'j', function()
    vim.cmd 'normal! j'
    M.preview()
  end, opts)

  vim.keymap.set('n', 'k', function()
    vim.cmd 'normal! k'
    M.preview()
  end, opts)

  vim.keymap.set('n', '<Down>', function()
    vim.cmd 'normal! j'
    M.preview()
  end, opts)

  vim.keymap.set('n', '<Up>', function()
    vim.cmd 'normal! k'
    M.preview()
  end, opts)

  vim.keymap.set('n', '<C-j>', function()
    vim.cmd 'normal! j'
    M.preview()
  end, opts)

  vim.keymap.set('n', '<C-k>', function()
    vim.cmd 'normal! k'
    M.preview()
  end, opts)

  -- Text input - any printable character
  for i = 32, 126 do
    local char = string.char(i)
    vim.keymap.set('n', char, function()
      M.add_char(char)
    end, opts)
  end

  -- Backspace
  vim.keymap.set('n', '<BS>', function()
    M.remove_char()
  end, opts)

  vim.keymap.set('n', '<C-h>', function()
    M.remove_char()
  end, opts)

  -- Clear input
  vim.keymap.set('n', '<C-u>', function()
    M.clear_input()
  end, opts)

  -- Toggle preview
  vim.keymap.set('n', '<C-p>', function()
    preview_enabled = not preview_enabled
    vim.notify(preview_enabled and 'Preview enabled' or 'Preview disabled', vim.log.levels.INFO)
  end, opts)
end

function M.add_char(char)
  query = query .. char
  M.update_filter()
end

function M.remove_char()
  if #query > 0 then
    query = query:sub(1, -2)
    M.update_filter()
  end
end

function M.clear_input()
  query = ''
  M.update_filter()
end

function M.update_filter()
  local fuzzy = require 'theme-switcher.fuzzy'
  local ui = require 'theme-switcher.ui'
  local themes = require 'theme-switcher.themes'

  filtered_themes = fuzzy.filter_themes(all_themes, query)
  ui.update_display(filtered_themes, themes.get_current_theme(), query)
end

-- Preview theme while navigating
function M.preview()
  if not preview_enabled then
    return
  end

  local ui = require 'theme-switcher.ui'
  local themes = require 'theme-switcher.themes'

  local selected = ui.get_selected_theme(filtered_themes)
  if selected then
    themes.apply_theme(selected)
  end
end

-- Select and apply theme
function M.select()
  local ui = require 'theme-switcher.ui'
  local themes = require 'theme-switcher.themes'
  local persistence = require 'theme-switcher.persistence'

  local selected = ui.get_selected_theme(filtered_themes)

  if selected then
    themes.apply_theme(selected)

    if config.save_on_select then
      persistence.save_theme(selected)
    end

    vim.notify('Applied theme: ' .. selected, vim.log.levels.INFO)
  end

  ui.close_window()
end

-- Cancel and restore original theme
function M.cancel()
  local ui = require 'theme-switcher.ui'
  local themes = require 'theme-switcher.themes'

  if preview_enabled and original_theme then
    themes.apply_theme(original_theme)
  end

  ui.close_window()
end

return M
