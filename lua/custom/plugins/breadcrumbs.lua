local M = {
  "LunarVim/breadcrumbs.nvim",
  dependencies = {
    { "SmiteshP/nvim-navic" },
  },
}

function M.config()
  require("breadcrumbs").setup()
end

return M
