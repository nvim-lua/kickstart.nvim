-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          leave_dirs_open = false
        },
        group_empty_dirs = true, -- when true, empty folders will be grouped together
      },
      -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
      file_size = {
        enabled = false,
        required_width = 64, -- min width of window required to show this column
      },
      type = {
        enabled = false,
        required_width = 122, -- min width of window required to show this column
      },
      last_modified = {
        enabled = false,
        required_width = 88, -- min width of window required to show this column
      },
      created = {
        enabled = false,
        required_width = 110, -- min width of window required to show this column
      },
      symlink_target = {
        enabled = false,
      },
      window = {
        position = "left",
        width = 60,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      }
    }
  end,
}
