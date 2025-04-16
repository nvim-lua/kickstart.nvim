return {
  'navarasu/onedark.nvim',
  commit = 'dd640f6',
  priority = 1000,
  config = function()
    -- vim.cmd.colorscheme 'onedark'

    local config = {
      -- Main options --
      style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = true, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = '<leader>th', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {
        -- purple = '#56b6c2',
      }, -- Override default colors
      highlights = {}, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    }

    local onedark = require 'onedark'
    onedark.setup(config)
    onedark.load()

    -- Make the background of diagnostics messages transparent
    local set_diagnostics_bg_transparency = function()
      vim.cmd [[highlight DiagnosticVirtualTextError guibg=none]]
      vim.cmd [[highlight DiagnosticVirtualTextWarn guibg=none]]
      vim.cmd [[highlight DiagnosticVirtualTextInfo guibg=none]]
      vim.cmd [[highlight DiagnosticVirtualTextHint guibg=none]]
    end
    set_diagnostics_bg_transparency()

    -- Toggle background transparency
    local toggle_transparency = function()
      config.transparent = not config.transparent
      onedark.setup(config)
      onedark.load()
      set_diagnostics_bg_transparency()
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}

-- OneDark colors
--	black = "#181a1f",
--	bg0 = "#282c34",
--	bg1 = "#31353f",
--	bg2 = "#393f4a",
--	bg3 = "#3b3f4c",
--	bg_d = "#21252b",
--	bg_blue = "#73b8f1",
--	bg_yellow = "#ebd09c",
--	fg = "#abb2bf",
--	purple = "#c678dd",
--	green = "#98c379",
--	orange = "#d19a66",
--	blue = "#61afef",
--	yellow = "#e5c07b",
--	cyan = "#56b6c2",
--	red = "#e86671",
--	grey = "#5c6370",
--	light_grey = "#848b98",
--	dark_cyan = "#2b6f77",
--	dark_red = "#993939",
--	dark_yellow = "#93691d",
--	dark_purple = "#8a3fa0",
--	diff_add = "#31392b",
--	diff_delete = "#382b2c",
--	diff_change = "#1c3448",
--	diff_text = "#2c5372",
