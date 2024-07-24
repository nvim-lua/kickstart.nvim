return -- Using lazy.nvim
{
  'ribru17/bamboo.nvim',
  lazy = false,
  config = function()
    require('bamboo').setup {
      -- optional configuration here
    }
  end,
}
