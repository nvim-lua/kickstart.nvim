-- UI plugins
return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        -- Groups
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>W', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },

        -- General keybinds
        { '<leader>w', desc = 'Save File' },
        { '<leader>pv', desc = 'Go back to Dir' },
        { '<leader>q', desc = 'Open diagnostic quickfix list' },
        { '<leader>f', desc = 'Format buffer', mode = { 'n', 'v' } },

        -- LSP keybinds
        { '<leader>D', desc = 'Type Definition' },
        { '<leader>ds', desc = 'Document Symbols' },
        { '<leader>ws', desc = 'Workspace Symbols' },
        { '<leader>rn', desc = 'Rename' },
        { '<leader>ca', desc = 'Code Action', mode = { 'n', 'v' } },
        { '<leader>th', desc = 'Toggle Inlay Hints' },

        -- Harpoon keybinds
        { '<leader>A', desc = 'Add file to harpoon' },
        { '<leader>a', desc = 'Open harpoon nav' },
        { '<leader>1', desc = 'Go to file 1' },
        { '<leader>2', desc = 'Go to file 2' },
        { '<leader>3', desc = 'Go to file 3' },
        { '<leader>4', desc = 'Go to file 4' },
        { '<leader>5', desc = 'Go to file 5' },
        { '<leader>z', desc = 'Open harpoon in telescope' },

        -- Telescope search keybinds
        { '<leader>sh', desc = 'Search Help' },
        { '<leader>sk', desc = 'Search Keymaps' },
        { '<leader>sf', desc = 'Search Files' },
        { '<leader>ss', desc = 'Search Select Telescope' },
        { '<leader>sw', desc = 'Search current Word' },
        { '<leader>sg', desc = 'Search by Grep' },
        { '<leader>sd', desc = 'Search Diagnostics' },
        { '<leader>sr', desc = 'Search Resume' },
        { '<leader>s.', desc = 'Search Recent Files' },
        { '<leader><leader>', desc = 'Find existing buffers' },
        { '<leader>/', desc = 'Fuzzily search in current buffer' },
        { '<leader>s/', desc = 'Search in Open Files' },
        { '<leader>sn', desc = 'Search Neovim files' },

        -- Debug keybinds
        { '<leader>b', desc = 'Debug: Toggle Breakpoint' },
        { '<leader>B', desc = 'Debug: Set Breakpoint' },

        -- Git hunk actions
        { '<leader>hs', desc = 'Stage hunk', mode = { 'n', 'v' } },
        { '<leader>hr', desc = 'Reset hunk', mode = { 'n', 'v' } },
        { '<leader>hS', desc = 'Stage buffer' },
        { '<leader>hu', desc = 'Undo stage hunk' },
        { '<leader>hR', desc = 'Reset buffer' },
        { '<leader>hp', desc = 'Preview hunk' },
        { '<leader>hb', desc = 'Blame line' },
        { '<leader>hd', desc = 'Diff against index' },
        { '<leader>hD', desc = 'Diff against last commit' },

        -- Git toggles
        { '<leader>tb', desc = 'Toggle git show blame line' },
        { '<leader>tD', desc = 'Toggle git show deleted' },

        -- Function keys
        { '<F1>', desc = 'Debug: Step Into' },
        { '<F2>', desc = 'Debug: Step Over' },
        { '<F3>', desc = 'Debug: Step Out' },
        { '<F5>', desc = 'Debug: Start/Continue' },
        { '<F7>', desc = 'Debug: See last session result' },

        -- Other important keybinds
        { '\\', desc = 'NeoTree reveal' },
        { 'gd', desc = 'Go to Definition' },
        { 'gr', desc = 'Go to References' },
        { 'gI', desc = 'Go to Implementation' },
        { 'gD', desc = 'Go to Declaration' },
        { ']c', desc = 'Next git change' },
        { '[c', desc = 'Previous git change' },
      },
    },
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPost',
    config = function()
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#0a0a0a' })
      vim.api.nvim_set_hl(0, 'IblScope', { fg = '#0e0e0e' })
      require('ibl').setup({
        indent = {
          char = '│',
          highlight = 'IblIndent',
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = 'IblScope',
        },
      })
    end,
  },
}