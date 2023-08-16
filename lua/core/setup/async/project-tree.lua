local keymaps = require('core.keymaps.async.project-tree')

return function()
  local on_attach = function(bufnr)
    keymaps(bufnr)
  end

  -- HACK A temporary way to subscribe to the fact that
  -- the setup is complete
  vim.api.nvim_create_autocmd("User", {
    pattern = "NvimTreeSetup",
    callback = function(data)
      on_attach(data.buf)
    end,
  })

  require("nvim-tree").setup({
    -- TODO uncomment this in a version that it actually works
    -- on_attach = on_attach
  })
end
