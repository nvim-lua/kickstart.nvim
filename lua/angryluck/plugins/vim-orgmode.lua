return {
  "nvim-orgmode/orgmode",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = true,
      config = function()
        -- Setup treesitter
        require("nvim-treesitter.configs").setup {
          highlight = {
            enable = true,
          },
          ensure_installed = { "org" },
        }
      end,
    },
    {
      "akinsho/org-bullets.nvim",
      config = function()
        require("org-bullets").setup()
      end,
    },
    -- "joaomsa/telescope-orgmode.nvim",
    -- "nvim-telescope/telescope.nvim",
    -- {
    --   "lukas-reineke/headlines.nvim",
    --   dependencies = "nvim-treesitter/nvim-treesitter",
    --   config = function()
    --     vim.cmd [[highlight Headline1 guibg=#1e2718]]
    --     vim.cmd [[highlight Headline2 guibg=#21262d]]
    --     vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
    --     vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]
    --
    --     require("headlines").setup {
    --       org = {
    --         headline_highlights = { "Headline1", "Headline2" },
    --       },
    --     }
    --   end, -- or `opts = {}`
    -- },
  },
  -- ADD THIS BACK LATER - SOMETHING WRONG, SO DOESNT START
  -- event = 'VeryLazy',
  config = function()
    -- Load treesitter grammar for org
    -- require("orgmode").setup_ts_grammar()
    -- require("telescope").load_extension "orgmode"

    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "org",
    --   group = vim.api.nvim_create_augroup("orgmode_telescope_nvim", { clear = true }),
    --   callback = function()
    --     vim.keymap.set("n", "<leader>or", require("telescope").extensions.orgmode.refile_heading)
    --   end,
    -- })

    -- Setup orgmode
    require("orgmode").setup {
      org_agenda_files = { "~/documents/orgfiles/**/*", "~/gtd/**/*" },
      -- org_default_notes_file = "~/documents/orgfiles/refile.org",
      org_default_notes_file = "~/gtd/inbox.org",
      org_archive_location = "~/gtd/archive/%s_archive::",
      org_todo_keywords = {
        "NEXT(n)",
        "TODO(t)",
        "WAITING(w)",
        -- "SCHEDULED(s)",
        "|",
        "DONE(d)",
        "CANCELLED(c)",
      },
      -- org_hide_leading_stars = true,
      mappings = {
        capture = {
          org_capture_finalize = "<Leader>ow",
        },
        note = {
          org_note_finalize = "<Leader>ow",
        },
      },
    }
  end,
}
