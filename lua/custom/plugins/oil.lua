return {
  'stevearc/oil.nvim',
  cmd = { 'Oil' },
  keys = {
    { '<leader>eo', '<cmd>Oil<CR>', desc = '[E]xplorer [O]il' },
  },
  opts = {
    default_file_explorer = false,
    columns = { 'icon' },
    view_options = {
      show_hidden = true,
    },
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 2000,
      autosave_changes = 'unmodified',
    },
  },
}
