# Neovim Configuration Organization Guide

## Current Structure (What You Have)

```
~/.config/nvim/
├── init.lua                          # Main entry point (1200 lines - TOO LARGE!)
├── lua/
│   ├── custom/
│   │   └── plugins/
│   │       ├── init.lua             # Common plugins (all filetypes)
│   │       ├── flutter.lua          # Flutter-specific (lazy-loaded)
│   │       ├── python.lua           # Python-specific (lazy-loaded)
│   │       ├── svelte.lua           # Svelte-specific (lazy-loaded)
│   │       └── session.lua          # Session management
│   └── kickstart/
│       ├── health.lua
│       └── plugins/
│           ├── autopairs.lua
│           ├── debug.lua
│           ├── gitsigns.lua
│           ├── indent_line.lua
│           ├── lint.lua
│           └── neo-tree.lua
```

## Problems with Current Setup

1. **`init.lua` is massive (1200 lines)** - Should be split into modules
2. **LSP setup is duplicated** - Language-specific LSP code is in `init.lua` instead of language files
3. **Unclear separation** - What belongs in `custom/` vs `kickstart/`?
4. **No clear loading strategy** - Which plugins load when?

---

## Recommended Structure (Optimal Organization)

```
~/.config/nvim/
├── init.lua                          # THIN entry point (~50 lines)
│
├── lua/
│   ├── config/
│   │   ├── options.lua              # Vim options (set, opt)
│   │   ├── keymaps.lua              # Global keymaps
│   │   ├── autocmds.lua             # Global autocmds
│   │   └── lazy.lua                 # Lazy.nvim bootstrap
│   │
│   ├── plugins/
│   │   ├── core/
│   │   │   ├── ui.lua               # UI plugins (always loaded)
│   │   │   ├── editor.lua           # Editor enhancements (always loaded)
│   │   │   ├── git.lua              # Git tools (always loaded)
│   │   │   └── completion.lua       # Completion engine (always loaded)
│   │   │
│   │   ├── lsp/
│   │   │   ├── init.lua             # LSP infrastructure (mason, lspconfig)
│   │   │   ├── servers.lua          # General LSP servers (lua_ls, etc.)
│   │   │   └── keymaps.lua          # LSP keymaps (shared)
│   │   │
│   │   └── lang/
│   │       ├── python.lua           # Python: LSP + formatters + linters
│   │       ├── flutter.lua          # Flutter: LSP + debugging + tools
│   │       ├── svelte.lua           # Svelte: LSP + formatters
│   │       ├── go.lua               # Future: Go support
│   │       └── rust.lua             # Future: Rust support
│   │
│   └── util/
│       ├── lsp.lua                  # Shared LSP utilities
│       └── init.lua                 # Shared helper functions
```

---

## How This Works: Lazy-Loading Strategy

### 1. **Core Plugins (Always Loaded)**
```lua
-- lua/plugins/core/editor.lua
return {
  { 'echasnovski/mini.pairs' },        -- Autopairs
  { 'folke/which-key.nvim' },          -- Keybinding helper
  { 'nvim-telescope/telescope.nvim' }, -- Fuzzy finder
}
```

### 2. **LSP Infrastructure (Loaded Early)**
```lua
-- lua/plugins/lsp/init.lua
return {
  'neovim/nvim-lspconfig',
  dependencies = { 'mason.nvim', 'mason-lspconfig.nvim' },
  config = function()
    -- Setup mason, but don't configure language servers here
    require('mason').setup()
    require('mason-lspconfig').setup()
  end,
}
```

