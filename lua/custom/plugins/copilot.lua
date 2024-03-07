return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_workspace_folders = { vim.fn.getcwd() }
    vim.g.copilot_no_auto_mappings = true
    vim.keymap.set('n', '<leader>cpe', ':Copilot enable<CR>', { noremap = true, desc = '[C]o[P]ilot [E]nable' })
    vim.keymap.set('n', '<leader>cpd', ':Copilot disable<CR>', { noremap = true, desc = '[C]o[P]ilot [D]isable' })
    vim.keymap.set('n', '<leader>cpp', ':Copilot panel<CR>', { noremap = true, desc = '[C]o[P]ilot [P]annel' })
  end,
}
