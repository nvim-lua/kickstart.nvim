return {
  'echasnovski/mini.statusline',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional for icons
  opts = function(_, opts)
    local statusline = require 'mini.statusline'

    -- Add new section function
    statusline.section_target = function()
      local target = require('custom.utils'):get_target()
      return target and (' ' .. target) or ''
    end

    -- Override content.active to include target
    opts.content = opts.content or {}
    opts.content.active = function()
      local mode, git, diagnostics, filename, fileinfo, target, location =
        statusline.section_mode(),
        statusline.section_git(),
        statusline.section_diagnostics(),
        statusline.section_filename(),
        statusline.section_fileinfo(),
        statusline.section_target(),
        statusline.section_location()

      return statusline.combine_groups {
        { hl = 'MiniStatuslineModeNormal', strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = 'MiniStatuslineTarget', strings = { target } },
        { hl = 'MiniStatuslineLocation', strings = { location } },
      }
    end

    return opts
  end,
}
