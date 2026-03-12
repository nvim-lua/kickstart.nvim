-- Declare a global function to retrieve the current directory
-- check out https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#show-cwd-in-the-winbar
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require('oil').get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = {
    { 'nvim-mini/mini.nvim', opts = {} }, -- only for mini.icons
  },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    {
      '<leader>tf',
      '<CMD>Oil<CR>',
      desc = '[T]oggle Oil [F]ile manager',
    },
    -- {
    --   '<leader>tF',
    --   function()
    --     require('oil').toggle_float(nil, { preview = { split = 'belowright' } })
    --   end,
    --   desc = '[T]oggle Oil [F]ile manager, float-mode',
    -- },
  },
  config = function()
    require('oil').isDetailed = true
    require('oil').setup {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
      default_file_explorer = true,
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
      columns = {
        'permissions',
        'size',
        'mtime',
        'icon',
      },
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
        winbar = '%!v:lua.get_oil_winbar()',
      },
      -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
      delete_to_trash = false,
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = false,
      -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
      -- (:help prompt_save_on_select_new_entry)
      prompt_save_on_select_new_entry = true,
      -- Oil will automatically delete hidden buffers after this delay
      -- You can set the delay to false to disable cleanup entirely
      -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = true,
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = false,
      },
      -- Constrain the cursor to the editable parts of the oil buffer
      -- Set to `false` to disable, or "name" to keep it on the file names
      constrain_cursor = 'editable',
      -- Set to true to watch the filesystem for changes and reload oil
      watch_for_changes = false,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ['g?'] = { mode = 'n', 'actions.show_help' },
        ['go'] = { mode = 'n', 'actions.select' },
        ['<CR>'] = { mode = 'n', 'actions.select' },
        ['gv'] = { mode = 'n', 'actions.select', opts = { vertical = true } },
        ['gh'] = { mode = 'n', 'actions.select', opts = { horizontal = true } },
        ['gb'] = { mode = 'n', 'actions.select', opts = { tab = true } },
        ['gp'] = {
          mode = 'n',
          callback = function()
            -- require('oil').open_preview { vertical = false, horizontal = true, split = 'belowright' }
            local v = vim.api.nvim_win_get_width(0) > 150
            require('oil.actions').preview.callback { vertical = v, horizontal = not v, split = 'belowright' }
          end,
          desc = 'Toggle/Untoggle preview window',
        },
        ['gc'] = { mode = 'n', 'actions.close' },
        ['gl'] = { mode = 'n', 'actions.refresh' },
        ['-'] = { mode = 'n', 'actions.parent' },
        ['<BS>'] = { mode = 'n', 'actions.parent' },
        ['_'] = { mode = 'n', 'actions.open_cwd' },
        ['gw'] = { mode = 'n', 'actions.open_cwd' },
        ['`'] = { mode = 'n', 'actions.cd' },
        ['~'] = { mode = 'n', 'actions.cd', opts = { scope = 'tab' } },
        ['gd'] = {
          mode = 'n',
          callback = function()
            local oil = require 'oil'
            if oil.isDetailed then
              oil.set_columns { 'icon' }
            else
              oil.set_columns { 'permissions', 'size', 'mtime', 'icon' }
            end
            oil.isDetailed = not oil.isDetailed
          end,
          desc = 'Toggle/Untoggle detailed view',
        },
        ['gs'] = { mode = 'n', 'actions.change_sort' },
        ['gx'] = { mode = 'n', 'actions.open_external' },
        ['g.'] = {
          mode = 'n',
          callback = 'actions.toggle_hidden',
          desc = 'Toggle/Untoggle hidden files and directories',
        },
        ['g\\'] = { mode = 'n', 'actions.toggle_trash' },
        ['gq'] = { mode = 'n', 'actions.close' },

        -- keymaps to scrolle preview window
        ['H'] = { mode = 'n', 'actions.preview_scroll_left' },
        ['J'] = { mode = 'n', 'actions.preview_scroll_down' },
        ['K'] = { mode = 'n', 'actions.preview_scroll_up' },
        ['L'] = { mode = 'n', 'actions.preview_scroll_right' },
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          local m = name:match '^%.'
          return m ~= nil
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
        -- Sort file names with numbers in a more intuitive order for humans.
        -- Can be "fast", true, or false. "fast" will turn it off for large directories.
        natural_order = 'fast',
        -- Sort file and directory names case insensitive
        case_insensitive = false,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
        -- Customize the highlight group for the file name
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
          return nil
        end,
      },
      -- Extra arguments to pass to SCP when moving/copying files over SSH
      extra_scp_args = {},
      -- Extra arguments to pass to aws s3 when creating/deleting/moving/copying files using aws s3
      extra_s3_args = {},
      -- EXPERIMENTAL support for performing file operations with git
      git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
          return false
        end,
        mv = function(src_path, dest_path)
          return false
        end,
        rm = function(path)
          return false
        end,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0,
        max_height = 0,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = 'auto',
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
      -- Configuration for the file preview window
      preview_win = {
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
        -- How to open the preview window "load"|"scratch"|"fast_scratch"
        preview_method = 'fast_scratch',
        -- A function that returns true to disable preview on a file e.g. to avoid lag
        disable_preview = function(filename)
          return false
        end,
        -- Window-local options to use for preview window buffers
        win_options = {
          wrap = false,
        },
      },
      -- Configuration for the floating action confirmation window
      confirmation = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },
      -- Configuration for the floating progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        minimized_border = 'none',
        win_options = {
          winblend = 0,
        },
      },
      -- Configuration for the floating SSH window
      ssh = {
        border = 'rounded',
      },
      -- Configuration for the floating keymaps help window
      keymaps_help = {
        border = 'rounded',
      },
    }
  end,
}
