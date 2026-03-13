return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    -- Set to false if you want to keep using your mouse while learning
    disable_mouse = true,

    -- After 3 repeated presses of a key, it will block you for 1 second
    max_time = 1000,
    max_count = 3,

    -- This will give you hints like "Use 5j instead of jjjjj"
    hint = true,

    -- You can disable it for specific filetypes like the Lazy dashboard
    disabled_filetypes = { 'qf', 'netrw', 'NvimTree', 'lazy', 'mason' },
  },
}
