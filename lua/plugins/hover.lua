---@diagnostic disable: undefined-global
return {
  'lewis6991/hover.nvim',
  event = 'VeryLazy',
  config = function()
    require('hover').setup({
      init = function()
        -- Required for hover.nvim
        require('hover.providers.lsp')
        -- Optional additional providers
        require('hover.providers.gh')
        require('hover.providers.man')
        require('hover.providers.dictionary')
      end,
      preview_opts = {
        border = 'rounded',
        width = 80,
        height = 20,
      },
      title = true,
      -- Key mappings
      -- Use the same mapping as before ('K')
      mappings = {
        toggle_hover = 'K',
        -- Scroll option
        scroll_up = '<C-u>',
        scroll_down = '<C-d>',
      },
    })
    
    -- Style adjustments
    vim.api.nvim_set_hl(0, 'HoverFloat', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'HoverFloatBorder', { link = 'FloatBorder' })

    -- Override the LSP hover handler to ensure our hover.nvim is used
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        -- Clear and override the K mapping to ensure it uses hover.nvim
        vim.keymap.set('n', 'K', require('hover').hover, 
          { buffer = args.buf, desc = 'Enhanced documentation (hover.nvim)' })
      end,
    })
  end,
}
