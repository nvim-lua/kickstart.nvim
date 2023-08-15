local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

local function applyFoldsAndThenCloseAllFolds(bufnr, providerName)
  require('async')(function()
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    -- make sure buffer is attached
    require('ufo').attach(bufnr)
    -- getFolds return Promise if providerName == 'lsp'
    local ranges = await(require('ufo').getFolds(bufnr, providerName))
    local ok = require('ufo').applyFolds(bufnr, ranges)
    if ok then
      require('ufo').closeFoldsWith(1)
    end
  end)
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          segments = {
            { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
            { text = { "%s" },                  click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
        })
      end,
    },
  },
  event = "BufReadPost",
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  },
  init = function()
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn = '1'
    vim.o.foldnestmax = 1
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 1
    vim.o.foldenable = true
  end,
  config = function(_, opts)
    local newOpts = {
      fold_virt_text_handler = handler
    }

    for k, v in pairs(newOpts) do opts[k] = v end

    require("ufo").setup(newOpts)

    vim.api.nvim_create_autocmd('BufRead', {
      pattern = '*',
      callback = function(e)
        applyFoldsAndThenCloseAllFolds(e.buf, 'lsp')
      end
    })
  end,
}
