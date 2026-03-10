-- [[ Global Configs ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Configs for Programming Languages
-- like LSPs, Tree-sitters, Linters, Fromatters, Debuggers, etc.
Langs = {
  lsp = {
    'bashls',
    'clangd',
    'elmls',
    'gopls',
    'harper_ls',
    'html',
    'intelephense',
    'just',
    'laravel_ls',
    'lua_ls',
    'markdown_oxide',
    'marksman',
    'omnisharp',
    'phpactor',
    'pyrefly',
    'roslyn_ls',
    'stylua',
    'superhtml',
    'svelte',
    'tailwindcss',
    'ts_ls',
    'zls',
    -- 'fsautocomplete',
  },

  treesitter = {
    'bash',
    'c',
    'c_sharp',
    'css',
    'diff',
    'go',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'php',
    'python',
    'query',
    'vim',
    'vimdoc',
    'zig',
  },

  linter = {
    markdown = { 'mado' }, -- or rumdl
    python = { 'ruff' },
  },

  fmt = {
    lua = { 'stylua' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    python = { 'ruff_format' },
    blade = { 'blade-formatter' },
    markdown = { 'mdformat' },
  },

  fmt_cmd = {
    shfmt = {
      prepend_args = { '-i', '4' },
      -- The base args are { "-filename", "$FILENAME" } so the final args will be
      -- { "-filename", "$FILENAME", "-i", "2" }
    },
    ['blade-formatter'] = {
      prepend_args = { '-i', '2' },
    },
  },
}
