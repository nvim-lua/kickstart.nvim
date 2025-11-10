return {
  { -- Add indentation guides even on blank lines
    'saghen/blink.indent',
    -- See: https://github.com/saghen/blink.indent
    --- @module 'blink.indent'
    --- @type blink.indent.Config
    opts = {
      static = {
        enabled = true, -- Enable static indent guides
        char = '▏', -- Thinner character (alternatives: '│', '┊', '┆', '¦', '|', '⁞')
      },
      scope = {
        enabled = false, -- Disable scope highlighting
      },
    },
  },
}
