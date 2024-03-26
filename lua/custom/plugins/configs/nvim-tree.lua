local lib = require 'nvim-tree.lib'
local log = require 'nvim-tree.log'
local appearance = require 'nvim-tree.appearance'
local renderer = require 'nvim-tree.renderer'
local view = require 'nvim-tree.view'
local commands = require 'nvim-tree.commands'
local utils = require 'nvim-tree.utils'
local actions = require 'nvim-tree.actions'
local legacy = require 'nvim-tree.legacy'
local core = require 'nvim-tree.core'
local git = require 'nvim-tree.git'
local filters = require 'nvim-tree.explorer.filters'
local buffers = require 'nvim-tree.buffers'
local events = require 'nvim-tree.events'
local notify = require 'nvim-tree.notify'

local _config = {}

local M = {
  init_root = '',
}

--- Update the tree root to a directory or the directory containing
---@param path string relative or absolute
---@param bufnr number|nil
function M.change_root(path, bufnr)
  -- skip if current file is in ignore_list
  if type(bufnr) == 'number' then
    local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype') or ''
    for _, value in pairs(_config.update_focused_file.ignore_list) do
      if utils.str_find(path, value) or utils.str_find(ft, value) then
        return
      end
    end
  end

  -- don't find inexistent
  if vim.fn.filereadable(path) == 0 then
    return
  end

  local cwd = core.get_cwd()
  if cwd == nil then
    return
  end

  local vim_cwd = vim.fn.getcwd()

  -- test if in vim_cwd
  if utils.path_relative(path, vim_cwd) ~= path then
    if vim_cwd ~= cwd then
      actions.root.change_dir.fn(vim_cwd)
    end
    return
  end
  -- test if in cwd
  if utils.path_relative(path, cwd) ~= path then
    return
  end

  -- otherwise test M.init_root
  if _config.prefer_startup_root and utils.path_relative(path, M.init_root) ~= path then
    actions.root.change_dir.fn(M.init_root)
    return
  end
  -- otherwise root_dirs
  for _, dir in pairs(_config.root_dirs) do
    dir = vim.fn.fnamemodify(dir, ':p')
    if utils.path_relative(path, dir) ~= path then
      actions.root.change_dir.fn(dir)
      return
    end
  end
  -- finally fall back to the folder containing the file
  actions.root.change_dir.fn(vim.fn.fnamemodify(path, ':p:h'))
end

function M.tab_enter()
  if view.is_visible { any_tabpage = true } then
    local bufname = vim.api.nvim_buf_get_name(0)
    local ft = vim.api.nvim_buf_get_option(0, 'ft')
    for _, filter in ipairs(M.config.tab.sync.ignore) do
      if bufname:match(filter) ~= nil or ft:match(filter) ~= nil then
        return
      end
    end
    view.open { focus_tree = false }
    renderer.draw()
  end
end

function M.open_on_directory()
  local should_proceed = _config.hijack_directories.auto_open or view.is_visible()
  if not should_proceed then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(buf)
  if vim.fn.isdirectory(bufname) ~= 1 then
    return
  end

  actions.root.change_dir.force_dirchange(bufname, true)
end

function M.place_cursor_on_node()
  local ok, search = pcall(vim.fn.searchcount)
  if ok and search and search.exact_match == 1 then
    return
  end

  local node = lib.get_node_at_cursor()
  if not node or node.name == '..' then
    return
  end
  node = utils.get_parent_of_group(node)

  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local idx = vim.fn.stridx(line, node.name)

  if idx >= 0 then
    vim.api.nvim_win_set_cursor(0, { cursor[1], idx })
  end
end

---@return table
function M.get_config()
  return M.config
end

---@param disable_netrw boolean
---@param hijack_netrw boolean
local function manage_netrw(disable_netrw, hijack_netrw)
  if hijack_netrw then
    vim.cmd 'silent! autocmd! FileExplorer *'
    vim.cmd 'autocmd VimEnter * ++once silent! autocmd! FileExplorer *'
  end
  if disable_netrw then
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end
end

---@param name string|nil
function M.change_dir(name)
  if name then
    actions.root.change_dir.fn(name)
  end

  if _config.update_focused_file.enable then
    actions.tree.find_file.fn()
  end
end

