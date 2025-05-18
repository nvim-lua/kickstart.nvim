
-- Using opts (recommended when no custom logic is needed)
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = "dracula",
      section_separators = "",
      component_separators = "",
    },
  },
}
