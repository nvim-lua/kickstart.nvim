local function titleize(action)
  if type(action) ~= 'string' then
    return nil
  end
  if action == '' then
    return nil
  end
  local out = action:gsub('_', ' ')
  return out:sub(1, 1):upper() .. out:sub(2)
end

local function action_desc(action)
  if type(action) == 'string' then
    return titleize(action)
  end
  if type(action) == 'function' then
    return 'Custom action'
  end
  if type(action) ~= 'table' then
    return nil
  end

  if action.desc then
    return action.desc
  end

  if action.action then
    return action_desc(action.action)
  end

  local is_list = vim.islist or vim.tbl_islist
  if is_list and is_list(action) then
    local parts = {}
    for _, item in ipairs(action) do
      local desc = action_desc(item)
      if desc then
        parts[#parts + 1] = desc
      end
    end
    if #parts > 0 then
      return table.concat(parts, ', ')
    end
  end

  return nil
end

local function add_desc_to_picker_keys(opts)
  local function apply(keys)
    if not keys then
      return
    end
    for _, spec in pairs(keys) do
      if type(spec) == 'table' and spec.desc == nil then
        local action = spec[1] or spec[2]
        local desc = action_desc(action)
        if desc then
          spec.desc = desc
        end
      end
    end
  end

  for _, win in pairs(opts.win or {}) do
    apply(win.keys)
  end
  for _, source in pairs(opts.sources or {}) do
    if type(source) == 'table' and source.win then
      for _, win in pairs(source.win) do
        apply(win.keys)
      end
    end
  end
end

local function ensure_dashboard_desc_keymaps()
  if vim.g.snacks_dashboard_desc_keymaps then
    return
  end
  vim.g.snacks_dashboard_desc_keymaps = true

  local group = vim.api.nvim_create_augroup('snacks_dashboard_desc', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'snacks_dashboard',
    callback = function(ev)
      vim.keymap.set('n', 'q', '<cmd>bd<cr>', { buffer = ev.buf, silent = true, desc = 'Close dashboard' })
      local cfg = vim.api.nvim_win_get_config(0)
      if cfg and cfg.relative ~= '' then
        vim.keymap.set('n', '<esc>', '<cmd>bd<cr>', { buffer = ev.buf, silent = true, desc = 'Close dashboard' })
      end
    end,
  })
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      config = function()
        ensure_dashboard_desc_keymaps()
      end,
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      config = function(opts)
        add_desc_to_picker_keys(opts)
      end,
    },
    notifier = {
      enabled = true,
      top_down = false,
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = true },

    styles = {
      input = {
        keys = {
          n_esc = {
            '<esc>',
            { 'cmp_close', 'cancel' },
            mode = 'n',
            expr = true,
            desc = 'Cancel input',
          },
          i_esc = {
            '<esc>',
            { 'cmp_close', 'stopinsert' },
            mode = 'i',
            expr = true,
            desc = 'Cancel input',
          },
          i_cr = {
            '<cr>',
            { 'cmp_accept', 'confirm' },
            mode = { 'i', 'n' },
            expr = true,
            desc = 'Confirm input',
          },
          i_tab = {
            '<tab>',
            { 'cmp_select_next', 'cmp' },
            mode = 'i',
            expr = true,
            desc = 'Next completion',
          },
          i_ctrl_w = {
            '<c-w>',
            '<c-s-w>',
            mode = 'i',
            expr = true,
            desc = 'Delete word',
          },
          i_up = {
            '<up>',
            { 'hist_up' },
            mode = { 'i', 'n' },
            desc = 'History up',
          },
          i_down = {
            '<down>',
            { 'hist_down' },
            mode = { 'i', 'n' },
            desc = 'History down',
          },
          q = { 'q', 'cancel', desc = 'Cancel input' },
        },
      },
      terminal = {
        keys = {
          q = { 'q', 'hide', desc = 'Hide terminal' },
          gf = {
            'gf',
            function(self)
              local f = vim.fn.findfile(vim.fn.expand '<cfile>', '**')
              if f == '' then
                Snacks.notify.warn 'No file under cursor'
              else
                self:hide()
                vim.schedule(function()
                  vim.cmd('e ' .. f)
                end)
              end
            end,
            desc = 'Open file under cursor',
          },
        },
      },
    },
  },
}
