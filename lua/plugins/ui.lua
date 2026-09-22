return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      auto_integrations = true,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 250,
      spec = {
        { "<leader>a", group = "AI" },
        { "<leader>h", group = "Git hunk", mode = { "n", "x" } },
        { "<leader>m", group = "Marks" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
      },
    },
  },
  {
    "echasnovski/mini.statusline",
    version = false,
    opts = { use_icons = vim.g.have_nerd_font },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    cmd = "Neotree",
    keys = {
      { "\\", "<cmd>Neotree reveal<CR>", desc = "Reveal file tree" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    opts = {
      filesystem = {
        window = { mappings = { ["\\"] = "close_window" } },
      },
    },
  },
}
