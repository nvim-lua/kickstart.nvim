return {
  'github/copilot.vim',
  lazy = false,
  init = function()
    local map = vim.api.nvim_set_keymap

    map('i', '<C-o>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
  end,
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ''
  end,
}
