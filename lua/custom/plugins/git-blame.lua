return {
  'f-person/git-blame.nvim',
  event = 'UIEnter',
  config = function()
    require('gitblame').setup {
      enabled = false,
    }
    vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { desc = 'Toggle Git Blame' })
    vim.keymap.set('n', '<leader>go', ':GitBlameOpenCommitURL<CR>', { desc = '[G]it Blame [O]pen Commit URL' })
    vim.keymap.set('n', '<leader>gf', ':GitBlameOpenFileURL<CR>', { desc = '[G]it Blame Open [F]ile URL' })
  end,
}
