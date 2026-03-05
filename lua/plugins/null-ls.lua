---@diagnostic disable: undefined-global
local vim = vim

local M = {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    -- Safely require null-ls
    local ok, null_ls = pcall(require, 'null-ls')
    if not ok then
      vim.notify('Failed to load null-ls', vim.log.levels.ERROR)
      return
    end
    
    -- Safely require setup
    local setup_ok, setup = pcall(require, 'plugins.null-ls.setup')
    if not setup_ok or type(setup.setup) ~= 'function' then
      vim.notify('Failed to load null-ls setup', vim.log.levels.ERROR)
      return
    end
    
    -- Initialize null-ls
    setup.setup()
    
    -- Additional safety check for sources
    vim.defer_fn(function()
      if not null_ls or not null_ls.get_sources then
        vim.notify('null-ls sources not available', vim.log.levels.WARN)
        return
      end
      
      local sources = null_ls.get_sources()
      if #sources == 0 then
        vim.notify('No null-ls sources registered', vim.log.levels.WARN)
      end
    end, 1000) -- Check after 1 second
  end,
}

return M
