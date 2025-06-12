return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000, -- needs to be loaded in first
    config = function(_, opts)
      vim.opt.updatetime = 100
      vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#f76464' })
      vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#f7bf64' })
      vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#64bcf7' })
      vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#64f79d' })
      require('tiny-inline-diagnostic').setup(opts)
    end,
    opts = {
      enable_on_insert = true,
      multiple_diag_under_cursor = true,
      show_all_diags_on_cursorline = true,
      multilines = {
        enabled = false,
        always_show = true,
      },
      signs = {
        left = '',
        right = '',
        diag = '',
        arrow = '    ',
        up_arrow = '    ',
        vertical = ' │',
        vertical_end = ' └',
      },
    },
  },
}
