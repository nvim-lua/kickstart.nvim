local col_mark_1 = 120
local col_mark_2 = 180

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
  onColumn = onColumn or col_mark_1

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

local diag_icons = {}
for key, val in pairs(Glyphs.diagnostics) do
  diag_icons[key] = val .. ' '
end

local fs_icons = Glyphs.file_status

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
        always_show_tabline = true,
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
                if vim.api.nvim_win_get_width(0) > col_mark_1 then
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
          S:new({ 'branch' })
            :set_fmt( -- trim to first char
              function(str)
                if vim.api.nvim_win_get_width(0) > col_mark_1 then
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
            -- TODO: this still doesn't work with buffers like oil.nvim
            function()
              -- do some evaluation
              local buff_width = vim.api.nvim_win_get_width(0)
              local m_flag = vim.api.nvim_eval_statusline('%m', {}).str
              local r_flag = vim.api.nvim_eval_statusline('%r', {}).str
              local w_flag = vim.api.nvim_eval_statusline('%w', {}).str

              local filename_parts = {
                -- responsive file-path-name
                (buff_width > col_mark_2 and '%F') -- full path
                  or (buff_width > col_mark_1 and '%f') -- relative path
                  or '%t', -- file name only
                -- modifiable indicator
                (m_flag == '[+]' and fs_icons.modified)
                  or (m_flag == '[-]' and fs_icons.unmodifiable)
                  or m_flag,
                -- read-only indicator
                (r_flag == '[RO]' and fs_icons.readOnly) or r_flag,
                -- preview indicator
                (w_flag == '[Preview]' and fs_icons.preview) or w_flag,
              }

              -- immediately concating table puts more whitespace for empty fields
              -- so I'm manually concating
              local str = '%<'
              for _, v in ipairs(filename_parts) do
                if v ~= '' then
                  str = str .. v .. ' '
                end
              end

              return str
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
              if vim.api.nvim_win_get_width(0) > col_mark_1 then
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
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
