return {
  {
    'github/copilot.vim',
    init = function()
      -- vim.g.copilot_enabled = false
      vim.keymap.set('i', '<M-;>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<M-/>', '<Plug>(copilot-dismiss)')
    end,
    --
  },
  --
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   build = ':Copilot auth',
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     --   filetypes = {
  --     --     markdown = true,
  --     --     help = true,
  --     --   },
  --   },
  -- },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
  --
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   branch = 'canary',
  --   dependencies = {
  --     { 'github/copilot.vim' }, -- or github/copilot.vim
  --     -- { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
  --     { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  --   },
  --   build = 'make tiktoken', -- Only on MacOS or Linux
  --   opts = {
  --     -- debug = true, -- Enable debugging
  --     -- See Configuration section for rest
  --     model = 'o1-preview', -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o', 'o1-mini', 'o1-preview'
  --     -- clear_chat_on_new_prompt = true,
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  --   --
  --   -- keys = {
  --   --   {
  --   --     '<leader>ccq',
  --   --     function()
  --   --       local input = vim.fn.input 'Quick Chat: '
  --   --       if input ~= '' then
  --   --         -- require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
  --   --         require('CopilotChat').ask(input)
  --   --       end
  --   --     end,
  --   --     desc = 'CopilotChat - Quick chat',
  --   --   },
  --   -- },
  --   keys = {
  --     -- { '<leader>ccq', '<cmd>CopilotChatOpen<cr>', mode = 'x', desc = 'CopilotChat' },
  --     { '<leader>ccq', ':CopilotChat ', mode = 'x', desc = 'CopilotChat' },
  --   },
  -- },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = 'copilot',
      -- auto_suggestions_provider = 'copilot',
      -- behaviour = {
      --   auto_suggestions = true, -- Experimental stage
      -- },
      copilot = {
        model = 'claude-3.5-sonnet',
        -- model = 'o1-preview',
        -- model = 'o1-preview-2024-09-12',
        -- max_tokens = 4096,
      },
      windows = {
        width = 44,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      -- 'zbirenbaum/copilot.lua', -- for providers='copilot'
      'github/copilot.vim',
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          -- file_types = { 'markdown', 'Avante' },
          file_types = { 'Avante' },
        },
        -- ft = { 'markdown', 'Avante' },
        ft = { 'Avante' },
      },
    },
  },
}
