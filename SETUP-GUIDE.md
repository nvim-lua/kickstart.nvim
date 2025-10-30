# VS Code-like Profile Setup for Neovim

This configuration implements a VS Code-like "profiles" system where language-specific plugins and tools only load when working with their respective file types.

## 🎯 Architecture

### File Structure
```
~/.config/nvim/
├── init.lua                          # Main config with shared LSP, Treesitter, etc.
└── lua/
    └── custom/
        └── plugins/
            ├── init.lua              # Common plugins (Copilot, Neo-tree)
            ├── flutter.lua           # Flutter/Dart profile
            ├── python.lua            # Python profile
            └── svelte.lua            # Svelte/Web profile
```

### How It Works
- **lazy.nvim** loads plugins based on file types (`ft = { 'dart', 'python', 'svelte' }`)
- When you open a `.dart` file → Flutter tools load
- When you open a `.py` file → Python tools load
- When you open a `.svelte` file → Svelte tools load
- Common plugins (Copilot, Neo-tree) are always available

## 📦 What's Included

### Common (All Profiles)
- **GitHub Copilot**: AI pair programming
- **Neo-tree**: File explorer (commented out, enable if desired)
- **Telescope**: Fuzzy finder
- **Treesitter**: Syntax highlighting
- **blink.cmp**: Autocompletion engine
- **lua_ls**: LSP for Neovim config editing

### Flutter Profile (`flutter.lua`)
**Loads on**: `.dart` files

**Tools**:
- `flutter-tools.nvim`: Flutter development tools
- `dartls`: Dart LSP server
- Widget guides, closing tags, hot reload

**Keymaps** (under `<leader>f`):
- `<leader>fr` - Flutter run
- `<leader>fq` - Flutter quit
- `<leader>fR` - Flutter restart
- `<leader>fd` - Flutter devices
- `<leader>fe` - Flutter emulators
- `<leader>fo` - Flutter outline
- `<leader>fc` - Copy profiler URL
- `<leader>fl` - Restart LSP

### Python Profile (`python.lua`)
**Loads on**: `.py` files

**Tools**:
- `pyright`: Python LSP server with type checking
- `ruff_format`: Fast Python formatter
- `ruff_organize_imports`: Import sorting
- Alternative: `black` + `isort` (commented out)

**Format on save**: Enabled for Python files

### Svelte Profile (`svelte.lua`)
**Loads on**: `.svelte`, `.ts`, `.js` files

**Tools**:
- `svelte-language-server`: Svelte LSP
- `ts_ls`: TypeScript/JavaScript LSP
- `tailwindcss`: Tailwind CSS LSP with completions
- `prettier`: Code formatter for web files
- `emmet-vim`: HTML/CSS abbreviation expansion

**Keymaps**:
- `<C-e>,` - Expand Emmet abbreviation (e.g., `div.container` → full HTML)

**Treesitter parsers**: svelte, typescript, tsx, javascript, css, html, json

## 🚀 Installation Steps

### 1. Restart Neovim
```bash
nvim
```

### 2. Install Plugins
Once Neovim opens, lazy.nvim should automatically start installing plugins. If not:
```vim
:Lazy sync
```

Wait for all plugins to install. This may take a few minutes.

### 3. Install LSP Servers & Tools
```vim
:Mason
```

Press `g?` for help. Verify these are installed:
- **Flutter**: `dart-language-server` (dartls)
- **Python**: `pyright`, `ruff`, `black` (optional), `isort` (optional)
- **Svelte**: `svelte-language-server`, `typescript-language-server`, `tailwindcss-language-server`, `prettier`
- **Common**: `lua-language-server`, `stylua`

Mason will auto-install most of these via `mason-tool-installer`.

### 4. Install Treesitter Parsers
Parsers should auto-install when you open files. To manually install:
```vim
:TSInstall dart python svelte typescript tsx javascript css html json
```

Check status:
```vim
:TSInstallInfo
```

### 5. Test Each Profile

#### Test Flutter Profile
```bash
nvim test.dart
```

Inside Neovim:
- Type some Dart code (e.g., `void main() {`)
- Check LSP is active: `:LspInfo`
- Try hot reload keymaps if in a Flutter project: `<leader>fr`

#### Test Python Profile
```bash
nvim test.py
```

