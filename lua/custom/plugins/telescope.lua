-- Telescope override configuration

return {
  {
    'nvim-telescope/telescope.nvim',
    -- Ensure dependencies are loaded (lazy.nvim usually handles this if defined elsewhere)
    -- Listing them here ensures they are available if Telescope is the first plugin requiring them.
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- Conditionally enable based on options
    },
    opts = { -- Use opts to merge/override defaults
      pickers = {
        find_files = {
          -- Use rg for finding files (ensure rg is installed via Nix/Home Manager)
          find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
        },
      },
      -- Ensure extensions are configured if kickstart doesn't handle it via opts
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        -- Configuration for fzf-native extension
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    },
    -- The config function ensures extensions are loaded after setup
    config = function(_, opts)
      require('telescope').setup(opts)
      -- Load extensions after setup
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  },
}
