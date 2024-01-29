--
-- copilot setup config
--

local M = {
  'zbirenbaum/copilot.lua',
  event = 'BufRead',
}

-- Copilot setup
function M.config()
  require('copilot').setup({
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 50,
      keymap = {
        accept = '<M-a>',
        accept_word = '<M-w>',
        accept_line = '<M-b>',
        next = '<c-j>',
        prev = '<c-k>',
        dismiss = '<C-d>',
      },
    },
  })
end

return M
