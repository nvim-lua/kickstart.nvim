-- Neorg - An organized future for Neovim
-- https://github.com/nvim-neorg/neorg
--
-- Documentation: https://github.com/nvim-neorg/neorg/wiki
-- Modules reference: https://github.com/nvim-neorg/neorg/wiki/User-Modules-Reference

return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading to ensure proper initialization
  -- Pin the version for stability - you can update when ready
  version = "*", -- Use the latest stable version
  dependencies = {
    "nvim-lua/plenary.nvim", -- Already should be installed in your config
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "hrsh7th/nvim-cmp", -- Proper repository path for nvim-cmp
  },
  build = ":Neorg sync-parsers", -- This will install the Neorg treesitter parser
  config = function()  
    require("neorg").setup {
      load = {
        -- Load the core modules that provide basic functionality
        ["core.defaults"] = {}, -- Loads default modules
        
        -- Essential modules for a good experience
        ["core.concealer"] = {
          config = {
            icon_preset = "diamond", -- Icon style: basic, diamond, varied
            icons = {
              -- Custom icons for improved visual appearance
              heading = {
                icons = { "◉", "○", "✸", "✿" }, -- Cycle through these for heading levels
              },
              -- Keep default values for other icons
              todo = {
                pending = { icon = "" },  -- Keep the default
              },
            },
            folds = true, -- Enable folding of nested content
            performance = {
              conceal_modifier_pre = 200, -- Optimized conceal performance
              conceal_modifier_post = 300,
              concealer_weight_implies_priority = true,
            },
          },
        },
        
        -- For managing directories of .norg files - required for many features
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",      -- General notes
              work = "~/work/notes",  -- Work-related notes
              personal = "~/personal/notes", -- Personal notes
              projects = "~/projects/notes", -- Project-specific notes
            },
            default_workspace = "notes",
            index = "index.norg", -- Default index file to look for
          },
        },
        
        -- Enhance completion capabilities - integrates with your existing completion
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp", -- Use nvim-cmp for completion
            name = "neorg",      -- Source name for nvim-cmp
            -- Customize completion behavior
            snippet_engine = nil, -- Will use your configured snippet engine
            trigger_on_carriage_return = true, -- Trigger completion when pressing Enter
          },
        },
        
        -- Export your Neorg files to other formats
        ["core.export"] = {}, -- Base export module
        ["core.export.markdown"] = {
          config = {
            extensions = "all", -- Export all extensions
            versioning = {
              -- Add version information to exported files
              enabled = true,
              -- Pattern: {year}{month}{day}{hour}{min}{sec}_filename.md
              pattern = "%Y%m%d%H%M%S_{name}.md", 
            },
          },
        },
        
        -- For a nicer table of contents
        ["core.qol.toc"] = {
          config = {
            toc_title = "Table of Contents", -- Title of the TOC
            close_after_use = true,         -- Close TOC after jumping to a heading
            default_level = 4,              -- Show headings up to this level
            toc_position = "right",         -- Position of the TOC window
          },
        },
        
        -- For taking journal notes
        ["core.journal"] = {
          config = {
            strategy = "flat",     -- "flat" for single files, "nested" for year/month/day structure
            workspace = "notes",   -- Use the notes workspace for journal entries
            journal_folder = "journal", -- Store journal entries in this subfolder
            use_template = false, -- Whether to use a template for new entries
            template_name = nil,  -- Optional template name if use_template is true
            zipper_indicator = false, -- Show indicators for fast navigation
          },
        },
        
        -- Summary generation for notes (new module)
        ["core.summary"] = {},
        
        -- Enhanced UI presentation mode
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode", -- Zen mode plugin to use (if installed)
            slide_count = true,    -- Show slide count in presenter mode
          }
        },

        -- Enhance keybinds with custom modes
        ["core.keybinds"] = {
          -- This config is crucial for avoiding keybinding conflicts
          config = {
            -- All Neorg keybindings are only active inside .norg files
            -- They won't affect your existing keymaps in other file types
            default_keybinds = true,
            neorg_leader = "<Leader>n", -- Use <Leader>n as the Neorg prefix
            
            -- Custom keybinds organized by category
            hook = function(keybinds)
              -- Navigation keybinds
              keybinds.map("norg", "n", "<Leader>nj", "<cmd>Neorg journal today<CR>", 
                { desc = "Open today's journal" })
              keybinds.map("norg", "n", "<Leader>nyt", "<cmd>Neorg journal yesterday<CR>", 
                { desc = "Open yesterday's journal" })
              keybinds.map("norg", "n", "<Leader>ntm", "<cmd>Neorg journal tomorrow<CR>", 
                { desc = "Open tomorrow's journal" })
              
              -- Workspace management
              keybinds.map("norg", "n", "<Leader>nw", "<cmd>Neorg workspace<CR>", 
                { desc = "Open workspace selector" })
              keybinds.map("norg", "n", "<Leader>nn", "<cmd>Neorg workspace notes<CR>", 
                { desc = "Switch to notes workspace" })
              keybinds.map("norg", "n", "<Leader>nwp", "<cmd>Neorg workspace personal<CR>", 
                { desc = "Switch to personal workspace" })
                
              -- Document manipulation
              keybinds.map("norg", "n", "<Leader>ntt", "<cmd>Neorg toc<CR>", 
                { desc = "Generate table of contents" })
              keybinds.map("norg", "n", "<Leader>ni", "<cmd>Neorg inject-metadata<CR>", 
                { desc = "Inject metadata" })
              keybinds.map("norg", "n", "<Leader>nm", "<cmd>Neorg update-metadata<CR>", 
                { desc = "Update metadata" })
                
              -- Export commands
              keybinds.map("norg", "n", "<Leader>nem", "<cmd>Neorg export to-markdown<CR>", 
                { desc = "Export to Markdown" })
                
              -- Toggle concealer
              keybinds.map("norg", "n", "<Leader>nc", "<cmd>Neorg toggle-concealer<CR>", 
                { desc = "Toggle concealer" })
                
              -- Return to last workspace
              keybinds.map("norg", "n", "<Leader>nl", "<cmd>Neorg return<CR>", 
                { desc = "Return to last workspace" })
                
              -- Advanced keybinds for list manipulation
              keybinds.map_event("norg", "n", "<Leader>nu", "core.itero.next-iteration", 
                { desc = "Iterate next" })
              keybinds.map_event("norg", "n", "<Leader>np", "core.itero.previous-iteration", 
                { desc = "Iterate previous" })
            end,
          },
        },
        
        -- Module for better list handling
        ["core.itero"] = {},

        -- UI improvements for better look and feel
        ["core.ui"] = {},
        ["core.ui.calendar"] = {}, -- Calendar view for journal navigation
      },
    }
  end,
}