### 3. **Language-Specific (Lazy-Loaded by FileType)**
```lua
-- lua/plugins/lang/python.lua
return {
  -- Mason tools
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    ft = 'python',
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = { 'pyright', 'ruff' }
      })
    end,
  },
  
  -- LSP setup
  {
    'neovim/nvim-lspconfig',
    ft = 'python',
    config = function()
      -- Start pyright via autocmd
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        callback = function(args)
          local capabilities = require('blink.cmp').get_lsp_capabilities()
          vim.lsp.start({
            name = 'pyright',
            cmd = { vim.fn.stdpath('data') .. '/mason/bin/pyright-langserver', '--stdio' },
            root_dir = vim.fs.root(args.buf, { 'pyproject.toml', 'setup.py', '.git' }),
            capabilities = capabilities,
          })
        end,
      })
    end,
  },
  
  -- Formatters
  {
    'stevearc/conform.nvim',
    ft = 'python',
    config = function()
      require('conform').formatters_by_ft.python = { 'ruff_format', 'ruff_organize_imports' }
    end,
  },
}
```

---

## Migration Plan (Step-by-Step)

### Phase 1: Extract Configuration from init.lua
```lua
-- NEW init.lua (50 lines instead of 1200!)
require('config.options')   -- Vim settings
require('config.keymaps')   -- Global keymaps
require('config.autocmds')  -- Global autocmds
require('config.lazy')      -- Bootstrap lazy.nvim and load plugins
```

### Phase 2: Organize Plugins by Loading Strategy

**Always Loaded (Core):**
- `lua/plugins/core/ui.lua` - colorscheme, statusline, bufferline
- `lua/plugins/core/editor.lua` - telescope, which-key, autopairs, neo-tree
- `lua/plugins/core/git.lua` - gitsigns, fugitive
- `lua/plugins/core/completion.lua` - blink.cmp

**Lazy-Loaded by FileType:**
- `lua/plugins/lang/python.lua` - ft = 'python'
- `lua/plugins/lang/flutter.lua` - ft = { 'dart', 'flutter' }
- `lua/plugins/lang/svelte.lua` - ft = 'svelte'

**Lazy-Loaded by Command:**
- Debugging tools - cmd = { 'DapContinue', 'DapToggleBreakpoint' }
- Session management - cmd = { 'SessionSave', 'SessionLoad' }

### Phase 3: Fix LSP Loading Issue

**Problem:** You discovered that language-specific LSP configs in lazy-loaded files don't work because `nvim-lspconfig` is already loaded by `init.lua`.

**Solution:** Two approaches:

#### Option A: Centralized LSP Setup (Simpler)
```lua
-- lua/plugins/lsp/servers.lua
local M = {}

M.setup_python = function()
  -- Python LSP setup
end

M.setup_flutter = function()
  -- Flutter LSP setup  
end

-- Autocmds to trigger setup
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  once = true,
  callback = M.setup_python,
})
```

#### Option B: Per-Language Setup (Cleaner but Complex)
```lua
-- lua/plugins/lang/python.lua
return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    ft = 'python',
    config = function()
      -- Install tools
      require('mason-tool-installer').setup({ ensure_installed = { 'pyright', 'ruff' }})
      
      -- Setup LSP via autocmd (since lspconfig is already loaded)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        callback = function(args)
          require('util.lsp').start_server('pyright', args.buf, {
            settings = { python = { analysis = { typeCheckingMode = 'basic' }}}
          })
        end,
      })
    end,
  },
}

-- lua/util/lsp.lua (shared utility)
local M = {}

M.start_server = function(name, bufnr, opts)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = name })
  if #clients > 0 then return end
  
  local capabilities = require('blink.cmp').get_lsp_capabilities()
  vim.lsp.start(vim.tbl_deep_extend('force', {
    name = name,
    capabilities = capabilities,
  }, opts))
end

return M
```

---

## Loading Performance Best Practices

### 1. Use Lazy-Loading Triggers

```lua
-- ❌ BAD: Loads immediately on startup
{ 'some/plugin' }

-- ✅ GOOD: Loads only when needed
{ 'some/plugin', ft = 'python' }           -- When opening .py files
{ 'some/plugin', cmd = 'SomeCommand' }     -- When running :SomeCommand
{ 'some/plugin', keys = '<leader>x' }      -- When pressing <leader>x
{ 'some/plugin', event = 'VeryLazy' }      -- After startup (low priority)
```

### 2. Profile Your Startup Time

