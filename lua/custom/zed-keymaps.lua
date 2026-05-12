-- Mirrors common Zed bindings for muscle-memory continuity.
-- Source from init.lua: require('custom.zed-keymaps').

-- Move lines (Zed: alt-j / alt-k).
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==',     { desc = 'Move line down',      silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==',     { desc = 'Move line up',        silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up',   silent = true })

-- Lowercase gi for implementation (Zed: g i; existing gI still works).
vim.keymap.set('n', 'gi', function()
  require('telescope.builtin').lsp_implementations()
end, { desc = '[G]oto [I]mplementation' })

-- Zed-parity: F2 to rename, <leader>. for code action (mirrors cmd-.),
-- <leader>fc for command palette.
vim.keymap.set('n', '<F2>',      vim.lsp.buf.rename,                                              { desc = 'LSP rename' })
vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action,                                         { desc = 'Code action' })
vim.keymap.set('n', '<leader>fc', function() require('telescope.builtin').commands() end,        { desc = '[F]ind [C]ommand' })

-- Full-buffer git blame (Zed: g b).
vim.keymap.set('n', 'gb', function()
  require('gitsigns').blame()
end, { desc = '[G]it [B]lame buffer' })

-- Close current buffer (Zed: space x).
vim.keymap.set('n', '<leader>x', '<cmd>bd<cr>', { desc = 'Close buffer' })

-- Workspace symbols (Zed: space f e).
vim.keymap.set('n', '<leader>fe', function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols()
end, { desc = '[F]ind workspace symbols' })

-- Task spawner: floating zellij pane when in zellij, fallback to nvim split term.
local function task(cmd)
  return function()
    if vim.env.ZELLIJ ~= nil and vim.env.ZELLIJ ~= '' then
      vim.fn.jobstart({
        'zellij', 'action', 'new-pane', '--floating',
        '--close-on-exit', '--', '/bin/zsh', '-lc', cmd,
      }, { detach = true })
    else
      vim.cmd('botright 15split | terminal ' .. cmd)
      vim.cmd('startinsert')
    end
  end
end

-- Task bindings (mirror Zed's tasks.json).
vim.keymap.set('n', '<leader>gh', task('gh dash'),                                 { desc = '[G]itHub das[H]board' })
vim.keymap.set('n', '<leader>kk', task('k9s'),                                     { desc = '[K]9s' })
vim.keymap.set('n', '<leader>bb', task('cd bruno && bru run --env Local --insecure --tests-only'), { desc = '[B]runo tests' })
vim.keymap.set('n', '<leader>uu', task('cd restopay && make up'),                  { desc = 'Make [U]p' })
vim.keymap.set('n', '<leader>dd', task('cd restopay && make down'),                { desc = 'Make Do[w]n' })
vim.keymap.set('n', '<leader>aa', task(
  'hv athenz user-cert --system=public && awscreds -d vespa.external.factory -r admin -p external-factory -z public'
), { desc = 'Update certs for External-Factory' })
