return {
  "akinsho/toggleterm.nvim",
  config = function ()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      autochdir = true,
      shade_terminals = true,
      shading_factor = 10,
    })
  end
}
