-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config to whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

---@module 'lazy'
---@type LazySpec
return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      style = 'night', -- 'night' | 'storm' | 'moon' | 'day'
      transparent = true, -- let the terminal background show through
      terminal_colors = true, -- theme the colors of the built-in :terminal
      styles = {
        comments = { italic = false }, -- Disable italics in comments
        sidebars = 'transparent', -- 'dark' | 'transparent' | 'normal'
        floats = 'transparent', -- background for floating windows
      },
      dim_inactive = false, -- dim windows that aren't focused
    }

    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
