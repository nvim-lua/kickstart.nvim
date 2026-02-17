return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        dockerfile = { 'hadolint' },
        yaml = { 'yamllint' },
        ['yaml.helm-values'] = { 'yamllint' },
      }
      lint.linters.markdownlint = vim.tbl_deep_extend('force', lint.linters.markdownlint or {}, {
        args = {
          '--stdin',
          '--disable',
          'MD013', -- line length
          'MD033', -- inline HTML
          'MD041', -- first line heading
        },
      })

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
          local function executable_cmd(cmd)
            if type(cmd) == 'function' then
              local ok, value = pcall(cmd)
              if not ok then
                return nil
              end
              return value
            end
            return cmd
          end

          local function available_linters_for(ft)
            local configured = lint.linters_by_ft[ft] or {}
            local available = {}

            for _, linter_name in ipairs(configured) do
              local linter = lint.linters[linter_name]
              local cmd = linter and executable_cmd(linter.cmd)
              if cmd == nil or cmd == '' or vim.fn.executable(cmd) == 1 then
                table.insert(available, linter_name)
              end
            end

            return available
          end

          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            local filetype = vim.bo.filetype
            local linters = available_linters_for(filetype)
            if #linters > 0 then
              lint.try_lint(linters)
            end
          end
        end,
      })
    end,
  },
}
