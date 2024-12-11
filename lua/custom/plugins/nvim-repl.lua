return {
  'pappasam/nvim-repl',
  lazy = false,
  init = function()
    vim.g['repl_filetype_commands'] = {
      bash = 'bash',
      javascript = 'node',
      haskell = 'ghci',
      python = 'ipython --no-autoindent',
      r = 'R',
      sh = 'sh',
      vim = 'nvim --clean -ERM',
      zsh = 'zsh',
    }
  end,
  keys = {
    { '<Leader>sc', '<Plug>(ReplSendCell)', mode = 'n', desc = 'Send Repl Cell' },
    { '<Leader>sl', '<Plug>(ReplSendLine)', mode = 'n', desc = 'Send Repl Line' },
    { '<Leader>sr', '<Plug>(ReplSendVisual)', mode = 'v', desc = 'Send Repl Visual Selection' },
  },
}
