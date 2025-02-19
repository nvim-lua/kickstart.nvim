return {
  'wfxr/minimap.vim',
  build = 'cargo install --locked code-minimap',
  -- lazy = false,
  enable = false,
  cmd = { 'Minimap', 'MinimapClose', 'MinimapToggle', 'MinimapRefresh', 'MinimapUpdateHighlight' },
  init = function()
    vim.cmd 'let g:minimap_width = 10'
    vim.cmd 'let g:minimap_auto_start = 1'
    vim.cmd 'let g:minimap_auto_start_win_enter = 1'
  end,
}
