return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      -- passing as an option does not work correctly at present w/ toggle
      require('ibl').setup {}
      require('ibl').update { enabled = false }
    end,
    keys = {
      { '<Leader>ib', '<cmd>IBLToggle<cr>', desc = 'Indent lines toggle' },
    },
  },
}
