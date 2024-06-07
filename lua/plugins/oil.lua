return {
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
      '<leader>tn',
      function()
        local val = require('fancyutil').get_oil_nnn()
        if val == true then
          vim.api.nvim_buf_set_var(bufnr, 'nnn', false)
        elseif val == false then
          vim.api.nvim_buf_set_var(bufnr, 'nnn', true)
        end
      end,
      mode = '',
      desc = '[T]oggle [n]nn Mode',
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
        if require('oil.util').is_oil_bufnr(0) and require('fancyutil').get_oil_nnn() then
          local oil = require 'oil'
          local bufname = vim.api.nvim_buf_get_name(0)
          local parent = oil.get_buffer_parent_url(bufname, true)
          return oil.open(parent)
        end
        -- fallback to sending page up key
        local keys = vim.api.nvim_replace_termcodes('<Left>', true, false, true)
        vim.api.nvim_feedkeys(keys, 'n', false)
      end,
      mode = '',
      desc = 'Move up the file tree',
    },
    {
      '<Right>',
      function()
        local oil = require 'oil'
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
        if entry and dir and require('fancyutil').get_oil_nnn() then
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
      mode = '',
      desc = 'Move down the file tree',
    },
  },
  opts = {
    default_file_explorer = true,
    restore_window_options = true,

    win_options = {
      wrap = true,
      signcolumn = 'yes',
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
    -- group = aug,
    extensions = {
      'oil',
    },
  },
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)
  end,
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      desc = 'Detect buffer and setup oil nnn flag',
      -- group = aug,
      pattern = '*',
      nested = true,
      callback = function(params)
        local bufnr = params.buf
        local _, filetype = pcall(vim.api.nvim_get_option_value, 'filetype', { buf = bufnr })
        if filetype == 'oil' then
          local val = require('fancyutil').get_oil_nnn(bufnr)
          if val == nil then
            vim.api.nvim_buf_set_var(bufnr, 'nnn', true)
          end
        end
      end,
    })
  end,
}
