return {
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath 'config'
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
        -- -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
        -- --  See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
        --   '${3rd}/luv/library',
        --   '${3rd}/busted/library',
        -- }),
      },
    })
  end,
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      format = { enable = false }, -- Disable formatting (formatting is done by stylua)
    },
  },
}
