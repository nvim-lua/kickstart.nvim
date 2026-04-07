return {
  {
    'rmagatti/auto-session',
    lazy = false,
    init = function()
      -- Required by auto-session for filetype and highlighting to survive session restore
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    end,
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { '<leader>wr', '<cmd>AutoSession search<CR>', desc = 'Session search' },
      { '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
      { '<leader>wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
    },

    ---enables autocomplete for opts
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '/' },
      -- Keep sessions even when only a directory/sidebar is open (IDE-style usage).
      auto_delete_empty_sessions = false,
      save_extra_data = function(_)
        local ok, layout = pcall(require, 'custom.layout')
        if not ok then return nil end

        local focus = layout.capture_focus()
        if not focus then return nil end

        return vim.fn.json_encode {
          focus = focus,
        }
      end,
      restore_extra_data = function(_, extra_data)
        local ok_json, decoded = pcall(vim.fn.json_decode, extra_data)
        if not ok_json or type(decoded) ~= 'table' then return end

        local ok_layout, layout = pcall(require, 'custom.layout')
        if not ok_layout then return end

        local focus = decoded.focus
        if type(focus) == 'table' then vim.schedule(function() layout.restore_focus(focus) end) end
      end,
      post_restore_cmds = {
        function(_)
          local ok_layout, layout = pcall(require, 'custom.layout')
          if not ok_layout then return end

          vim.schedule(function() layout.reset_ide_layout { focus_main = false } end)
        end,
      },
      -- log_level = 'debug',
    },
  },
}
