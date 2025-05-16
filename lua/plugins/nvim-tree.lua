return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<leader>fe", "<cmd>NvimTreeFocus<CR>", desc = "Focus NvimTree" },
    },
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional icons
    },
    opts = function()
      local api = require("nvim-tree.api")
      
      return {
        -- disable_netrw = false,
        -- hiack_netrw = true,
        view = {
          width = 35,
          side = "left",
          preserve_window_proportions = true,
        },
        hijack_cursor = true,
        view = {
          adaptive_size = true,
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = "name",
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          local map = vim.keymap.set
          map("n", "<CR>",  api.node.open.edit,               opts("Open"))
          map("n", "l",     api.node.open.edit,               opts("Open"))
          map("n", "o",     api.node.open.edit,               opts("Open"))
          map("n", "v",     api.node.open.vertical,           opts("Open Vertical"))
          map("n", "s",     api.node.open.horizontal,         opts("Open Horizontal"))
          map("n", "a",     api.fs.create,                    opts("Create"))
          map("n", "d",     api.fs.remove,                    opts("Delete"))
          map("n", "r",     api.fs.rename,                    opts("Rename"))
          map("n", "x",     api.fs.cut,                       opts("Cut"))
          map("n", "y",     api.fs.copy.node,                 opts("Copy"))
          map("n", "p",     api.fs.paste,                     opts("Paste"))
          map("n", "q",     api.tree.close,                   opts("Close"))

          map("n", "?",     api.tree.toggle_help,             opts("Help"))
          map("n", "<C-t>", api.tree.change_root_to_parent,   opts("Up"))
          map("n", "h",     api.node.navigate.parent_close,   opts("close_node"))
        end,
      }
    end,
  }
}


--     local function opts(desc)
--       return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--     end

--     -- default mappings
--     api.config.mappings.default_on_attach(bufnr)

--     -- custom mappings
--   end


--   -- set termguicolors to enable highlight groups
--   vim.opt.termguicolors = true

--   -- OR setup with some options
--   nvim_tree.setup({
--     on_attach = my_on_attach,
--     sort_by = "case_sensitive",
--     renderer = {
--         highlight_git = true,
--         root_folder_modifier = ":t",
--         icons = {
--             show = {
--                 file = true,
--                 folder = true,
--                 folder_arrow = true,
--                 git = true,
--             },
--             glyphs = {
--                 default = "",
--                 symlink = "",
--                 git = {
--                     unstaged = "",
--                     staged = "S",
--                     unmerged = "",
--                     renamed = "➜",
--                     deleted = "",
--                     untracked = "U",
--                     ignored = "◌",
--                 },
--                 folder = {
--                     default = "",
--                     open = "",
--                     empty = "",
--                     empty_open = "",
--                     symlink = "",
--                 },
--             }
--         }
--     },
--     filters = {
--       dotfiles = true,
--     },
--     update_cwd = true,
--     diagnostics = {
--         enable = true,
--         icons = {
--             hint = "",
--             info = "",
--             warning = "",
--             error = "",
--         },
--     },
--   })
-- }