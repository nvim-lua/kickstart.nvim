-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  -- f-strings
  -- - auto-convert strings to f-strings when typing `{}` in a string
  -- - also auto-converts f-strings back to regular strings when removing `{}`
  {
    'chrisgrieser/nvim-puppeteer',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
