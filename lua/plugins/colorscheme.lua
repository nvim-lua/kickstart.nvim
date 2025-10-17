return {
  {
    --    'sainnhe/gruvbox-material',
    --    lazy = false,
    --    priority = 1000,
    --    config = function()
    --      vim.o.background = 'dark'
    --      vim.g.gruvbox_material_enable_italic = true
    --      vim.g.gruvbox_material_background = 'hard'
    --      vim.cmd.colorscheme 'gruvbox-material'
    --    end,
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanso').setup {
        transparent = false,
      }
      vim.cmd 'colorscheme kanso'
    end,
    -- 'catppuccin/nvim',
    --  name = 'catppuccin',
    -- priority = 1000,
    --  config = function()
    --    require('catppuccin').setup {
    --      flavour = 'mocha',
    --      transparent_background = true,
    --   }
    --   vim.cmd 'colorscheme catppuccin'
    -- end,
    -- 'rebelot/kanagawa.nvim',
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    -- name = 'kanagawa-dragon',
    -- config = function()
    --   ---@diagnostic disable-next-line: missing-fields
    --   require('kanagawa').setup {
    --     commentStyle = { italic = true },
    --     -- statementStyle = { bold = false },
    --     theme = 'dragon',
    --   }
    --   vim.cmd 'colorscheme kanagawa-dragon'
    -- end,
    --'zenbones-theme/zenbones.nvim',
    --  dependencies = 'rktjmp/lush.nvim',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd 'colorscheme zenbones'
    -- end,
    -- 'vague2k/vague.nvim',
    -- priority = 1000,
    -- name = 'vague',
    -- config = function()
    --   -- NOTE: you do not need to call setup if you don't want to.
    --   require('vague').setup {
    --     -- optional configuration here
    --   }
    --   vim.cmd 'colorscheme vague'
    -- end,
  },
}
