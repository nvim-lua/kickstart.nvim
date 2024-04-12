return {
  'petertriho/nvim-scrollbar',
  version = '*',
  config = {
    show = true,
    show_in_active_only = false,
    set_highlights = true,
    folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    max_lines = false, -- disables if no. of lines in buffer exceeds this
    hide_if_all_visible = true, -- Hides everything if all lines are visible
    throttle_ms = 100,
    handle = {
      text = ' ',
      blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
      color = nil,
      color_nr = nil, -- cterm
      highlight = 'CursorColumn',
      hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
      Cursor = {
        text = '•',
        priority = 0,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'Normal',
      },
      Search = {
        text = { '-', '=' },
        priority = 1,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'Search',
      },
      Error = {
        text = { '-', '=' },
        priority = 2,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'DiagnosticVirtualTextError',
      },
      Warn = {
        text = { '-', '=' },
        priority = 3,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'DiagnosticVirtualTextWarn',
      },
      Info = {
        text = { '-', '=' },
        priority = 4,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'DiagnosticVirtualTextInfo',
      },
      Hint = {
        text = { '-', '=' },
        priority = 5,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'DiagnosticVirtualTextHint',
      },
      Misc = {
        text = { '-', '=' },
        priority = 6,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'Normal',
      },
      GitAdd = {
        text = '┆',
        priority = 7,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'GitSignsAdd',
      },
      GitChange = {
        text = '┆',
        priority = 7,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'GitSignsChange',
      },
      GitDelete = {
        text = '▁',
        priority = 7,
        gui = nil,
        color = nil,
        cterm = nil,
        color_nr = nil, -- cterm
        highlight = 'GitSignsDelete',
      },
    },
    excluded_buftypes = {
      'terminal',
    },
    excluded_filetypes = {
      'cmp_docs',
      'cmp_menu',
      'noice',
      'prompt',
      'TelescopePrompt',
    },
    autocmd = {
      render = {
        'BufWinEnter',
        'TabEnter',
        'TermEnter',
        'WinEnter',
        'CmdwinLeave',
        'TextChanged',
        'VimResized',
        'WinScrolled',
      },
      clear = {
        'BufWinLeave',
        'TabLeave',
        'TermLeave',
        'WinLeave',
      },
    },
    handlers = {
      cursor = false,
      diagnostic = true,
      gitsigns = false, -- Requires gitsigns
      handle = true,
      search = false, -- Requires hlslens
      ale = false, -- Requires ALE
    },
  },
}
