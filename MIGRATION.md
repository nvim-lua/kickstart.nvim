# Migration Checklist - Neovim Config Refactor

## Current State ✅
- [x] Working Python LSP (pyright)
- [x] Working Flutter LSP (dartls)
- [x] Lazy-loaded language profiles
- [x] Common plugins loaded globally
- [x] ~1200 line init.lua (needs refactoring)

## Phase 1: Understand Your Config (Before Refactoring)
- [ ] Read through entire `init.lua` - understand every line
- [ ] List all plugins you actually use (vs installed)
- [ ] Identify startup bottlenecks: `nvim --startuptime startup.log`
- [ ] Document your most-used keybindings
- [ ] Run `:checkhealth` to verify everything works

## Phase 2: Extract Configuration (Low Risk)
- [ ] Create `lua/config/options.lua` - Move all `vim.opt` settings
- [ ] Create `lua/config/keymaps.lua` - Move global keymaps
- [ ] Create `lua/config/autocmds.lua` - Move global autocmds  
- [ ] Update `init.lua` to require these modules
- [ ] Test: Restart nvim, verify everything works

## Phase 3: Reorganize Plugins (Medium Risk)
- [ ] Create `lua/plugins/core/` directory structure
- [ ] Move UI plugins to `core/ui.lua`
- [ ] Move editor plugins to `core/editor.lua`
- [ ] Move git plugins to `core/git.lua`
- [ ] Move completion to `core/completion.lua`
- [ ] Test after EACH move - don't batch them!

## Phase 4: Refactor LSP (High Risk - Do Last!)
- [ ] Create `lua/plugins/lsp/init.lua` for mason setup
- [ ] Create `lua/plugins/lsp/servers.lua` for general servers (lua_ls)
- [ ] Move language-specific LSP to their lang files
- [ ] Create `lua/util/lsp.lua` for shared utilities
- [ ] Test each language: Python, Flutter, Svelte

## Phase 5: Cleanup
- [ ] Remove unused plugins (check with `:Lazy`)
- [ ] Remove duplicate code
- [ ] Add comments explaining WHY, not WHAT
- [ ] Update README.md with your structure
- [ ] Profile startup time - compare before/after

## Testing Checklist (Run After Each Phase)
- [ ] Python: Open .py file, verify pyright loads, test completion
- [ ] Flutter: Open .dart file, verify dartls loads, test completion
- [ ] Svelte: Open .svelte file, verify svelte-ls loads
- [ ] Git: Open a git repo, test gitsigns
- [ ] Telescope: Test fuzzy finding (<leader>sf)
- [ ] LSP: Test go-to-definition, hover, rename
- [ ] Formatting: Test format-on-save
- [ ] Sessions: Test session save/restore

## Rollback Plan
```bash
# Before starting, create a backup branch
cd ~/.config/nvim
git checkout -b refactor-backup
git checkout -b refactor-attempt

# If something breaks:
git checkout refactor-backup
```

## Performance Targets
| Metric | Before | Target | After |
|--------|--------|--------|-------|
| Startup time | ? ms | <100ms | ? ms |
| Plugins loaded on startup | ? | <30 | ? |
| Time to first edit | ? ms | <200ms | ? ms |

Measure with:
```bash
nvim --startuptime startup.log
# Check the last line for total time
```

## When NOT to Refactor
- [ ] You don't understand why your current config works
- [ ] You're in the middle of a project deadline
- [ ] Your startup time is already <50ms
- [ ] You haven't backed up your config

## When TO Refactor
- [x] Your init.lua is >500 lines (yours is 1200!)
- [x] You have duplicate code across files
- [x] You're adding a 4th+ language (you have 3)
- [x] Startup time is >200ms
- [x] You want to understand how Neovim works

## Expected Benefits
- Faster startup (lazy-loading)
- Easier to add new languages (template)
- Easier to debug (modular)
- Easier to share/document
- Better understanding of Neovim

## Expected Challenges
- LSP loading timing issues (we already solved this!)
- Plugin dependency conflicts
- Breaking changes in lazy.nvim API
- Time investment (plan 4-6 hours)

---

## Quick Win: Do This First (30 minutes)

1. **Extract options** (lowest risk, immediate clarity):
```lua
-- lua/config/options.lua
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
-- ... all your vim.opt settings
```

2. **Extract keymaps**:
```lua
-- lua/config/keymaps.lua
-- Escape closes floating windows
vim.keymap.set('n', '<Esc>', function()
  -- ... your escape logic
end)
```

3. **Update init.lua**:
```lua
-- NEW init.lua (first 3 lines!)
require('config.options')
require('config.keymaps')
-- ... rest stays the same for now
```

This alone will make your init.lua 200 lines shorter and much clearer!

---

## Resources to Keep Handy
- [Lazy.nvim Spec](https://lazy.folke.io/spec)
- [:help lua-guide](https://neovim.io/doc/user/lua-guide.html)
- [Your ORGANIZATION.md](./ORGANIZATION.md)
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (reference only)

---

**Remember:** Refactoring is optional. Your current setup WORKS. Only refactor if:
1. You want to learn more about Neovim
2. You want to add many more languages
3. Your startup time bothers you
4. You enjoy organizing code

Good luck! 🚀