Inside Neovim:
- Type some Python code (e.g., `def hello():`)
- Check LSP is active: `:LspInfo`
- Save file to trigger auto-formatting
- Try hover: `K` on a function/variable

#### Test Svelte Profile
```bash
nvim test.svelte
```

Inside Neovim:
- Type Svelte component code
- Check LSP is active: `:LspInfo`
- Try Emmet: type `div.container>ul>li*3` then `<C-e>,`
- Save file to trigger prettier formatting

## 🔧 Configuration Details

### Node.js for Copilot
Node.js is configured via fnm (Fast Node Manager):
- **Path**: `~/.local/share/fnm/aliases/default/bin`
- **Version**: Currently v24.11.0 LTS
- **Auto-update**: Using fnm aliases, so updating Node.js via `fnm install --lts` will automatically work

To update Node.js:
```bash
fnm install --lts
fnm default lts-latest
```

### Shared LSP Capabilities
All language-specific LSPs use shared capabilities from `blink.cmp` for consistent completion behavior. This is configured automatically.

### Format on Save
Enabled by default for all languages except C/C++. Language-specific formatters are defined in their respective profile files.

To disable for a specific file type, edit `init.lua`:
```lua
local disable_filetypes = { c = true, cpp = true, python = true } -- example
```

## 📝 Customization

### Adding a New Language Profile

1. Create `lua/custom/plugins/mylang.lua`:
```lua
return {
  {
    'neovim/nvim-lspconfig',
    ft = { 'mylang' }, -- file type trigger
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require('lspconfig').mylang_ls.setup {
        capabilities = capabilities,
      }
    end,
  },
  
  {
    'stevearc/conform.nvim',
    ft = { 'mylang' },
    opts = {
      formatters_by_ft = {
        mylang = { 'my_formatter' },
      },
    },
  },
  
  {
    'nvim-treesitter/nvim-treesitter',
    ft = { 'mylang' },
    opts = {
      ensure_installed = { 'mylang' },
    },
  },
}
```

2. Restart Neovim and open a `.mylang` file

### Enabling Neo-tree
The file tree is currently commented out. To enable:

Edit `lua/custom/plugins/init.lua` and uncomment the Neo-tree section:
```lua
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    -- ... (uncomment the entire block)
  },
}
```

Then `:Lazy sync` and use `<leader>e` to toggle the file tree.

### Changing Keymaps
Edit the respective language file in `lua/custom/plugins/`.

Example: Change Flutter hot reload from `<leader>fr` to `<leader>h`:
```lua
-- In lua/custom/plugins/flutter.lua
vim.keymap.set('n', '<leader>h', '<cmd>FlutterRun<cr>', { desc = '[H]ot reload' })
```

## 🐛 Troubleshooting

### Plugins not loading
```vim
:Lazy check
:Lazy sync
```

### LSP not working
```vim
:LspInfo          " Check if LSP is attached
:Mason            " Verify servers are installed
:checkhealth lsp  " Run LSP diagnostics
```

### Copilot not working
```vim
:Copilot setup    " Initial setup (if not done)
:Copilot status   " Check connection
```

If Node.js path issues:
```bash
# Verify Node.js is in fnm default alias
ls ~/.local/share/fnm/aliases/default/bin/node
```

### Formatter not running on save
Check if formatter is installed:
```vim
:Mason
```

Check if file type has formatter configured:
```vim
:ConformInfo
```

### Treesitter parsers missing
```vim
:TSInstall <parser_name>
# Or install all at once:
:TSInstall dart python svelte typescript tsx javascript css html json
```

## 📚 Resources

- **Neovim LSP**: `:help lsp`
- **lazy.nvim**: `:help lazy.nvim`
- **Telescope**: `:help telescope.nvim`
- **Treesitter**: `:help nvim-treesitter`
- **conform.nvim**: `:help conform.nvim`
- **Mason**: `:help mason.nvim`

## 🎉 What's Next?

Your setup is ready! Here are some next steps:

1. **Explore Copilot**: Try getting AI suggestions as you code
2. **Learn Flutter Tools**: Use `<leader>fr` to run Flutter apps with hot reload
3. **Try Emmet**: Speed up HTML/Svelte writing with abbreviations
4. **Customize**: Add more keymaps, plugins, or language profiles as needed
5. **Consider Neo-tree**: Uncomment if you prefer a file explorer sidebar

Enjoy your VS Code-like Neovim setup! 🚀
