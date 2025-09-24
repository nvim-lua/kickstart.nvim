-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
print 'plugins.lua is being loaded'

return {

  -- Colorizer
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        '*', -- Highlight all filetypes
        css = { rgb_fn = true },
        html = { names = false },
      }, {
        mode = 'foreground',
      })
    end,
  },
}
