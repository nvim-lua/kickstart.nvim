if true then
  return {}
else
  return {
    'jayadamsmorgan/PklLanguageServer',
    build = 'mv Editors/Neovim/pklls-nvim/* .',
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities() -- if you are using nvim_cmp for completion
      require('pklls-nvim.init').setup {
        capabilities = capabilities, -- change or remove this
        -- on_attach = custom_on_attach -- change or remove this
        -- cmd = custom_path_to_pkl_lsp_server
      }
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
    },
  }
end
