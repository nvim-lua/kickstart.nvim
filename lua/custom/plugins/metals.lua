-- Metals (Scala LSP) via nvim-metals.
-- Navigation/hover/diagnostic keymaps come from the global LspAttach autocmd in
-- init.lua, so this only wires up the Metals client itself.
return {
  {
    'scalameta/nvim-metals',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = { 'scala', 'sbt', 'java' },
    opts = function()
      local metals_config = require('metals').bare_config()

      -- Broadcast blink.cmp completion capabilities to Metals (same as init.lua).
      metals_config.capabilities = require('blink.cmp').get_lsp_capabilities()

      metals_config.settings = {
        showImplicitArguments = true,
        showInferredType = true,
        excludedPackages = {},
      }

      metals_config.init_options.statusBarProvider = 'off'

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = self.ft,
        callback = function()
          require('metals').initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
