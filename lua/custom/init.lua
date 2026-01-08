-- Minimal OCaml behavior: ocp-indent for typing, ocamlformat via ocamllsp on save.
-- 1) Disable ancient builtin ocaml indent script (we will use ocp-indent)
-- 4) Format-on-save: use only ocamllsp to format the buffer before write.
--    Keeps formatting deterministic and avoids other formatters stepping in.
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ml', '*.mli' },
  callback = function()
    if vim.bo.filetype == 'ocaml' then
      vim.lsp.buf.format {
        async = false,
        filter = function(client)
          return client.name == 'ocamllsp'
        end,
      }
    end
  end,
})