```bash
# Measure startup time
nvim --startuptime startup.log

# Find slow plugins
grep "sourcing" startup.log | sort -k2 -n
```

### 3. Use `:Lazy` to Monitor Loading

- Green plugins = loaded
- Gray plugins = not loaded yet (lazy)
- See what triggered loading

---

## Recommended Final Structure

```
~/.config/nvim/
├── init.lua                    # ~50 lines: require config modules
│
├── lua/
│   ├── config/
│   │   ├── options.lua        # set.number, opt.clipboard, etc.
│   │   ├── keymaps.lua        # Global keymaps only
│   │   ├── autocmds.lua       # Global autocmds only
│   │   └── lazy.lua           # Bootstrap lazy.nvim
│   │
│   ├── plugins/
│   │   ├── core/
│   │   │   ├── ui.lua         # Colorscheme, statusline, etc.
│   │   │   ├── editor.lua     # Telescope, which-key, autopairs
│   │   │   ├── git.lua        # Gitsigns, fugitive
│   │   │   └── completion.lua # blink.cmp
│   │   │
│   │   ├── lsp/
│   │   │   ├── init.lua       # Mason, lspconfig setup
│   │   │   ├── servers.lua    # lua_ls and other general servers
│   │   │   └── keymaps.lua    # LSP keymaps (on_attach)
│   │   │
│   │   └── lang/
│   │       ├── python.lua     # ft = 'python'
│   │       ├── flutter.lua    # ft = 'dart'
│   │       └── svelte.lua     # ft = 'svelte'
│   │
│   └── util/
│       ├── lsp.lua            # Shared LSP helpers
│       └── init.lua           # Shared utility functions
│
├── ORGANIZATION.md             # This file
├── MIGRATION.md                # Step-by-step migration guide
└── README.md                   # Your custom README
```

---

## Key Principles

1. **Thin `init.lua`** - Just require modules, no logic
2. **Separate concerns** - Options, keymaps, autocmds, plugins
3. **Lazy-load everything possible** - Use `ft`, `cmd`, `keys`, `event`
4. **Language files are independent** - Each lang/ file is self-contained
5. **Share common code** - Use `util/` for helpers
6. **Profile regularly** - Use `:Lazy profile` and `--startuptime`

---

## Learning Resources

### Understanding Neovim Configuration
- `:help lua-guide` - Official Lua guide
- `:help options` - All vim options
- `:help api` - Lua API reference

### Lazy-Loading
- `:help lazy.nvim` - Lazy.nvim documentation
- `:Lazy profile` - See what's slow
- `:Lazy` - Interactive plugin manager

### LSP
- `:help lsp` - LSP overview
- `:help vim.lsp.start()` - Start LSP servers
- `:LspInfo` - See active LSP clients

### Performance
- `nvim --startuptime startup.log` - Measure startup
- `:profile start profile.log | profile func * | profile file *` - Profile runtime

---

## Next Steps

1. **Commit current working state** ✅ (You're doing this now)
2. **Read through this guide** to understand the concepts
3. **Try the migration in a branch** (don't break your working config!)
4. **Migrate incrementally**:
   - Step 1: Extract options/keymaps from init.lua
   - Step 2: Move plugins to core/ structure
   - Step 3: Refactor language-specific configs
5. **Test after each step** - Make sure everything still works
6. **Profile before and after** - Measure improvements

---

## Questions to Consider

1. **Do you need kickstart/ folder anymore?** 
   - If you understand the code, merge it into your own structure
   
2. **How many languages will you support?**
   - 3-5 languages: Current structure is fine
   - 10+ languages: Consider more sophisticated loading
   
3. **Do you want to share your config?**
   - Yes: Document everything, make it modular
   - No: Optimize for your own workflow

4. **How often will you add new languages?**
   - Frequently: Build a template system
   - Rarely: Current per-file approach works

---

**Remember:** This is YOUR config. Start with what works, refactor when you understand WHY you're refactoring. Don't cargo-cult someone else's structure!
