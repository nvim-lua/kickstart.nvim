-- must be after `require("dap-python").setup(debugpy_path)`
local dap = require 'dap'
local dap_python = require 'dap-python'

-- ─── General DAP mappings ────────────────────────────────────────────────────
vim.keymap.set('n', '<F5>', dap.continue, { desc = '▶ Continue' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = '⤼ Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = '⤽ Step Into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = '⤾ Step Out' })

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = ' Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function() -- conditional
  dap.set_breakpoint(nil, nil, vim.fn.input 'Breakpoint condition: ')
end, { desc = ' Set Conditional Breakpoint' })

vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = ' Open DAP REPL' })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = ' Run Last Session' })

-- Move current line down with J
vim.keymap.set('n', 'J', ':m .+1<CR>==', { noremap = true, silent = true })

-- Move current line up with K
vim.keymap.set('n', 'K', ':m .-2<CR>==', { noremap = true, silent = true })

-- Map <leader>T to toggle terminal
vim.keymap.set('n', 'T', function()
  local Terminal = require('toggleterm.terminal').Terminal
  local float_term = Terminal:new {
    direction = 'float',
    hidden = true, -- ensures it doesn't persist visually
  }
  float_term:toggle()
  require('toggleterm').toggle_all()
end, { desc = 'Toggle Floating Terminal' })

vim.keymap.set('n', '<leader>bd', function()
  -- Close all open toggleterm terminals
  require('toggleterm').toggle_all()

  -- Then close the current buffer
  vim.cmd 'bdelete!'
end, { desc = 'Close buffer and toggleterm' })

vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzy search in current buffer' })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

return {}
