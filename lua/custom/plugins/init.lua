-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

vim.g.copilot_enabled = false -- Disable Copilot by default
vim.keymap.set('n', '<leader>cpd', ':Copilot disable<cr>', { silent = true, noremap = true }) -- Disable Copilot
vim.keymap.set('n', '<leader>cpe', ':Copilot enable<cr>', { silent = true, noremap = true }) -- Enable Copilot

vim.g.copilot_enabled = false

return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('diffview').setup {
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { 'git' }, -- The git executable followed by default args.
        use_icons = true, -- Requires nvim-web-devicons
        show_help_hints = true, -- Show hints for how to open the help panel
        watch_index = true, -- Update views and index on git index changes.
        icons = { -- Only applies when use_icons is true.
          folder_closed = '',
          folder_open = '',
        },
        signs = {
          fold_closed = '',
          fold_open = '',
          done = '✓',
        },
        view = {
          -- Configure the layout and behavior of different types of views.
          -- Available layouts:
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see ':h diffview-config-view.x.layout'.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = 'diff2_horizontal',
            winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = 'diff3_horizontal',
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
            winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
          },
        },
      }

      -- Diffview keymaps
      vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { desc = 'Open Diffview' })
      vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { desc = 'Close Diffview' })
      vim.keymap.set('n', '<leader>gm', ':DiffviewOpen HEAD~1<CR>', { desc = 'Compare with previous commit' })
      vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory<CR>', { desc = 'File history' })
      vim.keymap.set('n', '<leader>gH', ':DiffviewFileHistory %<CR>', { desc = 'Current file history' })

      -- For merge conflicts specifically
      vim.keymap.set('n', '<leader>gco', ':DiffviewOpen<CR>', { desc = 'Open merge conflict view' })
    end,
  },
  {
    'olrtg/nvim-emmet',
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
  -- {
  --   'nvimdev/indentmini.nvim',
  --   config = function()
  --     require('indentmini').setup()
  --   end,
  -- },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.icons' },
    opts = {},
    config = function()
      require('fzf-lua').setup {}

      local builtin = require 'fzf-lua'

      vim.keymap.set('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>/', builtin.lgrep_curbuf, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sG', function()
        builtin.live_grep {
          file_ignore_patterns = {
            '%.spec%.',
            '%.test%.',
          },
        }
      end, { desc = '[S]earch by [G]rep without Tests' })
    end,
  },
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = ':call mkdp#util#install()',
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    config = function()
      require('noice').setup {
        lsp = {
          signature = {
            enabled = false,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        sections = {
          lualine_x = {
            {
              require('noice').api.statusline.mode.get,
              cond = require('noice').api.statusline.mode.has,
              color = { fg = '#ff9e64' },
            },
          },
        },
      }
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },

  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    enabled = false,
    opts = {
      toggle_key = '<C-k>', -- toggle signature help on and off
    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = {
            adapter = 'copilot',
          },
          inline = {
            adapter = 'copilot',
          },
          agent = {
            adapter = 'copilot',
          },
        },
      }
    end,
  },
  {
    'github/copilot.vim',
    lazy = false,
    config = function() end,
  },
}
