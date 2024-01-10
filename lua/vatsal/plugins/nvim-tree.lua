return {
  "nvim-tree/nvim-tree.lua",
  lazy = 'true',
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
  keys = {
    { '<S-t>', '<cmd>NvimTreeToggle .<CR>', { noremap = true, silent = true } }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  --[[ init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'NvimTree',
      command = ":lua require('gitsigns').detach()"
    })
  end, ]]
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 38,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  },
}
