---@diagnostic disable: undefined-global
return {
  'RRethy/vim-illuminate',
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" }
    },
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    min_count_to_highlight = 2, -- minimum number of matches required to perform highlighting
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
    
    -- Set highlight style (using colors that match with gruvbox theme)
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = '#3c3836', bold = true })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = '#3c3836', bold = true })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = '#3c3836', bold = true })
    
    -- Map keys to navigate between highlighted words
    vim.keymap.set('n', '<leader>hn', function()
      require('illuminate').goto_next_reference()
    end, { desc = 'Go to next reference' })
    
    vim.keymap.set('n', '<leader>hp', function()
      require('illuminate').goto_prev_reference()
    end, { desc = 'Go to previous reference' })
  end,
}
