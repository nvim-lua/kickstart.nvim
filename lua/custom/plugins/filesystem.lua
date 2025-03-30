-- File navigation using neo-tree
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  config = function()
    require('neo-tree').setup {
      event_handlers = {
        {
          event = 'file_open_requested',
          handler = function()
            -- auto close
            vim.cmd 'Neotree close'
          end,
        },
      },
    }
  end,
  opts = {
    -- fill any relevant options here
  },
}
