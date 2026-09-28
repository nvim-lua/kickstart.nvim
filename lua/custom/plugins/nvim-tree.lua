-- File explorer: https://github.com/nvim-tree/nvim-tree.lua

-- nvim-tree recommends disabling netrw so it takes over directory buffers (e.g. `nvim .`)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local plugins = { { src = 'https://github.com/nvim-tree/nvim-tree.lua', version = vim.version.range '*' } }
if vim.g.have_nerd_font then table.insert(plugins, 'https://github.com/nvim-tree/nvim-web-devicons') end
vim.pack.add(plugins)

require('nvim-tree').setup {
  hijack_netrw = true,
  sync_root_with_cwd = true,
  update_focused_file = { enable = true },
  view = { width = 35 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
}

vim.keymap.set('n', '\\', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file tree at current [E]xplorer file' })
