-- Own plugins, too small for own file
-- Probably better to add one file for each
return {
  "fladson/vim-kitty",

  -- OWN PLUGINS
  -- Better scrolloff
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {},
  },

  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Better than mini.surround, imo
  -- Remember: y for "yadd".
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- "." repeats plugincommands
  "tpope/vim-repeat",

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        -- enhanced f, F, t, T motions - fix lat8r
        char = { enabled = false },
      },
    },
    keys = {
      -- stylua: ignore start
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
      -- stylua: ignore end
    },
  },

  { -- Edit files like nvim buffer
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {}, lazy = false },

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  -- [ GRAVEYARD ]
  -- Plugins I don't use anymore
  --------------------------------------------------

  -- "tpope/vim-sleuth"

  -- {
  --   -- Add indentation guides even on blank lines
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   opts = {
  --     -- char = "┊",
  --     -- show_trailing_blankline_indent = false,
  --   },
  -- },

  -- {
  --   "ggandor/leap.nvim",
  --   -- opts = {},
  --   config = function()
  --     require("leap").create_default_mappings()
  --   end,
  -- },
}
