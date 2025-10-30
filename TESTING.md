# Profile Testing Instructions

## How to Test Each Profile

### 1. Flutter Profile (test.dart)
```bash
nvim test.dart
```

**What to check:**
- [ ] LSP loads automatically (check with `:LspInfo`)
- [ ] You see dartls in the LSP list
- [ ] Hover over `StatelessWidget` and press `K` - should show documentation
- [ ] Try completion: type `Theme.of(` and see suggestions
- [ ] Check Flutter keymaps work:
  - Press `<leader>` (space by default) and wait - should see Flutter commands
  - Try `<leader>fl` to restart LSP
- [ ] Widget guides should show (vertical lines for nested widgets)
- [ ] Closing tags should appear (e.g., `// MyApp` after closing brace)

### 2. Python Profile (test.py)
```bash
nvim test.py
```

**What to check:**
- [ ] LSP loads automatically (check with `:LspInfo`)
- [ ] You see pyright in the LSP list
- [ ] Hover over `calculate_fibonacci` and press `K` - should show type info
- [ ] Try completion: type `fib.` and see list methods
- [ ] **Test formatting on save:**
  1. Add some messy code: `x=1+2+3+4+5`
  2. Save the file (`:w`)
  3. Should auto-format to: `x = 1 + 2 + 3 + 4 + 5`
- [ ] Add an unused import at the top: `import os`
  - Save the file - ruff should remove it or flag it
- [ ] Lint errors should appear (the f-string and unused sys import)

### 3. Svelte Profile (test.svelte)
```bash
nvim test.svelte
```

**What to check:**
- [ ] LSP loads automatically (check with `:LspInfo`)
- [ ] You should see svelte-language-server
- [ ] Syntax highlighting works (script, template, style sections)
- [ ] **Test Emmet expansion:**
  1. In the `<main>` section, type: `div.test>ul>li*3`
  2. Press `<C-e>,` (Ctrl+e then comma)
  3. Should expand to nested div/ul/li structure
- [ ] **Test formatting on save:**
  1. Mess up some HTML: `<button class="btn"     on:click={increment}>Text</button>`
  2. Save the file (`:w`)
  3. Should auto-format with prettier
- [ ] Try completion on Tailwind classes: type `class="bg-` and see suggestions

### 4. Test Lazy Loading
```bash
nvim test.lua  # or init.lua
```

**What to check:**
- [ ] Open a Lua file
- [ ] Check `:LspInfo` - should only see lua_ls, NOT dartls, pyright, or svelte
- [ ] Check `:Lazy` - Flutter, Python, Svelte plugins should be "not loaded"
- [ ] Now open test.py in a split: `:split test.py`
- [ ] Check `:Lazy` again - Python plugins should now be "loaded"

### 5. Verify Mason Tools
```bash
nvim
```
Then run `:Mason`

**Tools that should be installed:**
- [x] lua-language-server (lua_ls)
- [x] stylua
- [ ] dart-language-server (dartls)  # For Flutter
- [ ] pyright  # For Python
- [ ] ruff  # For Python
- [ ] svelte-language-server
- [ ] typescript-language-server (tsserver/ts_ls)
- [ ] tailwindcss-language-server
- [ ] prettier

**If any are missing:**
1. Highlight the missing tool in Mason
2. Press `i` to install
3. Or wait - mason-tool-installer should install them automatically

## Common Issues

### LSP not loading
```vim
:checkhealth lsp
:LspLog  " Check for errors
```

### Formatter not working
```vim
:ConformInfo  " Check formatter config
:Mason  " Verify formatter is installed
```

### Plugins not loading
```vim
:Lazy check  " Check plugin status
:Lazy sync   " Re-sync plugins
```

### Node.js issues with Copilot
```vim
:echo $PATH  " Should include fnm path
```

## Success Criteria

✅ All three language profiles should:
1. Load their respective LSP automatically on file open
2. Provide completions and hover info
3. Auto-format on save
4. NOT load when opening other file types (lazy loading works)

✅ Common plugins:
1. Copilot should work in all file types (`:Copilot status`)
2. Telescope should work (`:Telescope find_files`)
3. Which-key should show keymaps when pressing `<leader>`
