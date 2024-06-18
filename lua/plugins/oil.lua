return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  keys = {
    {
      '~',
      '<CMD>Oil<CR>',
      mode = '',
      desc = 'Open parent directory',
    },
  },
  opts = {
    default_file_explorer = true,
    restore_window_options = true,

    keymaps = {
      ['gd'] = {
        desc = 'Toggle file detail view',
        callback = function()
          vim.g.detail = not vim.g.detail
          if vim.g.detail then
            require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
          else
            require('oil').set_columns { 'icon' }
          end
        end,
      },
    },
    win_options = {
      wrap = true,
      -- signcolumn = '',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nivc',
    },

    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        return name:match '.git'
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = 'oil://*',
      callback = function(params)
        local bufnr = params.buf
        if params.event == 'BufEnter' then
          -- double Q to close window
          vim.keymap.set('', 'qq', require('oil').close, { buffer = bufnr, desc = 'Close current window' })

          -- toggle detailed list mode
          vim.keymap.set('', '<leader>tnnn', function()
            local fu = require 'fancyutil'
            local winnr = 0
            local val = fu.get_oil_nnn(winnr)
            fu.set_oil_nnn(val ~= true, winnr)
          end, { buffer = bufnr, desc = '[T]oggle [nnn] Mode' })

          --- nnn move up file tree
          vim.keymap.set('', '<Left>', function()
            if require('oil.util').is_oil_bufnr(bufnr) and require('fancyutil').get_oil_nnn() then
              local oil = require 'oil'
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              local parent = oil.get_buffer_parent_url(bufname, true)
              return oil.open(parent)
            end
            local keys = vim.api.nvim_replace_termcodes('<Left>', true, false, true)
            vim.api.nvim_feedkeys(keys, 'n', false) -- send consumed keys
          end, { buffer = bufnr, desc = 'Move up the file tree' })

          -- nnn move down file tree
          vim.keymap.set('', '<Right>', function()
            local oil = require 'oil'
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if entry and dir and require('fancyutil').get_oil_nnn(0) then
              local path = dir .. entry.name
              local stat = vim.loop.fs_stat(path)
              if stat and stat.type == 'directory' then
                return oil.open(path)
              end
            end
            local keys = vim.api.nvim_replace_termcodes('<Right>', true, false, true)
            vim.api.nvim_feedkeys(keys, 'n', false) -- send consumed keys
          end, { buffer = bufnr, desc = 'Move down the file tree' })
          return
        end
        local winnr = vim.fn.bufwinid(bufnr)
        local val = require('fancyutil').get_oil_nnn(winnr)
        if val == nil then
          require('fancyutil').set_oil_nnn(true, winnr)
        end
      end,
    })
  end,
}
