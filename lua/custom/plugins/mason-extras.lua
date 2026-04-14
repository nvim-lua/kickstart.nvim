vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    local mr = require 'mason-registry'
    mr.refresh(function()
      local ok, p = pcall(mr.get_package, 'codelldb')
      if ok and not p:is_installed() then p:install() end
    end)
  end,
})

return {}
