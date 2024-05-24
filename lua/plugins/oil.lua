return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    keys = {
      {
        'qq',
        function()
          require('oil').close()
        end,
        mode = '',
        desc = 'Close current window',
      },
      {
        '~',
        '<CMD>Oil<CR>',
        mode = '',
        desc = 'Open parent directory',
      },
      {
        '<Left>',
        function()
          if require('oil.util').is_oil_bufnr(0) then
            local oil = require 'oil'
            local bufname = vim.api.nvim_buf_get_name(0)
            local parent = oil.get_buffer_parent_url(bufname, true)
            return oil.open(parent)
          end
          -- fallback to sending page up key
          local keys = vim.api.nvim_replace_termcodes('<Left>', true, false, true)
          vim.api.nvim_feedkeys(keys, 'n', false)
        end,
        mode = 'i',
        desc = 'Move up the file tree',
      },
      {
        '<Right>',
        function()
          local oil = require 'oil'
          local entry = oil.get_cursor_entry()
          local dir = oil.get_current_dir()
          if entry and dir then
            local path = dir .. entry.name
            local stat = vim.loop.fs_stat(path)
            if stat and stat.type == 'directory' then
              return oil.open(path)
            end
          end
          -- fallback to sending arrow key
          local keys = vim.api.nvim_replace_termcodes('<Right>', true, false, true)
          vim.api.nvim_feedkeys(keys, 'n', false)
        end,
        mode = 'i',
        desc = 'Move down the file tree',
      },
    },
    opts = {
      default_file_explorer = true,

      win_options = {
        wrap = true,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nivc',
      },
      restore_window_options = true,

      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name:match '.git'
        end,
      },

      extensions = {
        'oil',
      },
    },
  },
}
