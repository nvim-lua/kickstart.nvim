-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup()

      -- Optional: Set up keymaps for common conflict resolution commands
      vim.keymap.set('n', '<leader>co', '<cmd>GitConflictChooseOurs<CR>', { desc = '[GIT] Choose Ours' })
      vim.keymap.set('n', '<leader>ct', '<cmd>GitConflictChooseTheirs<CR>', { desc = '[GIT] Choose Theirs' })
      vim.keymap.set('n', '<leader>cb', '<cmd>GitConflictChooseBoth<CR>', { desc = '[GIT] Choose Both' })
      vim.keymap.set('n', '<leader>c0', '<cmd>GitConflictChooseNone<CR>', { desc = '[GIT] Choose None' })
      vim.keymap.set('n', ']x', '<cmd>GitConflictNextConflict<CR>', { desc = '[GIT] Next Conflict' })
      vim.keymap.set('n', '[x', '<cmd>GitConflictPrevConflict<CR>', { desc = '[GIT] Prev Conflict' })
    end,
  },
  {

    'sphamba/smear-cursor.nvim',
    event = 'VeryLazy',
    config = function()
      require('smear_cursor').setup {
        cursor_color = '#ff8800',
        stiffness = 1,
        trailing_stiffness = 0.35,
        trailing_exponent = 25,
        hide_target_hack = true,
        gamma = 1,
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        direction = 'float',
        float_opts = {
          border = 'curved',
          width = 100,
          height = 30,
          winblend = 0,
        },
        open_mapping = [[<C-\>]],
        start_in_insert = true,
      }
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        transparent = true,
      }
      vim.cmd 'colorscheme tokyonight'
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function()
      require('toggleterm').setup()
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require 'dap'
      local dap_python = require 'dap-python'
      local dapui = require 'dapui'

      local debugpy_path = vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python'
      dap_python.setup(debugpy_path)

      dap.configurations.python = dap.configurations.python or {}
      -- Ta-yoong project debug config
      table.insert(dap.configurations.python, {
        name = 'Odoo Tayoong',
        type = 'python',
        request = 'launch',
        program = '/Users/quandoan/Desktop/odoo-18.0/odoo-bin',
        args = {
          '-c',
          '/Users/quandoan/Desktop/odoo-18.0/debian/odoo-tayoong.conf',
          '-u',
          'a1_einvoice_to_gov',
          '--xmlrpc-port',
          '8066',
        },
        pythonPath = function()
          return '/usr/local/bin/python3.12'
        end,
        cwd = vim.fn.getcwd(),
        env = { PYTHONUNBUFFERED = '1' },
        console = 'integratedTerminal',
      })
      -- odoo 13 debug
      table.insert(dap.configurations.python, {
        name = 'Odoo 13',
        type = 'python',
        request = 'launch',
        program = '/Users/quandoan/Desktop/odoo-13.0/odoo-bin',
        args = {
          '-c',
          '/Users/quandoan/Desktop/odoo-13.0/debian/odoo.conf',
          '-u',
          'a1_einvoice_to_gov',
          '--xmlrpc-port',
          '8066',
        },
        pythonPath = function()
          return '/usr/local/bin/python3.7'
        end,
        cwd = vim.fn.getcwd(),
        env = { PYTHONUNBUFFERED = '1' },
        console = 'integratedTerminal',
      })

      -- UI signs
      vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition', { text = 'C', texthl = 'DapBreakpointCondition' })
      vim.fn.sign_define('DapStopped', { text = '>', texthl = 'DapStopped', linehl = 'CursorLine' })

      vim.cmd [[
        highlight DapBreakpoint guifg=#FFA500 guibg=#1F1F28
        highlight DapBreakpointCondition guifg=#FFA500 guibg=#1F1F28
        highlight DapStopped guifg=#FFA500 guibg=#1F1F28
      ]]

      dapui.setup {
        layouts = {
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 0.15,
            position = 'left',
          },
          {
            elements = {
              { id = 'scopes', size = 1.0 },
            },
            size = 0.85,
            position = 'bottom',
          },
        },
      }
    end,
  },
  {
    -- Ensure toggleterm is loaded
    'akinsho/toggleterm.nvim',
    keys = {
      {
        '<leader>lg',
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit = Terminal:new {
            cmd = 'lazygit',
            direction = 'float',
            hidden = true,
          }
          lazygit:toggle()
        end,
        desc = 'Lazygit (float)',
      },
    },
  },
}
