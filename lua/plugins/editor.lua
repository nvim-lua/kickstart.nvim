return {
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    version = false,
    opts = { n_lines = 500 },
  },
  {
    "echasnovski/mini.surround",
    version = false,
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next git change")
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Previous git change")

        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("x", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")
        map("x", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo staged hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", gs.blame_line, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff against index")
        map("n", "<leader>hD", function()
          gs.diffthis("@")
        end, "Diff against last commit")
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>sh", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Search hidden files" },
      { "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "Search keymaps" },
      { "<leader>sf", function() require("telescope.builtin").find_files() end, desc = "Search files" },
      { "<leader>ss", function() require("telescope.builtin").builtin() end, desc = "Search pickers" },
      { "<leader>sw", function() require("telescope.builtin").grep_string() end, desc = "Search current word" },
      { "<leader>sg", function() require("telescope.builtin").live_grep() end, desc = "Search by grep" },
      { "<leader>sd", function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
      { "<leader>sr", function() require("telescope.builtin").resume() end, desc = "Resume search" },
      { "<leader>s.", function() require("telescope.builtin").oldfiles() end, desc = "Search recent files" },
      { "<leader><leader>", function() require("telescope.builtin").buffers() end, desc = "Search buffers" },
      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({ previewer = false })
          )
        end,
        desc = "Search current buffer",
      },
      {
        "<leader>s/",
        function()
          require("telescope.builtin").live_grep({ grep_open_files = true })
        end,
        desc = "Search open files",
      },
      {
        "<leader>sn",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config"), hidden = true, no_ignore = true })
        end,
        desc = "Search Neovim config",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      local opts = {
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown(),
        },
      }
      local overrides = (pcall(require, "local.overrides") and require("local.overrides") or {})
      opts = vim.tbl_deep_extend("force", opts, (overrides.telescope or {}).opts or {})
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "c", "cpp", "css", "html", "javascript", "json", "lua", "markdown",
        "markdown_inline", "python", "rust", "tsx", "typescript", "vim", "vimdoc",
      }
      require("nvim-treesitter").setup({})
      require("nvim-treesitter").install(parsers)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
        callback = function(args)
          local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if language then
            pcall(vim.treesitter.start, args.buf, language)
          end
        end,
      })
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = { { "<leader>sR", "<cmd>GrugFar<CR>", desc = "Search and replace" } },
    opts = {},
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>ma", function() require("harpoon"):list():add() end, desc = "Add file mark" },
      { "<leader>mm", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Open marks" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Open mark 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Open mark 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Open mark 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Open mark 4" },
    },
  },
}
