---@diagnostic disable: undefined-global
-- GitSigns setup module
local M = {}

function M.setup()
  require('gitsigns').setup({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '-' },
      topdelete = { text = '-' },
      changedelete = { text = '~' },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = { interval = 1000, follow_files = true },
    attach_to_untracked = true,
    current_line_blame = false,
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    preview_config = { border = 'single', style = 'minimal', relative = 'cursor', row = 0, col = 1 },
  })
end

return M
