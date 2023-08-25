return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      position = "float",
      mappings = {
        ["<space>"] = "none",
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
      },
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "open_current",
    },
  },
  config = function(_, opts)
    vim.g.neo_tree_remove_legacy_commands = 1
    require("neo-tree").setup(opts)
  end,
}
