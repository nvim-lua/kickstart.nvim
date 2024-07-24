return {
  'ayu-theme/ayu-vim', -- or other package manager
  config = function()
    vim.o.termguicolors = true -- enable true colors support
    local ayucolor = 'light' -- for light version of theme
    -- local ayucolor = 'mirage' -- for mirage version of theme
    -- local ayucolor = 'dark' -- for dark version of theme
  end,
}
