return {
  'tomasky/bookmarks.nvim',
  config = function()
    require('bookmarks').setup {
      on_attach = function(bufnr)
        local bm = require 'bookmarks'
        local map = vim.keymap.set
        local telescope = require 'telescope'
        map('n', '<leader>mm', bm.bookmark_toggle, { desc = 'Toggle bookmark' }) -- add or remove bookmark at current line
        map('n', '<leader>mi', bm.bookmark_ann, { desc = 'Annotate bookmark' }) -- add or edit mark annotation at current line
        map('n', '<leader>mc', bm.bookmark_clean, { desc = 'Clean marks in buffer' }) -- clean all marks in local buffer
        map('n', '<leader>mn', bm.bookmark_next, { desc = 'Next bookmark in buffer' }) -- jump to next mark in local buffer
        map('n', '<leader>mp', bm.bookmark_prev, { desc = 'Previous bookmark in buffer' }) -- jump to previous mark in local buffer
        -- map('n', 'ml', bm.bookmark_list) -- show marked file list in quickfix window
        map('n', '<leader>ml', telescope.extensions.bookmarks.list, { desc = 'List bookmarks' }) -- show marked file list in quickfix window
        map('n', '<leader>mx', bm.bookmark_clear_all, { desc = 'Clear all bookmarks' }) -- removes all bookmarks
      end,
    }
    pcall(require('telescope').load_extension, 'bookmarks')
  end,
}
