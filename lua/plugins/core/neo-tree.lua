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
    
    -- Global window mappings (apply to all Neo-tree windows)
    window = {
      mappings = {
        -- Disable <Space> for toggle_node to allow <leader> (Space) to work
        ['<space>'] = 'none',
        -- Use <CR> (Enter) to toggle nodes instead (already default, but making it explicit)
        ['<cr>'] = 'toggle_node',
        -- Use 'za' (vim fold toggle) as alternative for toggle node
        ['za'] = 'toggle_node',
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
          
          -- Consistent with Telescope: <C-x> = split, <C-v> = vsplit, <C-t> = tabnew
          ['<C-x>'] = 'split_with_window_picker',
          ['<C-v>'] = 'vsplit_with_window_picker',
          ['<C-t>'] = 'open_tabnew',
          
          -- Open file (consistent with Telescope <CR>)
          ['<CR>'] = 'open',
          ['o'] = 'open',
          
          -- Navigation
          ['<C-j>'] = 'next_source', -- Match Telescope down navigation
          ['<C-k>'] = 'prev_source', -- Match Telescope up navigation
          
          -- Preview (like Telescope)
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          
          -- Telescope integration from Neo-tree
          ['<leader>sf'] = 'telescope_find',
          ['<leader>sg'] = 'telescope_grep',
          
          -- Refresh
          ['R'] = 'refresh',
          
          -- Toggle hidden files
          ['H'] = 'toggle_hidden',
          
          -- Navigation
          ['-'] = 'navigate_up',
          ['.'] = 'set_root',
          
          -- File operations
          ['a'] = 'add',
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy', -- Copy (takes a path as input)
          ['m'] = 'move', -- Move (takes a path as input)
          
          -- Help
          ['?'] = 'show_help',
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
