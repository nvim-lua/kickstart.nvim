return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        -- char = '▏',
        char = '╎',
      },
      exclude = {
        filetypes = { 'dashboard' },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)

      vim.keymap.set('n', '<leader>ti', ':IBLToggle<CR>', { noremap = true, silent = true, desc = '[T]oggle [I]ndent guides' })
    end,
  },
}
