return {
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    event = 'VeryLazy',
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      views = {
        split = {
          enter = true,
        },
        cmdline_popup = {
          border = {
            style = 'none',
            padding = { 2, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
        popupmenu = {
          border = {
            style = 'none',
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
          virtualtext = {
            hl_group = 'Search',
          },
        },
      },
      routes = {
        --        {
        --          filter = {
        --            event = 'msg_show',
        --            kind = 'search_count',
        --          },
        --          opts = {
        --            skip = true,
        --          },
        --        },
        {
          view = 'split',
          filter = {
            event = { 'msg_show', 'noice' },
            min_height = 20,
          },
        },
      },
      messages = {
        enabled = true,
        view = 'notify',
        view_error = 'notify',
        view_warn = 'notify',
        view_history = 'messages',
        view_search = 'virtualtext',
        opts = {},
      },
      notify = {
        enabled = true,
        view = 'mini',
      },
    },
  },
}
