return {
  'codota/tabnine-nvim',
  name = 'tabnine',
  build = './dl_binaries.sh',
  config = function()
    require('tabnine').setup {
      disable_auto_comment = true,
      accept_keymap = '<Tab>',
      dismiss_keymap = '<C-]>',
      debounce_ms = 800,
      suggestion_color = { gui = '#808080', cterm = 244 },
      exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
      log_file_path = nil,
      ignore_certificate_errors = false,
    }
    require('tabnine.status').disable_tabnine()
  end,
  lazy = false,
  keys = {
    { '<leader>lc', '<cmd>TabnineChat<cr>', desc = '[L]LM [C]hat' },
    { '<leader>lt', '<cmd>TabnineToggle<cr>', desc = '[L]LM [T]oggle' },
    { '<leader>ls', '<cmd>TabnineStatus<cr>', desc = '[L]LM [S]tatus' },
  },
}
