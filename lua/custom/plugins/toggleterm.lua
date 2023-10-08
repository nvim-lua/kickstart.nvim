return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup({
      open_mapping = "<C-\\>",
      direction = "float",
    })
    local terminal = require('toggleterm.terminal')
    vim.keymap.set({ "n", "v", "t" }, "<leader>tt", "<Cmd>ToggleTerm direction=tab<cr>", { desc = "ToggleTerm tab" });
    vim.keymap.set({ "n", "v", "t" }, "<leader>th", "<Cmd>ToggleTerm direction=horizontal<cr>",
      { desc = "ToggleTerm horizontal" });
    vim.keymap.set({ "n", "v", "t" }, "<leader>tv", "<Cmd>ToggleTerm direction=vertical<cr>",
      { desc = "ToggleTerm vertical" });
    vim.keymap.set({ "n", "v", "t" }, "<leader>tn", function() terminal.Terminal:new():toggle() end,
      { desc = "ToggleTerm new" });
  end
}
