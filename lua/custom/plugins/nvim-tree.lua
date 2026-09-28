-- File explorer: https://github.com/nvim-tree/nvim-tree.lua
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  keys = {
    { '\\', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file tree' },
    { '<leader>e', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'Toggle file tree at current [E]xplorer file' },
  },
  init = function()
    -- nvim-tree recommends disabling netrw so it takes over directory buffers (e.g. `nvim .`)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    hijack_netrw = true,
    sync_root_with_cwd = true,
    update_focused_file = { enable = true },
    view = { width = 35 },
    renderer = { group_empty = true },
    filters = { dotfiles = false },
  },
}
