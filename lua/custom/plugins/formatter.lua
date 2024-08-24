-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'mhartington/formatter.nvim',
  config = function()
    local util = require 'formatter.util'

    require('formatter').setup {


      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        typescript = {
          function()
            return {
              exe = 'prettier',
              args = {
                '--stdin-filepath',
                util.escape_path(util.get_current_buffer_file_path()),
              },
              stdin = true,
              try_node_modules = true,
            }
          end,
        },

        javascript = {
          function()
            return {
              exe = 'prettier',
              args = {
                '--stdin-filepath',
                util.escape_path(util.get_current_buffer_file_path()),
              },
              stdin = true,
              try_node_modules = true,
            }
          end,
        },

        javascriptreact = {
          require('formatter.filetypes.javascriptreact').prettier,

          function()
            return {
              exe = 'prettier',
              args = {
                '--stdin-filepath',
                util.escape_path(util.get_current_buffer_file_path()),
              },
              stdin = true,
              try_node_modules = true,
            }
          end,
        },

        typescriptreact = {
          require('formatter.filetypes.typescriptreact').prettier,

          function()
            return {
              exe = 'prettier',
              args = {
                '--stdin-filepath',
                util.escape_path(util.get_current_buffer_file_path()),
              },
              stdin = true,
              try_node_modules = true,
            }
          end,
        },

        go = {
          require('formatter.filetypes.go').gofmt,
          require('formatter.filetypes.go').goimports,
        },

        astro = {
          function()
            return {
              exe = 'prettier',
              args = {
                '--stdin-filepath',
                util.escape_path(util.get_current_buffer_file_path()),
              },
              stdin = true,
              try_node_modules = true,
            }
          end,
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ['*'] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          require('formatter.filetypes.any').remove_trailing_whitespace,
        },
      },
    }
  end,
}
