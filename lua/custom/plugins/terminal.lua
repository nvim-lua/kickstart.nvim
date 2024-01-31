return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function ()
    require("toggleterm").setup({
      open_mapping = [[<F7>]],
      shade_terminals = false,
      direction = "horizontal",
      terminal_mappings = true,
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "single",
      }
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

    vim.cmd.tnoremap("<Esc>", [[<C-\><C-n>]])
    vim.cmd.tnoremap("<C-w>", [[<C-\><C-n><C-w>]])
    -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  end
}
