-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
-- used for completion, annotations and signatures of Neovim apis
return {
  {
    'folke/neodev.nvim',
    opts = {
      override = function(root_dir, library)
        if root_dir:find '.config/nvim' then
          library.enabled = true
          library.plugins = true
        end
      end,
    },
  },
}
