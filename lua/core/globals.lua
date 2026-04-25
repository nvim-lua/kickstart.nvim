-- [[ Global Configs ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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
    -- lua = { 'stylua' }, -- see [Use stylua as an lsp formatter instead of an external formatter · nvim-lua/kickstart.nvim@459b868](https://github.com/nvim-lua/kickstart.nvim/commit/459b86865e9e81235c9db3be553d107adac5f72f)
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

-- My set of defined icons, I still don't know if its inclusive or not.
-- I named it Glyphs to avoid misinterpreting it with something else.
Glyphs = {
  ui = {
    prompt = '',
  },
  lazy = {
    cmd = ' ',
    config = '',
    debug = '● ',
    event = ' ',
    favorite = ' ',
    ft = ' ',
    init = ' ',
    import = ' ',
    keys = ' ',
    lazy = '󰒲 ',
    loaded = '●',
    not_loaded = '○',
    plugin = ' ',
    runtime = ' ',
    require = ' ',
    source = ' ',
    start = ' ',
    task = ' ',
    list = { '●', '○', '◆', '◇' },
  },
  snacksPicker = {
    lsp = {
      unavailable = '',
      enabled = '',
      disabled = '',
      attached = '',
    },
  },
  diagnostics = {
    error = '',
    warn = '',
    hint = '',
    info = '',
  },
  dev_kit = {
    lsp = '',
    fmt = '󰉿',
    lint = '',
  },
  file_status = {
    modified = '󰏫',
    unmodifiable = '󰏯',
    readOnly = '󰌾',
    preview = '󰈈',
  },
  kinds = {
    -- taken from:
    --     - [Completion.Kind (LSP APIs)](https://bits.netbeans.org/29/javadoc/org-netbeans-api-lsp/org/netbeans/api/lsp/Completion.Kind.html)
    --     - [StructureElement.Kind (LSP APIs)](https://bits.netbeans.org/29/javadoc/org-netbeans-api-lsp/org/netbeans/api/lsp/StructureElement.Kind.html)
    Array = '',
    Boolean = '',
    Class = '󰒕',
    Color = '󰏘',
    Constant = '󰏿',
    Constructor = '󱌣',
    Copilot = '', -- for AI indication
    Enum = '', -- or   
    EnumMember = '', -- or   
    Event = '',
    Field = '󰿨',
    File = '󰈙',
    Folder = '󰉋',
    Function = '󰊕',
    Interface = '󰩦', -- or 󱖡
    Key = '',
    Keyword = '',
    Method = 'ɱ', -- or ꬺ, I can't decide
    Module = '󰅩',
    Namespace = '󰦮',
    Null = '∅',
    Number = '󰎠',
    Object = '󰮄', -- ￼ would more appropriate
    Operator = '',
    Package = '󰏗',
    Property = '󰆦',
    Reference = '󰬲',
    Snippet = '󱄽',
    String = '󱀍', -- or   󰀬
    Struct = '󰓸', -- or 󰙅  󰆩
    Text = '󰉿',
    TypeParameter = '',
    Unit = '󰑭',
    Unknown = '', -- for Unknown values
    Value = '󰼢',
    Variable = '󰀫',
  },
}
