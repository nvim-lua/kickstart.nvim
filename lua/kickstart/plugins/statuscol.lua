-- Provide a configurable 'statuscolumn' and click handlers
return {
  'luukvbaal/statuscol.nvim',
  config = function()
    vim.opt.fillchars = vim.g.have_nerd_font and { foldclose = '', foldopen = '', foldsep = ' ' } or { foldclose = '˃', foldopen = '˅', foldsep = ' ' }
    vim.opt.foldcolumn = '1'

    local builtin = require 'statuscol.builtin'
    require('statuscol').setup {
      -- configuration goes here, for example:
      relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
      segments = {
        {
          sign = { namespace = { 'diagnostic/signs' } },
          click = 'v:lua.ScSa',
        },
        {
          sign = { name = { '.*' }, colwidth = 1 }, -- signs like breakpoints, etc.
          click = 'v:lua.ScSa',
        },
        { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' }, -- line number that can be configured through a few options
        {
          sign = { namespace = { 'gitsigns' }, colwidth = 1 },
          click = 'v:lua.ScSa',
        },
        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' }, -- fold column that does not print the fold depth digits
        { text = { ' ' } }, -- whitespace padding
      },
    }
  end,
}