---@param opts table
local function setup_autocommands(opts)
  local augroup_id = vim.api.nvim_create_augroup('NvimTree', { clear = true })
  local function create_nvim_tree_autocmd(name, custom_opts)
    local default_opts = { group = augroup_id }
    vim.api.nvim_create_autocmd(name, vim.tbl_extend('force', default_opts, custom_opts))
  end

  -- reset and draw (highlights) when colorscheme is changed
  create_nvim_tree_autocmd('ColorScheme', {
    callback = function()
      appearance.setup()
      view.reset_winhl()
      renderer.draw()
    end,
  })

  -- prevent new opened file from opening in the same window as nvim-tree
  create_nvim_tree_autocmd('BufWipeout', {
    pattern = 'NvimTree_*',
    callback = function()
      if not utils.is_nvim_tree_buf(0) then
        return
      end
      if opts.actions.open_file.eject then
        view._prevent_buffer_override()
      else
        view.abandon_current_window()
      end
    end,
  })

  create_nvim_tree_autocmd('BufWritePost', {
    callback = function()
      if opts.auto_reload_on_write and not opts.filesystem_watchers.enable then
        actions.reloaders.reload_explorer()
      end
    end,
  })

  create_nvim_tree_autocmd('BufReadPost', {
    callback = function(data)
      -- update opened file buffers
      if (filters.config.filter_no_buffer or renderer.config.highlight_opened_files ~= 'none') and vim.bo[data.buf].buftype == '' then
        utils.debounce('Buf:filter_buffer', opts.view.debounce_delay, function()
          actions.reloaders.reload_explorer()
        end)
      end
    end,
  })

  create_nvim_tree_autocmd('BufUnload', {
    callback = function(data)
      -- update opened file buffers
      if (filters.config.filter_no_buffer or renderer.config.highlight_opened_files ~= 'none') and vim.bo[data.buf].buftype == '' then
        utils.debounce('Buf:filter_buffer', opts.view.debounce_delay, function()
          actions.reloaders.reload_explorer()
        end)
      end
    end,
  })

  create_nvim_tree_autocmd('User', {
    pattern = { 'FugitiveChanged', 'NeogitStatusRefreshed' },
    callback = function()
      if not opts.filesystem_watchers.enable and opts.git.enable then
        actions.reloaders.reload_git()
      end
    end,
  })

  if opts.tab.sync.open then
    create_nvim_tree_autocmd('TabEnter', { callback = vim.schedule_wrap(M.tab_enter) })
  end
  if opts.hijack_cursor then
    create_nvim_tree_autocmd('CursorMoved', {
      pattern = 'NvimTree_*',
      callback = function()
        if utils.is_nvim_tree_buf(0) then
          M.place_cursor_on_node()
        end
      end,
    })
  end
  if opts.sync_root_with_cwd then
    create_nvim_tree_autocmd('DirChanged', {
      callback = function()
        M.change_dir(vim.loop.cwd())
      end,
    })
  end
  if opts.update_focused_file.enable then
    create_nvim_tree_autocmd('BufEnter', {
      callback = function()
        utils.debounce('BufEnter:find_file', opts.view.debounce_delay, function()
          actions.tree.find_file.fn()
        end)
      end,
    })
  end

  if opts.hijack_directories.enable then
    create_nvim_tree_autocmd({ 'BufEnter', 'BufNewFile' }, { callback = M.open_on_directory })
  end

  create_nvim_tree_autocmd('BufEnter', {
    pattern = 'NvimTree_*',
    callback = function()
      if utils.is_nvim_tree_buf(0) then
        if vim.fn.getcwd() ~= core.get_cwd() or (opts.reload_on_bufenter and not opts.filesystem_watchers.enable) then
          actions.reloaders.reload_explorer()
        end
      end
    end,
  })

  if opts.view.centralize_selection then
    create_nvim_tree_autocmd('BufEnter', {
      pattern = 'NvimTree_*',
      callback = function()
        vim.schedule(function()
          vim.api.nvim_buf_call(0, function()
            vim.cmd [[norm! zz]]
          end)
        end)
      end,
    })
  end

  if opts.diagnostics.enable then
    create_nvim_tree_autocmd('DiagnosticChanged', {
      callback = function()
        log.line('diagnostics', 'DiagnosticChanged')
        require('nvim-tree.diagnostics').update()
      end,
    })
    create_nvim_tree_autocmd('User', {
      pattern = 'CocDiagnosticChange',
      callback = function()
        log.line('diagnostics', 'CocDiagnosticChange')
        require('nvim-tree.diagnostics').update()
      end,
    })
  end

  if opts.view.float.enable and opts.view.float.quit_on_focus_loss then
    create_nvim_tree_autocmd('WinLeave', {
      pattern = 'NvimTree_*',
      callback = function()
        if utils.is_nvim_tree_buf(0) then
          view.close()
        end
      end,
    })
  end

  if opts.modified.enable then
    create_nvim_tree_autocmd({ 'BufModifiedSet', 'BufWritePost' }, {
      callback = function()
        utils.debounce('Buf:modified', opts.view.debounce_delay, function()
          buffers.reload_modified()
          actions.reloaders.reload_explorer()
        end)
      end,
    })
  end

  -- TODO #1545 remove similar check from view.resize
  if vim.fn.has 'nvim-0.9' == 1 then
    create_nvim_tree_autocmd('WinResized', {
      callback = function()
        if vim.v.event and vim.v.event.windows then
          for _, winid in ipairs(vim.v.event.windows) do
            if vim.api.nvim_win_is_valid(winid) and utils.is_nvim_tree_buf(vim.api.nvim_win_get_buf(winid)) then
              events._dispatch_on_tree_resize(vim.api.nvim_win_get_width(winid))
            end
          end
        end
      end,
    })
  end
