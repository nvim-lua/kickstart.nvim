return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    win_options = {
      signcolumn = 'yes:2',
    },
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    watch_for_changes = true,
  },
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
}
