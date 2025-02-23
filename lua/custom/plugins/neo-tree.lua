return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    'saifulapm/neotree-file-nesting-config',
  },
  cmd = 'Neotree',
  opts = {
    -- recommended config for better UI
    hide_root_node = true,
    retain_hidden_root_indent = true,
    filesystem = {
      filtered_items = {
        show_hidden_count = false,
        never_show = {
          '.DS_Store',
        },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = '',
        expander_expanded = '',
      },
    },
  },
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    {
      '<leader>b',
      function()
        require('neo-tree.command').execute { toggle = true, source = 'buffers', position = 'left' }
      end,
      desc = 'Buffers (root dir)',
    },
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute { toggle = true, source = 'filesystem', position = 'left' }
      end,
      desc = 'Filesystem (root dir)',
    },
    {
      '<leader>g',
      function()
        require('neo-tree.command').execute { toggle = true, source = 'git_status', position = 'left' }
      end,
      desc = 'Filesystem (root dir)',
    },
  },
  config = function(_, opts)
    opts.nesting_rules = require('neotree-file-nesting-config').nesting_rules
    require('neo-tree').setup(opts)

    local inputs = require 'neo-tree.ui.inputs'
    -- Trash the target
    local function trash(state)
      local node = state.tree:get_node()
      if node.type == 'message' then
        return
      end
      local _, name = require('neo-tree.utils').split_path(node.path)
      local msg = string.format("Are you sure you want to trash '%s'?", name)
      inputs.confirm(msg, function(confirmed)
        if not confirmed then
          return
        end
        vim.api.nvim_command('silent !trash -F ' .. node.path)
        require('neo-tree.sources.manager').refresh(state)
      end)
    end

    -- Trash the selections (visual mode)
    local function trash_visual(state, selected_nodes)
      local paths_to_trash = {}
      for _, node in ipairs(selected_nodes) do
        if node.type ~= 'message' then
          table.insert(paths_to_trash, node.path)
        end
      end
      local msg = 'Are you sure you want to trash ' .. #paths_to_trash .. ' items?'
      inputs.confirm(msg, function(confirmed)
        if not confirmed then
          return
        end
        for _, path in ipairs(paths_to_trash) do
          vim.api.nvim_command('silent !trash -F ' .. path)
        end
        require('neo-tree.sources.manager').refresh(state)
      end)
    end

    require('neo-tree').setup {
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            vim.cmd 'highlight! Cursor blend=100'
          end,
        },
        {
          event = 'neo_tree_buffer_leave',
          handler = function()
            vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
          end,
        },
      },
      window = {
        mappings = {
          ['T'] = 'trash',
          ['h'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' and node:is_expanded() then
              require('neo-tree.sources.filesystem').toggle_directory(state, node)
            else
              require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
            end
          end,
          ['l'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' then
              if not node:is_expanded() then
                require('neo-tree.sources.filesystem').toggle_directory(state, node)
              elseif node:has_children() then
                require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
              end
            else
              state.commands['open'](state)
              vim.cmd 'Neotree reveal'
            end
          end,
          ['<tab>'] = function(state)
            local node = state.tree:get_node()
            if require('neo-tree.utils').is_expandable(node) then
              state.commands['toggle_node'](state)
            else
              state.commands['open'](state)
              vim.cmd 'Neotree reveal'
            end
          end,
        },
      },
      commands = {
        trash = trash,
        trash_visual = trash_visual,
      },
    }
  end,
}
