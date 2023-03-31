return {
  'mbledkowski/neuleetcode.vim',
  config = function()
    vim.g.leetcode_browser = 'chrome'
    vim.keymap.set('n', '<leader>ll', ':LeetCodeList<CR>', { desc = '[L]eetCode [L]ist' })
    vim.keymap.set('n', '<leader>lt', ':LeetCodeTest<CR>', { desc = '[L]eetCode [T]est' })
    vim.keymap.set('n', '<leader>ls', ':LeetCodeSubmit<CR>', { desc = '[L]eetCode [S]ubmit' })
    vim.keymap.set('n', '<leader>li', ':LeetCodeSignIn<CR>', { desc = '[L]eetCode Sign [I]n' })
  end,
}
