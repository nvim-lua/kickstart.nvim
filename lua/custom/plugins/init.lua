-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    },
    config = function()
      local harpoon_ui = require 'harpoon.ui'
      local harpoon_mark = require 'harpoon.mark'

      -- Harpoon keybinds --
      -- Open harpoon ui
      vim.keymap.set('n', '<C-e>', function()
        harpoon_ui.toggle_quick_menu()
      end)

      -- Add current file to harpoon
      vim.keymap.set('n', '<leader>a', function()
        harpoon_mark.add_file()
      end)

      -- Quickly jump to harpooned files
      vim.keymap.set('n', '<leader>1', function()
        harpoon_ui.nav_file(1)
      end)

      vim.keymap.set('n', '<leader>2', function()
        harpoon_ui.nav_file(2)
      end)

      vim.keymap.set('n', '<leader>3', function()
        harpoon_ui.nav_file(3)
      end)

      vim.keymap.set('n', '<leader>4', function()
        harpoon_ui.nav_file(4)
      end)

      vim.keymap.set('n', '<leader>5', function()
        harpoon_ui.nav_file(5)
      end)
    end,
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<M-h>'] = 'actions.select_split',
        },
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, bufnr)
            return name == '..' or name == '.git'
          end,
        },
        win_options = {
          wrap = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<space>-', require('oil').toggle_float)
    end,
  },

  {
    'm4xshen/hardtime.nvim',
    dependecies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      restriction_mode = 'hint',
    },
    enabled = false,
  },

  {
    'echasnovski/mini.cursorword',
    version = false,
    lazy = true,
    event = 'CursorMoved',
    config = function()
      require('mini.cursorword').setup()
    end,
  },

  {
    'echasnovski/mini.indentscope',
    version = false,
    event = 'BufEnter',
    opts = {
      symbol = '│',
      options = { try_as_border = true },
      draw = {
        animation = function()
          return 0
        end,
      },
    },
    init = function()
      -- local macchiato = require('catppuccin.palettes').get_palette 'macchiato'
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'lazy',
          'mason',
          'notify',
          'oil',
          'Oil',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      -- vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = macchiato.mauve })
    end,
  },

  {
    'nvim-pack/nvim-spectre',
    lazy = true,
    cmd = { 'Spectre' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'catppuccin/nvim',
    },
    keys = {
      {
        '<leader>S',
        function()
          require('spectre').toggle()
        end,
        desc = 'Toggle Spectre',
      },
      {
        '<leader>SW',
        function()
          require('spectre').open_visual { select_word = true }
        end,
        mode = 'n',
        desc = 'Search current word',
      },
      {
        '<leader>SW',
        function()
          require('spectre').open_visual()
        end,
        mode = 'v',
        desc = 'Search current word',
      },
      {
        '<leader>SP',
        function()
          require('spectre').open_file_search { select_word = true }
        end,
        desc = 'Search on current file',
      },
    },
    config = function()
      local theme = require('catppuccin.palettes').get_palette 'macchiato'
      vim.api.nvim_set_hl(0, 'SpectreSearch', { bg = theme.red, fg = theme.base })
      vim.api.nvim_set_hl(0, 'SpectreReplace', { bg = theme.green, fg = theme.base })
      require('spectre').setup {
        highlight = {
          search = 'SpectreSearch',
          replace = 'SpectreReplace',
        },
        mapping = {
          ['send_to_qf'] = {
            map = '<C-q>',
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = 'send all items to quickfix',
          },
        },
        replace_engine = {
          sed = {
            cmd = 'sed',
            args = {
              '-i',
              '',
              '-E',
            },
          },
        },
      }
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
    },
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
      end

      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = require("mini.files").get_explorer_state().target_window
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require("mini.files").set_target_window(new_target_window)
            require("mini.files").go_in({ close_on_file = close_on_file })
          end
        end

        local desc = "Open in " .. direction .. " split"
        if close_on_file then
          desc = desc .. " and close"
        end
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      local files_set_cwd = function()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        if cur_directory ~= nil then
          vim.fn.chdir(cur_directory)
        end
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.toggle_hidden or "g.",
            toggle_dotfiles,
            { buffer = buf_id, desc = "Toggle hidden files" }
          )

          vim.keymap.set(
            "n",
            opts.mappings and opts.mappings.change_cwd or "gc",
            files_set_cwd,
            { buffer = args.data.buf_id, desc = "Set cwd" }
          )

          map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
          map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
          map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S", "horizontal", true)
          map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
  }
}
