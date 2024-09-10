return {
  'folke/twilight.nvim',
  opts = {
    dimming = {
      alpha = 0.25, -- amount of dimming
      -- we try to get the foreground from the highlight groups or fallback color
      color = { 'Normal', '#ffffff' },
      term_bg = '#000000', -- if guibg=NONE, this will be used to calculate text color
      inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },
    context = 10, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      'function',
      'method',
      'table',
      'if_statement',
      'paragraph',
    },
    exclude = {}, -- exclude these filetypes
  },
}
