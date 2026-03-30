-- Linting
---@module 'lazy'
---@type LazySpec
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        mdx = { 'markdownlint' },
        haskell = { 'hlint' },
        typ = { 'tinymist' },
      }
      local markdownlint = require 'lint.linters.markdownlint'
      markdownlint.args = {
        '--disable',
        'MD013', -- Line length
        'MD024', -- Multiple headers with the same content
        'MD025', -- Multiple top level headers in the same document
        'MD033', -- Inline HTML
        -- 'MD041', -- First line in file should be a top level header
      }

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- instead set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    --
    -- However, note that this will enable a set of default linters,
    -- which will cause errors unless these tools are available:
    -- {
    --   clojure = { "clj-kondo" },
    --   dockerfile = { "hadolint" },
    --   inko = { "inko" },
    --   janet = { "janet" },
    --   json = { "jsonlint" },
    --   markdown = { "vale" },
    --   rst = { "vale" },
    --   ruby = { "ruby" },
    --   terraform = { "tflint" },
    --   text = { "vale" }
    -- }
    --
    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft['text'] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then lint.try_lint() end
      end,
    })
  end,
}
