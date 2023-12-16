return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- configurations go here
    theme = {
      normal = {
        -- bg = "#000000"
        bold = true
      },
      --dirname = { bg = "#000000" },
      --basename = { bg = "#888888" },
      --context = { bg = "#DDDDDD" },
    }
  },
}
