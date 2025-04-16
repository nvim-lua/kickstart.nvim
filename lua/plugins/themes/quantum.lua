return {
  {
    'AvidDabbler/quantum.vim',
    priority = 1000,                -- Ensure it's loaded first
    lazy = false,                   -- Load immediately
    config = function()
      vim.cmd 'colorscheme quantum' -- Explicitly set the colorscheme
    end,
  },
}
