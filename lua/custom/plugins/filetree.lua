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
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      bind_to_cwd = false,
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
    },
  },
  config = function(_, opts)
    vim.g.neo_tree_remove_legacy_commands = 1
    require("neo-tree").setup(opts)
  end,
}
