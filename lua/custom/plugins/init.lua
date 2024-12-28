-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },

    opts = {
      initial_state = false,
    },
    config = function(_, opts)
      require('markview').setup(opts)

      -- This function imitates the behavior of Joplin when rendering notes
      local splitToggle_state = 0
      vim.keymap.set('n', '<C-ö>', function()
        if splitToggle_state == 0 then
          vim.cmd 'Markview enableAll'
          splitToggle_state = 1
        elseif splitToggle_state == 1 then
          vim.cmd 'Markview splitEnable'
          splitToggle_state = 2
        else
          vim.cmd 'Markview splitDisable'
          vim.cmd 'Markview disableAll'
          splitToggle_state = 0
        end
      end, { silent = true, desc = 'Toggle Markview split view' })
    end,
  },
}
