local inspect = require('inspect')
require('ldraneyLua/sudoCheckSave')
require('hotkeys')
require('netrw/netrw')

--Global options
vim.opt.list = true
--vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

--require("indent_blankline").setup {
    --show_end_of_line = true,
    --space_char_blankline = " ",
--}

--turn off automatic comments for newlines with o
--https://www.reddit.com/r/neovim/comments/sqld76/stop_automatic_newline_continuation_of_comments/
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

--local function tmux_split_even_horizontal()
  --local filepath = vim.fn.expand('%:p')
  --if filepath ~= '' then
    --local tmux_command = "tmux split-window -h -c '" .. vim.fn.expand('%:p:h') .. "' && tmux send-keys -t '.tmux.active-pane' 'nvim " .. vim.fn.shellescape(filepath) .. "' Enter && tmux select-layout even-horizontal"
    --vim.fn.system(tmux_command)
  --end
--end

--vim.api.nvim_set_keymap('n', '<leader>th', ':lua tmux_split_even_horizontal()<CR>', { noremap = true, silent = true })


--_G.tmux_split_even_horizontal = function()
  --local filepath = vim.fn.expand('%:p')
  --if filepath ~= '' then
    --local tmux_command = "tmux split-window -h -c '" .. vim.fn.expand('%:p:h') .. "' && tmux send-keys -t '.tmux.active-pane' 'nvim " .. vim.fn.shellescape(filepath) .. "' Enter && tmux select-layout even-horizontal"
    --vim.fn.system(tmux_command)
  --end
--end

--_G.tmux_split_even_horizontal = function()
  --local filepath = vim.fn.expand('%:p')
  --if filepath ~= '' then
	--local tmux_command = "tmux split-window -h 'nvim'"
    --vim.fn.system(tmux_command)
	----print("Pane ID: " .. tmux_pane_id)
	--print("Filepath: " .. filepath)
  --end
--end

_G.tmux_split_even_horizontal = function()
  local filepath = vim.fn.expand('%:p')
  if filepath ~= '' then
    local tmux_command = "tmux split-window -h 'nvim -n " .. filepath .. "'; select-layout even-horizontal"
    vim.fn.system(tmux_command)
    print("Filepath: " .. filepath)
  end
end

vim.api.nvim_set_keymap('n', '<leader>th', ':lua _G.tmux_split_even_horizontal()<CR>', { noremap = true, silent = true })



--
--
--
--require('lspconfig').pyright.setup{}
--require('lspconfig').bashls.setup{}
--require'lspconfig'.pylsp.setup{}
---- Mappings.
---- See `:help vim.diagnostic.*` for documentation on any of the below functions
--local opts = { noremap=true, silent=true }
--vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

---- Use an on_attach function to only map the following keys
---- after the language server attaches to the current buffer
--local on_attach = function(client, bufnr)
  ---- Enable completion triggered by <c-x><c-o>
  --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  ---- Mappings.
  ---- See `:help vim.lsp.*` for documentation on any of the below functions
--vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--end

---- Use a loop to conveniently call 'setup' on multiple servers and
---- map buffer local keybindings when the language server attaches
--local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
--for _, lsp in pairs(servers) do
  --require('lspconfig')[lsp].setup {
    --on_attach = on_attach,
    --flags = {
      ---- This will be the default in neovim 0.7+
      --debounce_text_changes = 150,
    --}
  --}
--end
---- Add additional capabilities supported by nvim-cmp
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--local lspconfig = require('lspconfig')

---- Enable some language servers with the additional completion capabilities offered by nvim-cmp
--local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
--for _, lsp in ipairs(servers) do
  --lspconfig[lsp].setup {
    ---- on_attach = my_custom_on_attach,
    --capabilities = capabilities,
  --}
--end

---- luasnip setup
--local luasnip = require 'luasnip'

---- nvim-cmp setup
--local cmp = require 'cmp'
--cmp.setup {
  --snippet = {
    --expand = function(args)
      --require('luasnip').lsp_expand(args.body)
    --end,
  --},
  --mapping = {
    --['<C-p>'] = cmp.mapping.select_prev_item(),
    --['<C-n>'] = cmp.mapping.select_next_item(),
    --['<C-d>'] = cmp.mapping.scroll_docs(-4),
    --['<C-f>'] = cmp.mapping.scroll_docs(4),
    --['<C-Space>'] = cmp.mapping.complete(),
    --['<C-e>'] = cmp.mapping.close(),
    --['<CR>'] = cmp.mapping.confirm {
      --behavior = cmp.ConfirmBehavior.Replace,
      --select = true,
    --},
    --['<Tab>'] = function(fallback)
      --if cmp.visible() then
        --cmp.select_next_item()
      --elseif luasnip.expand_or_jumpable() then
        --luasnip.expand_or_jump()
      --else
        --fallback()
      --end
    --end,
    --['<S-Tab>'] = function(fallback)
      --if cmp.visible() then
        --cmp.select_prev_item()
      --elseif luasnip.jumpable(-1) then
        --luasnip.jump(-1)
      --else
        --fallback()
      --end
    --end,
  --},
  --sources = {
    --{ name = 'nvim_lsp' },
    --{ name = 'luasnip' },
  --},
--}

