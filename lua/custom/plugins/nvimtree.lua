return {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = function()
    local nvim_tree_events = require('nvim-tree.events')
    local bufferline_api = require('bufferline.api')

    local function get_tree_size()
      return require 'nvim-tree.view'.View.width
    end

    nvim_tree_events.subscribe('TreeOpen', function()
      bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe('Resize', function()
      bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe('TreeClose', function()
      bufferline_api.set_offset(0)
    end)

    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
    vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile<CR>')

    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    })
  end
}
