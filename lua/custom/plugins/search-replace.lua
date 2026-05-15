return {
  'roobert/search-replace.nvim',
  config = function()
    require('search-replace').setup {
      -- optionally override defaults
      default_replace_single_buffer_options = 'gcI',
      default_replace_multi_buffer_options = 'egcI',
    }
    vim.keymap.set('v', '<C-r>', '<CMD>SearchReplaceSingleBufferVisualSelection<CR>', opts)
    vim.keymap.set('v', '<C-s>', '<CMD>SearchReplaceWithinVisualSelection<CR>', opts)
    vim.keymap.set('v', '<C-b>', '<CMD>SearchReplaceWithinVisualSelectionCWord<CR>', opts)

    vim.keymap.set('n', '<leader>rs', '<CMD>SearchReplaceSingleBufferSelections<CR>', { desc = '[s]elction list' })
    vim.keymap.set('n', '<leader>ro', '<CMD>SearchReplaceSingleBufferOpen<CR>', { desc = '[o]pen' })
    vim.keymap.set('n', '<leader>rw', '<CMD>SearchReplaceSingleBufferCWord<CR>', { desc = '[w]ord' })
    vim.keymap.set('n', '<leader>rW', '<CMD>SearchReplaceSingleBufferCWORD<CR>', { desc = '[W]ORD' })
    vim.keymap.set('n', '<leader>re', '<CMD>SearchReplaceSingleBufferCExpr<CR>', { desc = '[e]xpr' })
    vim.keymap.set('n', '<leader>rf', '<CMD>SearchReplaceSingleBufferCFile<CR>', { desc = '[f]ile' })

    vim.keymap.set('n', '<leader>rbs', '<CMD>SearchReplaceMultiBufferSelections<CR>', { desc = '[s]elction list' })
    vim.keymap.set('n', '<leader>rbo', '<CMD>SearchReplaceMultiBufferOpen<CR>', { desc = '[o]pen' })
    vim.keymap.set('n', '<leader>rbw', '<CMD>SearchReplaceMultiBufferCWord<CR>', { desc = '[w]ord' })
    vim.keymap.set('n', '<leader>rbW', '<CMD>SearchReplaceMultiBufferCWORD<CR>', { desc = '[W]ORD' })
    vim.keymap.set('n', '<leader>rbe', '<CMD>SearchReplaceMultiBufferCExpr<CR>', { desc = '[e]xpr' })
    vim.keymap.set('n', '<leader>rbf', '<CMD>SearchReplaceMultiBufferCFile<CR>', { desc = '[f]ile' })

    -- show the effects of a search / replace in a live preview window
    vim.o.inccommand = 'split'
  end,
}
