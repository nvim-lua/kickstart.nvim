-- lua/plugins/markdown.lua
return {
  -- In-buffer markdown rendering: styled headers, bullet symbols, visual checkboxes
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      render_modes = { "n", "c" }, -- render in normal and command mode only (not insert)
      heading = {
        enabled = true,
        sign = false, -- no sign column icons
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰱒 " },
      },
      code = {
        enabled = true,
        sign = false,
        style = "full",
      },
      pipe_table = { enabled = true },
    },
  },

  -- Auto-continue lists: press Enter at end of a list item to get the next bullet/number
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown" },
    config = function()
      require("autolist").setup()

      -- Scope all keymaps to markdown buffers only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
          end

          -- Continue list on Enter / new line
          map("i", "<CR>",    "<CR><cmd>AutolistNewBullet<cr>",      "Continue list")
          map("n", "o",       "o<cmd>AutolistNewBullet<cr>",         "New list item below")
          map("n", "O",       "O<cmd>AutolistNewBulletBefore<cr>",   "New list item above")

          -- Toggle checkbox
          map("n", "<CR>",    "<cmd>AutolistToggleCheckbox<cr>",     "Toggle checkbox")

          -- Recalculate numbered list after reordering/deleting
          map("n", "<leader>mr", "<cmd>AutolistRecalculate<cr>",     "Recalculate list numbers")

          -- Indent/dedent list item in insert mode
          map("i", "<Tab>",   "<cmd>AutolistTab<cr>",                "Indent list item")
          map("i", "<S-Tab>", "<cmd>AutolistShiftTab<cr>",           "Dedent list item")
        end,
      })
    end,
  },

  -- Full Obsidian-like note-taking
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- Default vault; new notes always land in the current working directory
      workspaces = {
        {
          name = "default",
          path = "~/notes",
        },
      },
      new_notes_location = "current_dir",

      -- Note naming: use the title as filename
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,

      -- wiki-link style [[...]]
      preferred_link_style = "wiki",

      -- Let render-markdown.nvim handle rendering
      ui = { enable = false },

      -- Open URLs with macOS `open`
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url })
      end,

      -- nvim-cmp completion for wiki links
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      mappings = {
        -- Follow link or create note under cursor
        ["gf"] = {
          action = function() return require("obsidian").util.gf_passthrough() end,
          opts = { noremap = false, expr = true, buffer = true, desc = "Follow link" },
        },
        -- Toggle checkbox
        ["<CR>"] = {
          action = function() return require("obsidian").util.toggle_checkbox() end,
          opts = { buffer = true, desc = "Toggle checkbox" },
        },
      },
    },

    config = function(_, opts)
      require("obsidian").setup(opts)

      -- <leader>m prefix for markdown/notes commands
      vim.keymap.set("n", "<leader>mn", "<cmd>ObsidianNew<cr>",          { desc = "New note" })
      vim.keymap.set("n", "<leader>mf", "<cmd>ObsidianSearch<cr>",       { desc = "Find/search notes" })
      vim.keymap.set("n", "<leader>mo", "<cmd>ObsidianOpen<cr>",         { desc = "Open in Obsidian app" })
      vim.keymap.set("n", "<leader>mb", "<cmd>ObsidianBacklinks<cr>",    { desc = "Backlinks" })
      vim.keymap.set("n", "<leader>ml", "<cmd>ObsidianLinks<cr>",        { desc = "Links in note" })
      vim.keymap.set("n", "<leader>md", "<cmd>ObsidianToday<cr>",        { desc = "Daily note" })
      vim.keymap.set("n", "<leader>mt", "<cmd>ObsidianTags<cr>",         { desc = "Search by tag" })
      vim.keymap.set("n", "<leader>mp", "<cmd>ObsidianPasteImg<cr>",     { desc = "Paste image" })
      vim.keymap.set("n", "<leader>mk", "<cmd>ObsidianLinkNew<cr>",      { desc = "Create link from selection" })
    end,
  },
}
