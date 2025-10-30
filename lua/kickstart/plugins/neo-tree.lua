-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    -- Don't open Neo-tree on startup, only when toggled
    close_if_last_window = true, -- Close Neo-tree if it's the last window
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    
    -- Default to filesystem view
    default_component_configs = {
      indent = {
        padding = 0,
      },
    },
    
    filesystem = {
      -- Follow the current file in the tree
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      -- Use system commands for file operations
      use_libuv_file_watcher = true,
      
      window = {
        position = 'left',
        width = 30,
        mappings = {
          ['\\'] = 'close_window',
          -- Make <leader>sf work the same in Neo-tree as in editor
          ['<leader>sf'] = 'telescope_find',
          ['<leader>sg'] = 'telescope_grep',
        },
      },
    },
    
    -- Add custom commands for Telescope integration
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').find_files {
          cwd = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ':h'),
        }
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').live_grep {
          cwd = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ':h'),
        }
      end,
    },
  },
}
