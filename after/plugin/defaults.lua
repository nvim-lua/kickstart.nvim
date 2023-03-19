-- prev/next tab
vim.keymap.set('n', 'H', 'gT')
vim.keymap.set('n', 'L', 'gt')

-- line bubbling

-- nnoremap <C-j> :m .+1<CR>==
-- nnoremap <C-k> :m .-2<CR>==
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { noremap = true }) -- conflicts with "signature help" from LSP

-- inoremap <C-j> <ESC>:m .+1<CR>==gi
-- inoremap <C-k> <ESC>:m .-2<CR>==gi
vim.keymap.set('i', '<C-j>', '<ESC>:m .+1<CR>==gi', { noremap = true })
vim.keymap.set('i', '<C-k>', '<ESC>:m .-2<CR>==gi', { noremap = true })

-- vnoremap <C-j> :m '>+1<CR>gv=gv
-- vnoremap <C-k> :m '<-2<CR>gv=gv
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true })

vim.o.inccommand = "nosplit"

-- vim.cmd([[
--   autocmd FileType dirvish nmap <buffer> <c-o> -
-- ]])

vim.diagnostic.config({
  virtual_text = {
    -- source = "always",  -- Or "if_many"
    prefix = '●', -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


local signs = { Error = "✗", Warn = "⚠", Hint = "➤", Info = "i" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--   bufnr = bufnr or 0
--   line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--   opts = opts or { ['lnum'] = line_nr }
--
--   local line_diagnostics = vim.diagnostic.get(bufnr, opts)
--   if vim.tbl_isempty(line_diagnostics) then return end
--
--   local diagnostic_message = ""
--   for i, diagnostic in ipairs(line_diagnostics) do
--     diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--     print(diagnostic_message)
--     if i ~= #line_diagnostics then
--       diagnostic_message = diagnostic_message .. "\n"
--     end
--   end
--   vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
-- end
--
-- vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]

-- vim: ts=2 sts=2 sw=2 et
