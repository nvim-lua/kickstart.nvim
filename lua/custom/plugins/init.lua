-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local function do_custom_commit(prefix)
  local ok, _ = pcall(vim.cmd, 'G commit -a')
  if ok then
    local branch = vim.fn.system "git branch --show-current | tr -d '\n'"
    local ticket = branch:match '([A-Z]+%-%d+)'
    vim.cmd 'startinsert'
    if not ticket then
      vim.api.nvim_put({ string.format('%s: ', prefix) }, 'c', true, true)
      return
    end
    if prefix == '' then
      vim.api.nvim_put({ string.format('%s: ', ticket) }, 'c', true, true)
      return
    end
    vim.api.nvim_put({ string.format('%s(%s): ', prefix, ticket) }, 'c', true, true)
  end
end

return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      -- there were come ctrl+hjkl stuff here but i don't think i need it, use alt+arrows
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              -- You can also use captures from other query groups like `locals.scm`
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = 'V', -- <c-v> for blockwise but i changed it
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = false,
          },
        },
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        update_focused_file = {
          enable = true,
        },
      }
      vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle\n', { desc = '[T]oggle NVim[T]ree' })
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    ft = { 'python' },
    opts = function()
      local null_ls = require 'null-ls'
      return {
        sources = {
          null_ls.builtins.diagnostics.mypy.with {
            extra_args = function()
              local virtual = os.getenv 'VIRTUAL_ENV' or os.getenv 'CONDA_PREFIX' or '/usr'
              return { '--python-executable', virtual .. '/bin/python3' }
            end,
          },
          null_ls.builtins.formatting.isort.with { prefer_local = true },
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = '[D]ebug [B]reakpoint' })
      vim.keymap.set('n', '<F5>', function()
        require('dap').continue()
      end, { desc = 'Step Over' })
      vim.keymap.set('n', '<F6>', function()
        require('dap').step_over()
      end, { desc = 'Step Over' })
      vim.keymap.set('n', '<F7>', function()
        require('dap').step_into()
      end, { desc = 'Step Into' })
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(path)
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            pytest_discover_instances = true,
          },
        },
      }
      vim.keymap.set('n', '<leader>tn', function()
        require('neotest').run.run()
      end, { desc = '[T]ests: Run [N]earest' })
      vim.keymap.set('n', '<leader>tdn', function()
        require('neotest').run.run { strategy = 'dap' }
      end, { desc = '[T]ests: [D]ebug [N]earest' })
      vim.keymap.set('n', '<leader>tf', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = '[T]ests: Run all tests in [F]ile' })
      vim.keymap.set('n', '<leader>to', function()
        require('neotest').output.open { enter = true }
      end, { desc = '[T]ests: Open [O]utput Window' })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.before.attach.dapui_config = function()
        dapui.setup()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.setup()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'folke/neodev.nvim',
    opts = {},
    config = function()
      require('neodev').setup {
        library = { plugins = { 'nvim-dap-ui' }, types = true },
      }
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gb', '<Cmd>Telescope git_branches<CR>', { desc = '[G]it [B]ranches' })
      vim.keymap.set('n', '<leader>gs', '<Cmd>Git<CR>', { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gcf', function()
        do_custom_commit 'feat'
      end, { desc = '[G]it [C]ommit [F]eat' })
      vim.keymap.set('n', '<leader>gcc', function()
        do_custom_commit 'chore'
      end, { desc = '[G]it [C]ommit [C]hore' })
      vim.keymap.set('n', '<leader>gcr', function()
        do_custom_commit 'refactor'
      end, { desc = '[G]it [C]ommit [R]efactor' })
      vim.keymap.set('n', '<leader>gce', '<Cmd>Git commit -a<CR>', { desc = '[G]it [C]ommit [E]mpty' })

      vim.keymap.set('n', '<leader>gp', '<Cmd>Git push<CR>', { desc = '[G]it [P]ush' })
      vim.keymap.set('n', '<leader>gf', '<Cmd>Git pull<CR>', { desc = '[G]it [F]pull' })
      vim.keymap.set('n', '<leader>gd', '<Cmd>Git diff<CR>', { desc = '[G]it [D]iff' })
      vim.keymap.set('n', '<leader>gl', '<Cmd>Git log<CR>', { desc = '[G]it [L]og' })
      vim.keymap.set('n', '<leader>gw', '<Cmd>Git blame<CR>', { desc = '[G]it [W]hodunit (Blame)' })
    end,
  },
  {
    'LunarVim/breadcrumbs.nvim',
    dependencies = {
      { 'SmiteshP/nvim-navic' },
    },
    config = function()
      require('nvim-navic').setup { lsp = { auto_attach = true, preference = { 'pyright' } } }
      require('breadcrumbs').setup()
    end,
  },
  {
    'github/copilot.vim',
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        config = {
          header = {
            '⠀⢀⣴⣦⠀⠀⠀⠀⢰⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
            '⣰⣿⣿⣿⣷⡀⠀⠀⢸⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
            '⣿⣿⣿⣿⣿⣿⣄⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
            '⣿⣿⣿⠈⢿⣿⣿⣦⢸⣿⣿⡇⠀⣠⠴⠒⠢⣄⠀⠀⣠⠴⠲⠦⣄⠐⣶⣆⠀⠀⢀⣶⡖⢰⣶⠀⢰⣶⣴⡶⣶⣆⣴⡶⣶⣶⡄',
            '⣿⣿⣿⠀⠀⠻⣿⣿⣿⣿⣿⡇⢸⣁⣀⣀⣀⣘⡆⣼⠁⠀⠀⠀⠘⡇⠹⣿⡄⠀⣼⡿⠀⢸⣿⠀⢸⣿⠁⠀⢸⣿⡏⠀⠀⣿⣿',
            '⠹⣿⣿⠀⠀⠀⠙⣿⣿⣿⡿⠃⢸⡀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢀⡏⠀⢻⣿⣸⣿⠁⠀⢸⣿⠀⢸⣿⠀⠀⢸⣿⡇⠀⠀⣿⣿',
            '⠀⠈⠻⠀⠀⠀⠀⠈⠿⠋⠀⠀⠈⠳⢤⣀⣠⠴⠀⠈⠧⣄⣀⡠⠞⠁⠀⠀⠿⠿⠃⠀⠀⢸⣿⠀⢸⣿⠀⠀⠸⣿⡇⠀⠀⣿⡿',
          },
          shortcut = {},
          project = { enable = false },
          mru = { cwd_only = true },
          footer = {
            ' ',
            ' 👾 github.com/feakuru 👾 ',
          },
        },
        hide = { statusline = false, tabline = false, winbar = false },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  {
    'ThePrimeagen/vim-be-good',
  },
}
