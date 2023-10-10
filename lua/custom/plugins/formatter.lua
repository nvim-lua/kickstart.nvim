return {
  'mhartington/formatter.nvim',
  event = "VeryLazy",
--[[   opts = {
    filetype = {
      typescript = {
        require("formatter.filetypes.typescript").prettier
      },
    }
  }, ]]
}
