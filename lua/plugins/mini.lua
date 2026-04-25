-- Collection of various small independent plugins/modules
return {
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yiiq - [Y]ank [I]nside [I]next [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
      mappings = {
        around_next = 'aa',
        inside_next = 'ii',
      },
      n_lines = 500,
    }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- -- Simple and easy statusline.
    -- --  You could remove this setup call if you don't like it,
    -- --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }
    --
    -- -- You can configure sections in the statusline by overriding their
    -- -- default behavior. For example, here we set the section for
    -- -- cursor location to LINE:COLUMN
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%2l:%-2v'
    -- end

    -- general icon provider. Several categories (file, directory, OS, LSP, etc.)
    -- with better styles, colorscheme blending, and more
    require('mini.icons').setup()
    require('mini.icons').mock_nvim_web_devicons()

    -- plugin to split and join arguments
    -- - gS    - Toggle [S]plit/join arguments
    require('mini.splitjoin').setup()

    -- ... and there is more!
    --  Check out: https://github.com/nvim-mini/mini.nvim
  end,
}
