-- Makes folding look modern and keep high performance
return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.opt.foldlevelstart = 99

    -- treesitter as a main provider instead
    -- (Note: the `nvim-treesitter` plugin is *not* needed.)
    -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
    -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
    require('ufo').setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }
  end,
}
