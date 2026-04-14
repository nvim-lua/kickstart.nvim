vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy', once = true,
  callback = function()
    local mr = require 'mason-registry'
    mr.refresh(function()
      local p = mr.get_package 'codelldb'
      if not p:is_installed() then p:install() end
    end)
  end,
})

return {}
