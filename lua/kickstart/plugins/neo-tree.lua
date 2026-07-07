-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local neo_tree_spec = {
  src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
  version = vim.version.range '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
}

vim.pack.add { neo_tree_spec }

require('neo-tree').setup {
  -- Show file explorer by default on NeoTree open
  default_file_explorer = true,

  -- Components which are displayed in the neo-tree window
  components = {
    'file_icons',       -- File icons
    'filename',        -- File names
    'modified',        -- Modified file indicators
    'git_status',      -- Git status (when available via gitsigns)
    'group_empty',     -- Empty folder markers
    'buffers_indicator' -- Buffer indicator icons
  },

  window = {
    position = 'left',           -- Position: left | right | bottom | top
    width = 35,                  -- Width of the neo-tree window
    close_if_last_window = true, -- Close neo-tree if it's the only window
    float = {
      enabled = true,            -- Enable floating windows (for file creation)
      padding = 2,               -- Padding around floating windows
      border = 'single',         -- Border style
      position = '50%',          -- Position: 50% center
      size = {
        width = '50%',           -- Width percentage of floating window
        height = '80%'           -- Height percentage of floating window
      }
    },
  },

  -- Configuration for filesystem source (files, folders)
  filesystem = {
    hijack_netrw_behavior = "disabled", -- Don't auto-open on `nvim .`
    filtered_items = {
      visibility = 'all',        -- Show: all | visible_filtered | filtered
      hide_dotfiles = false,     -- Hide files starting with .
      hide_gitignored = false,   -- Hide git-ignored files
      always_show_path = true,   -- Always show file paths in the tree view
      always_show_root = true    -- Always show root directory when entering it
    },

    default_component_config = {
      indent_markers = {
        enable = true,
        highlight_groups = {
          folder_open = function(_, item_data)
            local group_name = 'NeoTreeIndentMarker'
            if item_data.item.type == 'directory' then
              return group_name .. '.open'
            end
            return group_name .. '.closed'
          end,
          folder_closed = function(_, item_data)
            local group_name = 'NeoTreeIndentMarker'
            if item_data.item.type == 'directory' then
              return group_name .. '.closed'
            end
            return group_name .. '.open'
          end,
          default = 'NeoTreeIndentMarker'
        },
      },
      icons = {
        folder_open = '',
        folder_closed = '',
        default = '', -- empty string for non-folder items
        git = {
          modified = '↗︎', -- Git modified file icon
          unstaged = '✗',  -- Git unstaged changes
          staged = '↙︎',   -- Git staged changes
          ignored = '↖︎'   -- Git ignored file
        }
      },
      indent_guides = true,           -- Show indentation guides for tree structure
    },

    use_default_document_colors = false,
    auto_clean_after_buffer_close = true, -- Automatically clean up after closing files
  },

  buffers = {
    show_unloaded = true,     -- Show unloaded buffers in the tree
    mapped_names = true,      -- Use mapped names for buffer icons/names
    get_buffer_icon = function(buffer)
      if vim.bo[buffer].modified then return '✹' end
      if vim.bo[buffer].readonly then return '📖' end
      if vim.bo[buffer].filetype == 'NERDTree' then return '' end
      return ''
    end,
    get_buffer_name = function(buffer)
      local bufname = vim.api.nvim_buf_get_name(buffer)
      -- Get short path by removing prefix up to first slash
      if bufname:find('/') then
        return bufname:gsub('.*(%p)[^-]*-', '')
      end
      return bufname
    end,
  },

  git_status = {
    use_icons_for_git_status = true,
    icons = {
      unstaged_changes = { symbol = '✗', color = 'red' },
      staged_changes = { symbol = '↙︎', color = 'green' },
      ignored_files = { symbol = '↖︎', color = 'gray' }
    },
    file_icons = {
      modified = 'M',
      added = '+',
      deleted = 'D',
      ignored = 'i'
    }
  }
}

-- Add convenient mappings for neo-tree using which-key
vim.keymap.set('n', '<leader>ff', ':Neotree filesystem toggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>fb', ':Neotree buffers toggle<CR>', { desc = 'Toggle buffer explorer' })
vim.keymap.set('n', '<leader>fF', ':Neotree float open<CR>', { desc = 'Open floating window' })
