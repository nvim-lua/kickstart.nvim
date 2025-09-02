-- Editor Enhancement Configuration
local M = {}

function M.setup_mini()
  -- Better Around/Inside textobjects
  require('mini.ai').setup { n_lines = 500 }
  
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  require('mini.surround').setup()
  
  -- Simple and easy statusline
  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font }
  
  -- Custom statusline location section
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%2l:%-2v'
  end
end

function M.setup_illuminate()
  require('illuminate').configure({
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { 'lsp' },
    },
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    filetypes_denylist = {
      'dirbuf',
      'dirvish',
      'fugitive',
      'alpha',
      'NvimTree',
      'lazy',
      'neogitstatus',
      'Trouble',
      'lir',
      'Outline',
      'spectre_panel',
      'toggleterm',
      'DressingSelect',
      'TelescopePrompt',
    },
    under_cursor = true,
  })
end

function M.setup()
  M.setup_mini()
  M.setup_illuminate()
end

return M