end

local DEFAULT_OPTS = { -- BEGIN_DEFAULT_OPTS
  on_attach = 'default',
  hijack_cursor = false,
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  select_prompts = false,
  sort = {
    sorter = 'name',
    folders_first = true,
    files_first = false,
  },
  view = {
    centralize_selection = false,
    cursorline = true,
    debounce_delay = 15,
    side = 'left',
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
    width = 30,
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = 'editor',
        border = 'rounded',
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    full_name = false,
    root_folder_label = ':~:s?$?/..?',
    indent_width = 2,
    special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
    symlink_destination = true,
    highlight_git = 'none',
    highlight_diagnostics = 'none',
    highlight_opened_files = 'none',
    highlight_modified = 'none',
    highlight_bookmarks = 'none',
    highlight_clipboard = 'name',
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = '└',
        edge = '│',
        item = '│',
        bottom = '─',
        none = ' ',
      },
    },
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = false,
          color = true,
        },
      },
      git_placement = 'before',
      modified_placement = 'after',
      diagnostics_placement = 'signcolumn',
      bookmarks_placement = 'signcolumn',
      padding = ' ',
      symlink_arrow = ' ➛ ',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
        diagnostics = true,
        bookmarks = true,
      },
      glyphs = {
        default = '',
        symlink = '',
        bookmark = '󰆤',
        modified = '●',
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  system_open = {
    cmd = '',
    args = {},
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 400,
    cygwin_support = false,
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  modified = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  filters = {
    enable = true,
    git_ignored = true,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    no_bookmark = false,
    custom = {},
    exclude = {},
  },
  live_filter = {
    prefix = '[FILTER]: ',
    always_show_folders = true,
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = 'cursor',
        border = 'shadow',
        style = 'minimal',
      },
    },
    open_file = {
      quit_on_open = false,
      eject = true,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = 'default',
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = 'gio trash',
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
    absolute_path = true,
  },
  help = {
    sort_by = 'key',
  },
  ui = {
    confirm = {
      remove = true,
      trash = true,
      default_yes = false,
    },
  },
  experimental = {},
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
} -- END_DEFAULT_OPTS

local function merge_options(conf)
  return vim.tbl_deep_extend('force', DEFAULT_OPTS, conf or {})
end

local FIELD_SKIP_VALIDATE = {
  open_win_config = true,
}

local ACCEPTED_TYPES = {
  on_attach = { 'function', 'string' },
  sort = {
    sorter = { 'function', 'string' },
  },
  view = {
    width = {
      'string',
      'function',
      'number',
      'table',
      min = { 'string', 'function', 'number' },
      max = { 'string', 'function', 'number' },
      padding = { 'function', 'number' },
    },
  },
  renderer = {
    group_empty = { 'boolean', 'function' },
    root_folder_label = { 'function', 'string', 'boolean' },
  },
  filters = {
    custom = { 'function' },
  },
  actions = {
    open_file = {
      window_picker = {
        picker = { 'function', 'string' },
      },
    },
  },
}

local ACCEPTED_STRINGS = {
  sort = {
    sorter = { 'name', 'case_sensitive', 'modification_time', 'extension', 'suffix', 'filetype' },
  },
  view = {
    side = { 'left', 'right' },
    signcolumn = { 'yes', 'no', 'auto' },
  },
  renderer = {
    highlight_git = { 'none', 'icon', 'name', 'all' },
    highlight_opened_files = { 'none', 'icon', 'name', 'all' },
    highlight_modified = { 'none', 'icon', 'name', 'all' },
    highlight_bookmarks = { 'none', 'icon', 'name', 'all' },
    highlight_diagnostics = { 'none', 'icon', 'name', 'all' },
    highlight_clipboard = { 'none', 'icon', 'name', 'all' },
    icons = {
      git_placement = { 'before', 'after', 'signcolumn' },
      modified_placement = { 'before', 'after', 'signcolumn' },
      diagnostics_placement = { 'before', 'after', 'signcolumn' },
      bookmarks_placement = { 'before', 'after', 'signcolumn' },
    },
  },
  help = {
    sort_by = { 'key', 'desc' },
  },
}

