--
-- This file contains the components that are used in the lualine configuration
--

local icons = require('utils.icons')
local conditions = require('utils.lualine.conditions')
local colors = require('utils.lualine.colors')

return {
  branch = {
    'b:gitsigns_head',
    icon = icons.git.Branch,
    color = { gui = 'bold' },
  },
  filename = {
    'filename',
    color = {},
    cond = nil,
  },
  diff = {
    'diff',
    symbols = {
      added = icons.git.LineAdded .. ' ',
      modified = icons.git.LineModified .. ' ',
      removed = icons.git.LineRemoved .. ' ',
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = nil,
  },
  diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
      error = icons.diagnostics.BoldError .. ' ',
      warn = icons.diagnostics.BoldWarning .. ' ',
      info = icons.diagnostics.BoldInformation .. ' ',
      hint = icons.diagnostics.BoldHint .. ' ',
    },
    -- cond = conditions.hide_in_width,
  },
  treesitter = {
    function()
      return icons.ui.Tree
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end,
    cond = conditions.hide_in_width,
  },
  copilot = {
    function()
      local client = require('copilot.client')
      local copilot_active = client.buf_is_attached(vim.api.nvim_get_current_buf())
      -- local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
      -- local copilot_active = false
      --
      -- -- look for copilot client
      -- for _, client in pairs(buf_clients) do
      --   if client.name == 'copilot' then
      --     copilot_active = true
      --   end
      -- end
      --
      if copilot_active then
        return icons.git.Copilot
      end

      return ''
    end,
    color = function()
      local api = require('copilot.api')
      local status = api.status.data.status

      if status == 'InProgress' then
        return { gui = 'bold', fg = colors.yellow }
      elseif status == 'Warning' then
        return { gui = 'bold', fg = colors.red }
      end

      return { gui = 'bold', fg = colors.green }
    end,
    cond = conditions.hide_in_width,
  },
  lsp = {
    function()
      local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if #buf_clients == 0 then
        return 'LSP Inactive'
      end

      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= 'null-ls' and client.name ~= 'copilot' then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local formatters = require('utils.none-ls.formatters')
      local supported_formatters = formatters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require('utils.none-ls.linters')
      local supported_linters = linters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      local unique_client_names = vim.fn.uniq(buf_client_names)

      local language_servers = '[' .. table.concat(unique_client_names, ', ') .. ']'

      return language_servers
    end,
    color = { gui = 'bold' },
    cond = conditions.hide_in_width,
  },
  location = { 'location' },
  progress = {
    'progress',
    fmt = function()
      return '%P/%L'
    end,
    color = {},
  },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
      return icons.ui.Tab .. ' ' .. shiftwidth
    end,
    padding = 1,
  },
  encoding = {
    'o:encoding',
    fmt = string.upper,
    color = {},
    cond = conditions.hide_in_width,
  },
  filetype = { 'filetype', cond = nil, padding = { left = 1, right = 1 } },
  scrollbar = {
    function()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')
      local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = 'SLProgress',
    cond = nil,
  },
}
