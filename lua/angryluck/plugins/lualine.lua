return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  opts = {
    options = {
      icons_enabled = false,
      theme = "catppuccin",
      component_separators = "|",
      section_separators = "",
    },
    -- lualine layout:
    -- +-------------------------------------------------+
    -- | A | B | C                             X | Y | Z |
    -- +-------------------------------------------------+
    sections = { lualine_x = { "filetype" } },
  },
}
