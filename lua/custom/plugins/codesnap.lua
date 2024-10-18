return {
  'mistricky/codesnap.nvim',
  build = 'make build_generator',
  keys = {
    { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
    { '<leader>cs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Screenshots' },
  },
  opts = {
    save_path = '~/Pictures/Screenshots/',
    -- has_breadcrumbs = true,
    bg_theme = 'bamboo',
  },
}
