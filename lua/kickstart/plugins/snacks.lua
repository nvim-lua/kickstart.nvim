return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    dashboard = {
      sections = {
        { icon = ' ', title = 'Recent Files', section = 'recent_files', cwd = true },
        { section = 'startup' },
      },
    },
  },
}
