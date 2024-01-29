local M = {
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  lazy = true,
  event = 'VeryLazy',
}

function M.config()
  require('nvim-surround').setup({
    -- Configuration here, or leave empty to use defaults
  })
end

return M
