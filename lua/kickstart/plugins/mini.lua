local gh = require('kickstart.util').gh

vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- Icons (only if Nerd Font available)
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects (vag, cia, etc.)
require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Surround (add/delete/replace brackets, quotes, etc.)
require('mini.surround').setup()

-- Statusline
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
statusline.section_location = function() return '%2l:%-2v' end
