local function mocha_highlights()
  vim.cmd [[
    hi default link NotifyBackground Normal
    hi default NotifyERRORBorder guifg=#313244
    hi default NotifyWARNBorder guifg=#45475a
    hi default NotifyINFOBorder guifg=#585b70
    hi default NotifyDEBUGBorder guifg=#7f849c
    hi default NotifyTRACEBorder guifg=#45475a
    hi default NotifyERRORIcon guifg=#f38ba8
    hi default NotifyWARNIcon guifg=#fab387
    hi default NotifyINFOIcon guifg=#a6e3a1
    hi default NotifyDEBUGIcon guifg=#7f849c
    hi default NotifyTRACEIcon guifg=#cba6f7
    hi default NotifyERRORTitle  guifg=#f38ba8
    hi default NotifyWARNTitle guifg=#fab387
    hi default NotifyINFOTitle guifg=#a6e3a1
    hi default NotifyDEBUGTitle  guifg=#7f849c
    hi default NotifyTRACETitle  guifg=#cba6f7
    hi default link NotifyERRORBody Normal
    hi default link NotifyWARNBody Normal
    hi default link NotifyINFOBody Normal
    hi default link NotifyDEBUGBody Normal
    hi default link NotifyTRACEBody Normal

    hi default link NotifyLogTime Comment
    hi default link NotifyLogTitle Special
  ]]
end

return {
  {
    'rcarriga/nvim-notify',
    cmd = { 'VeryLazy' },
    init = function()
      mocha_highlights()
    end,
    opts = {
      render = 'minimal',
      background_colour = 'NotifyBackground',
      level = 2,
      fps = 30,
      icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '',
        TRACE = '✎',
        WARN = '',
      },
      minimum_width = 50,
      stages = 'fade_in_slide_out',
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
      timeout = 5000,
      top_down = true,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      on_close = function(args) end,
    },
    config = function(opts)
      local notify = require 'notify'
      notify.setup(opts)
      -- vim.api.nvim_buf_get_extmarks(u, ns_id, start, end_, opts)
      vim.notify = notify
    end,
  },
}
