-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local utils = require 'custom.utils'
local get_icon = utils.get_icon

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    close_if_last_window = true,
    sources = { 'filesystem', 'git_status' },
    source_selector = {
      winbar = true,
      content_layout = 'center',
      sources = {
        { source = 'filesystem', display_name = get_icon('FolderClosed', 1, true) .. 'File' },
        { source = 'git_status', display_name = get_icon('Git', 1, true) .. 'Git' },
      },
    },
    default_component_configs = {
      indent = { padding = 0 },
      icon = {
        folder_closed = get_icon 'FolderClosed',
        folder_open = get_icon 'FolderOpen',
        folder_empty = get_icon 'FolderEmpty',
        folder_empty_open = get_icon 'FolderEmpty',
        default = get_icon 'DefaultFile',
      },
      modified = { symbol = get_icon 'FileModified' },
      git_status = {
        symbols = {
          added = get_icon 'GitAdd',
          deleted = get_icon 'GitDelete',
          modified = get_icon 'GitChange',
          renamed = get_icon 'GitRenamed',
          untracked = get_icon 'GitUntracked',
          ignored = get_icon 'GitIgnored',
          unstaged = get_icon 'GitUnstaged',
          staged = get_icon 'GitStaged',
          conflict = get_icon 'GitConflict',
        },
      },
    },
    commands = {
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' or node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, seleect the next child
            require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
          end
        else -- if not a directory just open it
          state.commands.open(state)
        end
      end,
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify
        local vals = {
          ['BASENAME'] = modify(filename, ':r'),
          ['EXTENSION'] = modify(filename, ':e'),
          ['FILENAME'] = filename,
          ['PATH (CWD)'] = modify(filepath, ':.'),
          ['PATH (HOME)'] = modify(filepath, ':~'),
          ['PATH'] = filepath,
          ['URI'] = vim.uri_from_fname(filepath),
        }

        local options = vim.tbl_filter(function(val)
          return vals[val] ~= ''
        end, vim.tbl_keys(vals))
        if vim.tbl_isempty(options) then
          utils.notify('No values to copy', vim.log.levels.WARN)
          return
        end
        table.sort(options)
        vim.ui.select(options, {
          prompt = 'Choose to copy to clipboard:',
          format_item = function(item)
            return ('%s: %s'):format(item, vals[item])
          end,
        }, function(choice)
          local result = vals[choice]
          if result then
            utils.notify(('Copied: `%s`'):format(result))
            vim.fn.setreg('+', result)
          end
        end)
      end,
    },
    window = {
      mappings = {
        ['[b'] = 'prev_source',
        [']b'] = 'next_source',
        Y = 'copy_selector',
        h = 'parent_or_close',
        l = 'child_or_open',
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