---@param conf table|nil
local function validate_options(conf)
  local msg

  ---@param user any
  ---@param def any
  ---@param strs table
  ---@param types table
  ---@param prefix string
  local function validate(user, def, strs, types, prefix)
    -- if user's option is not a table there is nothing to do
    if type(user) ~= 'table' then
      return
    end

    -- only compare tables with contents that are not integer indexed
    if type(def) ~= 'table' or not next(def) or type(next(def)) == 'number' then
      -- unless the field can be a table (and is not a table in default config)
      if vim.tbl_contains(types, 'table') then
        -- use a dummy default to allow all checks
        def = {}
      else
        return
      end
    end

    for k, v in pairs(user) do
      if not FIELD_SKIP_VALIDATE[k] then
        local invalid

        if def[k] == nil and types[k] == nil then
          -- option does not exist
          invalid = string.format('Unknown option: %s%s', prefix, k)
        elseif type(v) ~= type(def[k]) then
          local expected

          if types[k] and #types[k] > 0 then
            if not vim.tbl_contains(types[k], type(v)) then
              expected = table.concat(types[k], '|')
            end
          else
            expected = type(def[k])
          end

          if expected then
            -- option is of the wrong type
            invalid = string.format('Invalid option: %s%s. Expected %s, got %s', prefix, k, expected, type(v))
          end
        elseif type(v) == 'string' and strs[k] and not vim.tbl_contains(strs[k], v) then
          -- option has type `string` but value is not accepted
          invalid = string.format("Invalid value for field %s%s: '%s'", prefix, k, v)
        end

        if invalid then
          if msg then
            msg = string.format('%s\n%s', msg, invalid)
          else
            msg = invalid
          end
          user[k] = nil
        else
          validate(v, def[k], strs[k] or {}, types[k] or {}, prefix .. k .. '.')
        end
      end
    end
  end

  validate(conf, DEFAULT_OPTS, ACCEPTED_STRINGS, ACCEPTED_TYPES, '')

  if msg then
    notify.warn(msg .. '\n\nsee :help nvim-tree-opts for available configuration options')
  end
end

--- Apply OS specific localisations to DEFAULT_OPTS
local function localise_default_opts()
  if utils.is_macos or utils.is_windows then
    DEFAULT_OPTS.trash.cmd = 'trash'
  end
end

function M.purge_all_state()
  require('nvim-tree.watcher').purge_watchers()
  view.close_all_tabs()
  view.abandon_all_windows()
  if core.get_explorer() ~= nil then
    git.purge_state()
    core.reset_explorer()
  end
end

---@param conf table|nil
function M.setup(conf)
  if vim.fn.has 'nvim-0.8' == 0 then
    notify.warn 'nvim-tree.lua requires Neovim 0.8 or higher'
    return
  end

  M.init_root = vim.fn.getcwd()

  localise_default_opts()

  legacy.migrate_legacy_options(conf or {})

  validate_options(conf)

  local opts = merge_options(conf)

  local netrw_disabled = opts.disable_netrw or opts.hijack_netrw

  _config.root_dirs = opts.root_dirs
  _config.prefer_startup_root = opts.prefer_startup_root
  _config.update_focused_file = opts.update_focused_file
  _config.hijack_directories = opts.hijack_directories
  _config.hijack_directories.enable = _config.hijack_directories.enable and netrw_disabled

  manage_netrw(opts.disable_netrw, opts.hijack_netrw)

  M.config = opts
  require('nvim-tree.notify').setup(opts)
  require('nvim-tree.log').setup(opts)

  if log.enabled 'config' then
    log.line('config', 'default config + user')
    log.raw('config', '%s\n', vim.inspect(opts))
  end

  require('nvim-tree.actions').setup(opts)
  require('nvim-tree.keymap').setup(opts)
  require('nvim-tree.appearance').setup()
  require('nvim-tree.diagnostics').setup(opts)
  require('nvim-tree.explorer').setup(opts)
  require('nvim-tree.git').setup(opts)
  require('nvim-tree.git.utils').setup(opts)
  require('nvim-tree.view').setup(opts)
  require('nvim-tree.lib').setup(opts)
  require('nvim-tree.renderer').setup(opts)
  require('nvim-tree.live-filter').setup(opts)
  require('nvim-tree.marks').setup(opts)
  require('nvim-tree.buffers').setup(opts)
  require('nvim-tree.help').setup(opts)
  require('nvim-tree.watcher').setup(opts)
  if M.config.renderer.icons.show.file and pcall(require, 'nvim-web-devicons') then
    require('nvim-web-devicons').setup()
  end

  setup_autocommands(opts)

  if vim.g.NvimTreeSetup ~= 1 then
    -- first call to setup
    commands.setup()
  else
    -- subsequent calls to setup
    M.purge_all_state()
  end

  vim.g.NvimTreeSetup = 1
  vim.api.nvim_exec_autocmds('User', { pattern = 'NvimTreeSetup' })
end

vim.g.NvimTreeRequired = 1
vim.api.nvim_exec_autocmds('User', { pattern = 'NvimTreeRequired' })

return M
