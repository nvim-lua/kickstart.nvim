-- -- Only load this plugin if it has not yet been loaded for this buffer
-- if vim.b.did_myvimtexsettings then
--   return
-- end
-- vim.b.did_myvimtexsettings = true

-- vim.api.nvim_set_keymap('n', '<leader>li', '<plug>(vimtex-info)', {desc = "Vimtex Info"})
-- vim.api.nvim_set_keymap('n', '<leader>ls', ':VimtexTocToggle<CR>', {desc = "Table Of Content Toggle"})
-- vim.api.nvim_set_keymap('n', '<leader>lv', ':VimtexView<CR>', {desc = "View in Viwer"})

-- Toggle shell escape on and off when using minted package
local function TexToggleShellEscape()
  local options = vim.g.vimtex_compiler_latexmk.options
  local shell_escape_index = vim.fn.index(options, '-shell-escape')
  if shell_escape_index ~= -1 then
    table.remove(options, shell_escape_index)
  else
    table.insert(options, 1, '-shell-escape')
  end
  vim.fn['VimtexReload']()
  vim.fn['VimtexClean']()
end

vim.api.nvim_set_keymap('n', '<leader>le', '<cmd>lua TexToggleShellEscape()<CR>', {desc = "Toggle Shell Escape"})

-- When loading new buffers, search for references to minted package in the
-- document preamble and enable shell escape if minted is detected.
local preamble_output = vim.fn.systemlist('head -n 20 ' .. vim.fn.expand('%') .. ' | grep "minted"')
if #preamble_output > 0 then
  table.insert(vim.g.vimtex_compiler_latexmk.options, 1, '-shell-escape')
end

-- Close viewers when VimTeX buffers are closed
local function CloseViewers()
  if vim.fn.executable('xdotool') == 1 and vim.b.vimtex_viewer_xwin_id > 0 then
    vim.fn.system('xdotool windowclose ' .. vim.b.vimtex_viewer_xwin_id)
  end
end

vim.cmd('augroup vimtex_event_close')
vim.cmd('au!')
vim.cmd('au User VimtexEventQuit call CloseViewers()')
vim.cmd('augroup END')

-- -- Define mappings
-- vim.api.nvim_set_keymap('n', 'dse', '<plug>(vimtex-env-delete)', {})
-- vim.api.nvim_set_keymap('n', 'dsc', '<plug>(vimtex-cmd-delete)', {})
-- vim.api.nvim_set_keymap('n', 'dsm', '<plug>(vimtex-env-delete-math)', {})
-- vim.api.nvim_set_keymap('n', 'dsd', '<plug>(vimtex-delim-delete)', {})
-- vim.api.nvim_set_keymap('n', 'cse', '<plug>(vimtex-env-change)', {})
-- vim.api.nvim_set_keymap('n', 'csc', '<plug>(vimtex-cmd-change)', {})
-- vim.api.nvim_set_keymap('n', 'csm', '<plug>(vimtex-env-change-math)', {})
-- vim.api.nvim_set_keymap('n', 'csd', '<plug>(vimtex-delim-change-math)', {})
-- vim.api.nvim_set_keymap('n', 'tsf', '<plug>(vimtex-cmd-toggle-frac)', {})
-- vim.api.nvim_set_keymap('n', 'tsc', '<plug>(vimtex-cmd-toggle-star)', {})
-- vim.api.nvim_set_keymap('n', 'tse', '<plug>(vimtex-env-toggle-star)', {})
-- vim.api.nvim_set_keymap('n', 'tsd', '<plug>(vimtex-delim-toggle-modifier)', {})
-- vim.api.nvim_set_keymap('n', 'tsD', '<plug>(vimtex-delim-toggle-modifier-reverse)', {})
-- vim.api.nvim_set_keymap('n', 'tsm', '<plug>(vimtex-env-toggle-math)', {})
-- vim.api.nvim_set_keymap('i', ']]', '<plug>(vimtex-delim-close)', {})

-- -- Text objects in operator-pending mode
-- vim.api.nvim_set_keymap('o', 'ac', '<plug>(vimtex-ac)', {})
-- vim.api.nvim_set_keymap('x', 'ac', '<plug>(vimtex-ac)', {})
-- vim.api.nvim_set_keymap('o', 'ic', '<plug>(vimtex-ic)', {})
-- vim.api.nvim_set_keymap('x', 'ic', '<plug>(vimtex-ic)', {})

-- -- Define more mappings as needed...
