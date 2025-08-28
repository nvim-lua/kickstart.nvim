-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { "sindrets/diffview.nvim" },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end
  },
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Optional, for markdown rendering with render-markdown.nvim
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown" },
        },
        ft = { "markdown" },
      },
    },
    ft = "hurl",
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = "split",
      -- Default formatter
      formatters = {
        json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          'prettier',    -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          '--parser',
          'html',
        },
        xml = {
          'tidy', -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
          '-xml',
          '-i',
          '-q',
        },
      },
      -- Default mappings for the response popup or split views
      mappings = {
        close = 'q',          -- Close the response popup or split view
        next_panel = '<C-n>', -- Move to the next response popup window
        prev_panel = '<C-p>', -- Move to the previous response popup window
      },
    },
    keys = {
      -- Run API request
      { "<leader>A",  "<cmd>HurlRunner<CR>",        desc = "Run All requests" },
      { "<leader>a",  "<cmd>HurlRunnerAt<CR>",      desc = "Run Api request" },
      { "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
      { "<leader>tE", "<cmd>HurlRunnerToEnd<CR>",   desc = "Run Api request from current entry to end" },
      { "<leader>tm", "<cmd>HurlToggleMode<CR>",    desc = "Hurl Toggle Mode" },
      { "<leader>tv", "<cmd>HurlVerbose<CR>",       desc = "Run Api in verbose mode" },
      { "<leader>tV", "<cmd>HurlVeryVerbose<CR>",   desc = "Run Api in very verbose mode" },
      -- Run Hurl request in visual mode
      { "<leader>h",  ":HurlRunner<CR>",            desc = "Hurl Runner",                              mode = "v" },
    },
  },
  {
    'AndrewRadev/tagalong.vim',
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true,           -- Auto close tags
          enable_rename = true,          -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = false,
          },
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local conform = require('conform')

      conform.setup({
        formatters_by_ft = {
          lua = { 'stylelua' },
          python = { 'black', 'flake8' },
          typescript = { 'biome', 'prettier' },
          typescriptreact = { 'biome', 'prettier' },
          javascript = { 'biome', 'prettier' },
          javascriptreact = { 'biome', 'prettier' },
          json = { 'biome', 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          css = { 'biome', 'prettier' },
          scss = { 'prettier' },
          html = { 'prettier' },
        },
        formatters = {
          prettier = {
            -- Use the project's prettier config by looking for it in parent directories
            cwd = require('conform.util').root_file({
              'package.json',
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.js',
              '.prettierrc.mjs',
              'prettier.config.js',
              'prettier.config.mjs',
            }),
            require_cwd = true,
          },
          biome = {
            -- Use the project's biome config by looking for it in parent directories
            cwd = require('conform.util').root_file({
              'biome.json',
              'biome.jsonc',
              'package.json',
            }),
            require_cwd = true,
          },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 1500,
        }
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>l', function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = 'Format file or range (in visual mode)' })
    end,
  },
}
