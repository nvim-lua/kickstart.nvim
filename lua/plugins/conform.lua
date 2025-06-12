return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fo',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[Fo]rmat Buffer',
      },
      {
        '<leader>tf',
        function()
          vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
          vim.notify('Format on save: ' .. (vim.g.format_on_save_enabled and 'enabled' or 'disabled'))
        end,
        mode = '',
        desc = '[F]ormat on save',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if not vim.g.format_on_save_enabled then
          return false
        end

        local disable_filetypes = { c = true, cpp = true, sh = true, nix = true, md = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            async = false,
            timeout_ms = 3000,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end
      end,
      formatters_by_ft = {
        c = { 'clangd-format', 'cpplint' },
        cs = { 'ast-grep' }, -- c#
        css = { 'prettier' },
        cmake = { 'cmakelang' },
        cpp = { 'clangd-format', 'cpplint' },
        flow = { 'prettier' },
        go = { 'ast-grep', 'golangci-lint' }, -- gofumpt requires go
        html = { 'prettier' },
        h = { 'clangd-format', 'cpplint' },
        hpp = { 'clangd-format', 'cpplint' },
        java = { 'ast-grep' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        -- jinja = { 'djlint' },
        json = { 'prettier' },
        -- latex = { 'tex-fmt' },
        lua = { 'stylua' },
        -- php = { 'php-cs-fixer' },
        markdown = { 'prettier' },
        md = { 'prettier' },
        nix = { 'alejandra' },
        python = { 'isort', 'ruff_format' },
        -- r = { 'air' },
        sh = { 'shfmt' },
        -- tf = { 'terraform' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        yaml = { 'prettier' },
      },
    },
  },
}
