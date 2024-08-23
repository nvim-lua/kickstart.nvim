-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  -----------------------------------------------------------------------------
  -- EDITING SUPPORT PLUGINS
  -- some plugins that help with python-specific editing operations

  -- Docstring creation
  -- - quickly create docstrings via `<leader>a`
  {
    'danymat/neogen',
    opts = true,
    keys = {
      {
        '<leader>a',
        function()
          require('neogen').generate()
        end,
        desc = 'Add Docstring',
      },
    },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
