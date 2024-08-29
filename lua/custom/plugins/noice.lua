return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      lsp = {
        -- need to disable this because of `lsp-signature`
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
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
    local search = vim.api.nvim_get_hl(0, { name = 'Search' })
    vim.api.nvim_set_hl(0, 'TransparentSearch', { fg = search.foreground })

    local help = vim.api.nvim_get_hl(0, { name = 'IncSearch' })
    vim.api.nvim_set_hl(0, 'TransparentHelp', { fg = help.foreground })

    local cmdGroup = 'DevIconLua'
    local noice_cmd_types = {
      CmdLine = cmdGroup,
      Input = cmdGroup,
      Lua = cmdGroup,
      Filter = cmdGroup,
      Rename = cmdGroup,
      Substitute = 'Define',
      Help = 'TransparentHelp',
      Search = 'TransparentSearch',
    }

    for type, hl in pairs(noice_cmd_types) do
      vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder' .. type, { link = hl })
      vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon' .. type, { link = hl })
    end
    vim.api.nvim_set_hl(0, 'NoiceConfirmBorder', { link = cmdGroup })
  end,
}
