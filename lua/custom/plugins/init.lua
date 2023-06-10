-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-context",
  "theprimeagen/harpoon",
  "mbbill/undotree",
  "RRethy/vim-illuminate",
  "ahmedkhalf/project.nvim",
  "famiu/bufdelete.nvim",
  "tpope/vim-repeat",
  "tpope/vim-unimpaired",
  "tpope/vim-rsi",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "sindrets/diffview.nvim",
  "rhysd/git-messenger.vim",
  "lambdalisue/suda.vim",
  "stevearc/dressing.nvim",
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    -- snippets
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
  },
  {
    "lukas-reineke/virt-column.nvim",
    opts = {
      char = "┊"
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<leader>sr",
        function() require("spectre").open() end,
        desc = "[R]eplace in files (Spectre)"
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      use_diagnostic_signs = true,
    },
  },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>dn",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "[D]elete all [N]otifications",
      },
    },
    config = function()
      require("notify").setup {
        background_colour = "#000000",
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = true,
    keys = {
      { "]/",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[/",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    'echasnovski/mini.trailspace',
    version = false,
    config = function()
      require('mini.trailspace').setup()
    end
  },
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 100,             -- Width of the floating window
        height = 20,             -- Height of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false,           -- Print debug information
        opacity = nil,           -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil     -- A function taking two arguments, a buffer and a window to be ran as a hook.
      }
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
    ft = {
      "markdown"
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = {
      "markdown"
    },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
