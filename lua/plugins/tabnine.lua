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
    if vim.g.tabnine_enable then
      require('tabnine.status').enable_tabnine()
    else
      require('tabnine.status').disable_tabnine()
    end
  end,
  lazy = false,
  keys = {
    { '<leader>t9', '<cmd>TabnineToggle<cr>', desc = '[T]oggle' },
    { '<leader>l9e', '<cmd>TabnineEnable<cr>', desc = 'T9 [E]nable' },
    { '<leader>l9c', '<cmd>TabnineChat<cr>', desc = 'T9 [C]hat' },
    { '<leader>l9s', '<cmd>TabnineStatus<cr>', desc = 'T9 [S]tatus' },
  },
}
