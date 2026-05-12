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
  -- Auto-open on startup when nvim is launched without a file or on a directory.
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('neo-tree-auto-open', { clear = true }),
      callback = function()
        local argc = vim.fn.argc()
        local arg = argc > 0 and vim.fn.argv(0) or ''
        if argc == 0 or vim.fn.isdirectory(arg) == 1 then
          vim.schedule(function()
            -- `reveal_force_cwd` roots at cwd and avoids the
            -- expand_to_node recursion that `show` can hit.
            vim.cmd('Neotree reveal_force_cwd')
          end)
        end
      end,
    })
  end,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function()
    local inputs = require 'neo-tree.ui.inputs'

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
      -- hide_root_node + follow_current_file used to cause an infinite
      -- expand_to_node/restore recursion at startup; both disabled here.
      nesting_rules = require('neotree-file-nesting-config').nesting_rules,
      filesystem = {
        filtered_items = {
          show_hidden_count = false,
          never_show = { '.DS_Store' },
        },
        follow_current_file = {
          enabled = false,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = '',
          expander_expanded = '',
        },
      },
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
