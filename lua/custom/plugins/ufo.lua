-- Better folds with preview, powered by treesitter/LSP fold providers
-- https://github.com/kevinhwang91/nvim-ufo

---@module 'lazy'
---@type LazySpec
return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'BufReadPost',

  -- ufo requires these options to be set *before* it loads, so they live here
  -- rather than in init.lua — that keeps everything fold-related in one file.
  -- See `:help ufo` and the "Minimal configuration" section of the README.
  init = function()
    -- Start with everything unfolded; ufo needs a large foldlevel to work.
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Show a fold column in the gutter. Set to '0' if you'd rather not spend
    -- the extra column (folds still work, you just lose the click targets).
    vim.o.foldcolumn = '1'

    -- NOTE: the README's recommended `fillchars` uses Nerd Font glyphs. This
    -- config sets `vim.g.have_nerd_font = false`, so use plain fallbacks unless
    -- you flip that flag in init.lua.
    vim.opt.fillchars:append(vim.g.have_nerd_font and {
      eob = ' ',
      fold = ' ',
      foldopen = '',
      foldsep = ' ',
      foldclose = '',
    } or {
      eob = ' ',
      fold = ' ',
      foldopen = '-',
      foldsep = ' ',
      foldclose = '+',
    })
  end,

  keys = {
    { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
    { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    { 'zr', function() require('ufo').openFoldsExceptKinds() end, desc = 'Open folds except kinds' },
    { 'zm', function() require('ufo').closeFoldsWith() end, desc = 'Close folds with level' },
    {
      'zK',
      function()
        -- Peek inside a closed fold; falls back to hover when not on a fold.
        if not require('ufo').peekFoldedLinesUnderCursor() then vim.lsp.buf.hover() end
      end,
      desc = 'Peek fold under cursor',
    },
  },

  ---@module 'ufo'
  opts = {
    -- Prefer treesitter fold queries, fall back to indent for filetypes
    -- without a folds.scm. ufo ships its own queries, so this works
    -- independently of the nvim-treesitter plugin.
    provider_selector = function(_, _, _) return { 'treesitter', 'indent' } end,

    -- Show how many lines a closed fold is hiding.
    fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
      local suffix = ('  ⋯ %d lines'):format(end_lnum - lnum)
      local target_width = width - vim.fn.strdisplaywidth(suffix)
      local cur_width = 0
      local result = {}

      for _, chunk in ipairs(virt_text) do
        local chunk_text = chunk[1]
        local chunk_width = vim.fn.strdisplaywidth(chunk_text)
        if target_width > cur_width + chunk_width then
          table.insert(result, chunk)
        else
          chunk_text = truncate(chunk_text, target_width - cur_width)
          table.insert(result, { chunk_text, chunk[2] })
          chunk_width = vim.fn.strdisplaywidth(chunk_text)
          -- Pad if truncation landed mid-character
          if cur_width + chunk_width < target_width then suffix = suffix .. (' '):rep(target_width - cur_width - chunk_width) end
          break
        end
        cur_width = cur_width + chunk_width
      end

      table.insert(result, { suffix, 'MoreMsg' })
      return result
    end,
  },
}
