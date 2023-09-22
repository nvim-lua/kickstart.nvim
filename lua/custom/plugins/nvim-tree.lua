return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
    keys = {
      { "<leader>e",  "<cmd>NvimTreeToggle<cr>", desc = "Nvim[T]ree [T]oggle" },
      { "<leader>ef", "<cmd>NvimTreeFocus<cr>",  desc = "Nvim[T]ree [F]ocus " },
      { "<leader>eo", "<cmd>NvimTreeOpen<cr>",   desc = "Nvim[T]ree [O]pen" },
      { "<leader>ex", "<cmd>NvimTreeClose<cr>",  desc = "Nvim[T]ree [C]lose" },
    },
  },
}
