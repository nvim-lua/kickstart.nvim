return {
  {
    'luukvbaal/nnn.nvim',
    config = function ()
      require("nnn").setup({
        replace_netrw = "explorer"
      })
    end
  }
}
