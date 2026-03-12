return {
  'brenoprata10/nvim-highlight-colors',
  config = function()
    require('nvim-highlight-colors').setup {
      -- # default config

      -- ---Render style
      -- ---@usage 'background'|'foreground'|'virtual'
      -- render = 'background',
      --
      -- ---Set virtual symbol (requires render to be set to 'virtual')
      -- virtual_symbol = '■',
      --
      -- ---Set virtual symbol suffix (defaults to '')
      -- virtual_symbol_prefix = '',
      --
      -- ---Set virtual symbol suffix (defaults to ' ')
      -- virtual_symbol_suffix = ' ',
      --
      -- ---Set virtual symbol position()
      -- ---@usage 'inline'|'eol'|'eow'
      -- ---inline mimics VS Code style
      -- ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
      -- ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
      -- virtual_symbol_position = 'inline',
      --
      -- ---Highlight hex colors, e.g. '#FFFFFF'
      -- enable_hex = true,
      --
      -- ---Highlight short hex colors e.g. '#fff'
      -- enable_short_hex = true,
      --
      -- ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
      -- enable_rgb = true,
      --
      -- ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
      -- enable_hsl = true,
      --
      -- ---Highlight ansi colors, e.g '\033[0;34m'
      -- enable_ansi = true,
      --
      -- ---Highlight xterm 256 (8bit) colors, e.g '\033[38;5;118m'
      -- enable_xterm256 = true,
      --
      -- ---Highlight xterm True Color (24bit) colors, e.g '\033[38;2;118;64;90m'
      -- enable_xtermTrueColor = true,
      --
      -- -- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
      -- enable_hsl_without_function = true,
      --
      -- ---Highlight CSS variables, e.g. 'var(--testing-color)'
      -- enable_var_usage = true,
      --
      -- ---Highlight named colors, e.g. 'green'
      -- enable_named_colors = true,
      --
      -- ---Highlight tailwind colors, e.g. 'bg-blue-500'
      -- enable_tailwind = false,
      --
      -- ---Set custom colors
      -- ---Label must be properly escaped with '%' to adhere to `string.gmatch`
      -- --- :help string.gmatch
      -- custom_colors = {
      --   { label = '%-%-theme%-primary%-color', color = '#0f1219' },
      --   { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
      -- },
      --
      -- -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
      -- exclude_filetypes = {},
      -- exclude_buftypes = {},
      -- -- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
      -- exclude_buffer = function(bufnr) end,
    }
  end,
}
