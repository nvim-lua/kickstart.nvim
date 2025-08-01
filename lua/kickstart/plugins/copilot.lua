return {
  'github/copilot.vim',
  event = 'InsertEnter',
  config = function()
    vim.g.copilot_no_tab_map = true

    local keymap = vim.keymap.set
    keymap('i', '<C-L>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
    keymap('i', '<M-j>', 'copilot#Next()', { expr = true, silent = true })
    keymap('i', '<M-k>', 'copilot#Previous()', { expr = true, silent = true })
    keymap('i', '<C-E>', 'copilot#Dismiss()', { expr = true, silent = true })
  end,
}
