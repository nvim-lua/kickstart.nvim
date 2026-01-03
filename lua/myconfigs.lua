vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.virtualedit = 'block'
-- vim.opt.inccommand = "split"
vim.opt.termguicolors = true

vim.api.nvim_exec2(
  [[
    function! s:ZoomToggle() abort
      if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
      else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
      endif
    endfunction
    command! ZoomToggle call s:ZoomToggle()
  ]],
  { output = false }
)

vim.keymap.set('n', ',h', [[ (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"]], { silent = true, expr = true, desc = 'toggles highlighting' })

vim.keymap.set('n', ';', ':', { noremap = true, desc = 'Command mode' })
vim.keymap.set('n', "'", '`', { noremap = true, desc = 'Mark character' })
vim.keymap.set('n', '`', "'", { noremap = true, desc = 'Mark line' })
vim.keymap.set('n', '<C-z>', '<cmd>ZoomToggle<CR>', { noremap = true, desc = 'Zoom Toggle' })

vim.keymap.set('i', 'df', '<ESC>', { noremap = true, desc = 'ESC' })
vim.keymap.set('n', '<CR>', 'o<ESC>', { noremap = true, desc = 'ESC' })

vim.keymap.set('n', 'L', '<cmd>bn<CR>', { noremap = true, desc = 'buffer next' })
vim.keymap.set('n', 'H', '<cmd>bp<CR>', { noremap = true, desc = 'buffer previous' })

vim.keymap.set('n', '<leader>w', '<cmd>:w<CR>', { noremap = true, desc = 'Save file' })

vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, desc = 'Signature Help' })
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { noremap = true, desc = 'LSP format' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, desc = 'Code Action' })

vim.api.nvim_set_keymap('n', '<leader>yr', ":let @+=expand('%:.%:t')<CR>", { noremap = true, silent = true, desc = 'Copy Relative Path' })
vim.api.nvim_set_keymap('n', '<leader>ya', ":let @+=expand('%:P%:t')<CR>", { noremap = true, silent = true, desc = 'Copy Absolute Path' })

vim.g.diagnostics_active = false
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.config { virtual_text = false }
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.config { virtual_text = true }
  end
end

vim.api.nvim_set_keymap('n', '<leader>uv', ':call v:lua.toggle_diagnostics()<CR>', { noremap = true, silent = true, desc = 'Toggle diagnostic text' })

vim.api.nvim_create_user_command('Notes', 'edit' .. vim.fn.stdpath 'config' .. '/doc/notes.txt', {})
