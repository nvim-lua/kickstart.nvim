local col_mark_80 = 80
local col_mark_120 = 120
local col_mark_180 = 180

---@class Section
local S = {}

--- Create a new `lualine` section
---@param t table a table with 'section-name'
---@return Section
function S:new(t)
  self.__index = self
  return setmetatable(t or {}, self)
end

--- Set bold for `lualine` section, if it supports it
---@return Section
function S:set_bold()
  self.color = self.color or {}
  self.color.gui = 'bold'
  return self
end

--- Set symbols for `lualine` section, if it supports it
---@param symbols table<string, string> key: name of the option, value: the icon
---@return Section
function S:set_symbols(symbols)
  self.symbols = self.symbols or {}
  self.symbols = symbols
  return self
end

--- Set format function to act on a `lualine` section
---@param fmt_func fun(str: string): string a function that takes the string that will be rendered and format it
---@return Section
function S:set_fmt(fmt_func)
  if self.fmt ~= nil then
    vim.defer_fn(function()
      vim.notify('lualine section (' .. self[1] .. '): already has fmt function', vim.log.levels.WARN)
    end, 1000)
    return self
  end

  self.fmt = fmt_func
  return self
end

--- Set responsive _autohide_ width for `lualine` section by providing a fmt function
--- Setting this will affect other implementation of fmt_func
---@see Section.set_fmt
---@param onColumn integer? The column number where the section will be hidden when the buffer's width is less than
---@return Section
function S:set_autohide_fmt(onColumn)
  onColumn = onColumn or col_mark_120

  if self.fmt ~= nil then
    vim.defer_fn(function()
      vim.notify('lualine section (' .. self[1] .. '): already has fmt function', vim.log.levels.WARN)
    end, 1000)
    return self
  end

  self.fmt = function(str)
    if vim.api.nvim_win_get_width(0) > onColumn then
      return str
    end
    return ''
  end
  return self
end

local devKit_icons = Glyphs.dev_kit
local fs_icons = Glyphs.file_status
local diag_icons = {}
for key, val in pairs(Glyphs.diagnostics) do
  diag_icons[key] = val .. ' '
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-mini/mini.nvim', -- for mini.icons, and maybe only needed for filetype component
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = false,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        },
      },
      sections = {
        lualine_a = {
          S:new({ 'mode' })
            :set_fmt( -- trim to initials using kebab-case
              function(str)
                if vim.api.nvim_win_get_width(0) > col_mark_120 then
                  return str
                end
                if str:match '-' then
                  -- matches V-L/INE and V-B/LOCK
                  return str:sub(1, 3)
                end
                -- just the first char
                return str:sub(1, 1)
              end
            )
            :set_bold(),
        },

        lualine_b = {
          S:new({ 'branch', icon = '' })
            :set_fmt( -- trim to first char
              function(str)
                if vim.api.nvim_win_get_width(0) > col_mark_120 then
                  return str
                end
                -- just the first char
                return str:sub(1, 1)
              end
            )
            :set_bold(),
          S:new({ 'diff' }):set_bold():set_autohide_fmt(),
          S:new({ 'diagnostics' }):set_symbols(diag_icons):set_autohide_fmt(80),
        },

        lualine_c = {
          {
            function()
              -- do some evaluation
              local buff_width = vim.api.nvim_win_get_width(0)
              local proto_prefix = vim.fn.expand('%'):match '(.-://).+' or ''

              local filename_parts = {}

              -- handle special case before setting default
              if proto_prefix == 'oil://' then
                filename_parts[1] = (buff_width > col_mark_80 and '%F')
                  or proto_prefix .. '.../' .. vim.fs.basename(vim.fn.fnamemodify(vim.fn.getcwd(), '%:p')) .. '/'
              elseif proto_prefix == 'term://' then
                filename_parts[1] = proto_prefix .. '%t'
              else
                -- responsive file-path-name
                filename_parts[1] = (buff_width > col_mark_180 and '%F') -- full path
                  or (buff_width > col_mark_120 and '%f') -- relative path
                  or proto_prefix .. '%t' -- file name only
              end

              -- modifiable indicator
              filename_parts[#filename_parts + 1] = vim.bo.modified and fs_icons.modified
                or not vim.bo.modifiable and fs_icons.unmodifiable
                or nil
              -- read-only indicator
              filename_parts[#filename_parts + 1] = (vim.bo.readonly and fs_icons.readOnly) or nil

              -- preview indicator
              filename_parts[#filename_parts + 1] = (vim.wo.previewwindow and fs_icons.preview) or nil

              return '%<' .. table.concat(filename_parts, ' ')
            end,
          },
        },

        lualine_x = {
          S:new({
            -- A formatters section
            function()
              local ok, conform = pcall(require, 'conform')
              if not ok then
                return ''
              end

              local formatters = conform.list_formatters_to_run(0)
              if #formatters == 0 then
                return ''
              end

              local formatter_names = {}
              for _, formatter in ipairs(formatters) do
                table.insert(formatter_names, formatter.name)
              end

              return devKit_icons.fmt .. ' ' .. table.concat(formatter_names, ' ')
            end,
          }):set_autohide_fmt(),
          S:new({
            -- A formatters section
            function()
              local ok, lint = pcall(require, 'lint')
              if not ok then
                return ''
              end

              local filetype = vim.bo.filetype
              local linters = lint.linters_by_ft[filetype]

              if not linters then
                return ''
              end

              return devKit_icons.lint .. ' ' .. table.concat(linters, ' ')
            end,
          }):set_autohide_fmt(),
          {
            'lsp_status',
            icon = devKit_icons.lsp,
          },
        },

        lualine_y = {
          S:new({ 'encoding' }):set_bold():set_autohide_fmt(),
          S:new({ 'fileformat' }):set_bold():set_autohide_fmt(),
          S:new({ 'filetype' }):set_bold(),
        },

        lualine_z = {
          S:new({ 'progress' }):set_bold():set_autohide_fmt(),
          S:new({
            -- A location section, row:col
            function()
              if vim.api.nvim_win_get_width(0) > col_mark_120 then
                -- padding with two char
                return '%2l:%-2v'
              end
              return '%l:%v'
            end,
          }):set_bold(),
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 3 } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            'tabs',
            max_length = vim.o.columns, -- Maximum width of tabs component.
            mode = 2, -- Shows tab_nr + tab_name

            -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
            use_mode_colors = true,

            show_modified_status = false, -- I don't need this option, because I handle it in another place

            fmt = function(name, context)
              -- match buffers similar to 'term://', 'oil://'
              local buffer_protocol = context.file:match '(.-://).+'
              if buffer_protocol then
                name = buffer_protocol .. name
              end

              -- Show + if buffer is modified in tab
              local buflist = vim.fn.tabpagebuflist(context.tabnr)
              local winnr = vim.fn.tabpagewinnr(context.tabnr)
              local bufnr = buflist[winnr]
              local mod = vim.fn.getbufvar(bufnr, '&mod')

              return name .. (mod == 1 and ' ' .. Glyphs.file_status.modified or '')
            end,
          },
        },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
