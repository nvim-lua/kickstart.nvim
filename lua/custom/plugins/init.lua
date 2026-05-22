-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
        },
      }
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'mbbill/undotree',
    config = function()
      local wk = require 'which-key'
      wk.add {
        {
          '<leader>u',
          desc = 'Show undotree',
          mode = 'n',
          buffer = true,
        },
      }
    end,
  },
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'pdflatex'
    end,
    config = function()
      local wk = require 'which-key'
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'tex' },
        callback = function()
          vim.keymap.set('n', '<Leader>m', 'i\\[<CR><CR>\\]<Esc>kA', { buffer = true })
          vim.keymap.set('n', '<Leader>p', 'i\\begin{pmatrix}<CR><CR>\\end{pmatrix}<Esc>kA', { buffer = true })
        end,
      })
      wk.add {
        {
          '<leader>m',
          desc = 'Insert display math block',
          mode = 'n',
          buffer = true,
        },
        {
          '<leader>p',
          desc = 'Insert pmatrix block',
          mode = 'n',
          buffer = true,
        },
      }
    end,
  },
}

-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end
