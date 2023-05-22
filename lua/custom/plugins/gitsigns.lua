return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = {hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
      change = {
        hl = 'GitSignsChange',
        text = '│',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn'
      },
      delete = {
        hl = 'GitSignsDelete',
        text = '-',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn'
      },
      topdelete = {
        hl = 'GitSignsDelete',
        text = '‾',
        numhl = 'GitSignsDeleteNr',
        linehl = 'GitSignsDeleteLn'
      },
      changedelete = {
        hl = 'GitSignsChange',
        text = '~',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn'
      }
    },
    numhl = true,
    linehl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ['n <leader>hn'] = {
        expr = true,
        "&diff ? '<leader>hn' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
      },
      ['n <leader>hN'] = {
        expr = true,
        "&diff ? '<leader>hN' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
      },

      ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>'
    },
    watch_gitdir = {interval = 1000},
    current_line_blame = true,
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    diff_opts = {internal = true}
  }
}
