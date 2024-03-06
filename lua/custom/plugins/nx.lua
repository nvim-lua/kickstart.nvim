return {
  {
    "Equilibris/nx.nvim",

    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    opts         = {
      nx_cmd_root = "npx nx",
    },

    -- Plugin will load when you use these keys
    keys         = {
      { "<leader>nxa", "<cmd>Telescope nx actions<CR>",                           desc = "nx actions" },
      { "<leader>nxg", "<cmd>Telescope nx generators<CR>",                        desc = "nx generators" },
      { "<leader>nxf", "<cmd>wa | !npx nx format:write<CR><CR> | :checktime<CR>", desc = "nx format afected" }
    },
  },
}
