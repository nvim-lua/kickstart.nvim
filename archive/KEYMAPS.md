# Neovim Keymap Reference

> **Last Updated:** November 1, 2025  
> **Organization Status:** ⚠️ NEEDS CLEANUP - Duplicates and conflicts identified

## Table of Contents
- [Global Keymaps](#global-keymaps)
- [LSP Keymaps](#lsp-keymaps)
- [Language-Specific Keymaps](#language-specific-keymaps)
- [Conflicts & Duplicates](#conflicts--duplicates)
- [Proposed Organization](#proposed-organization)

---

## Global Keymaps

### Window Navigation
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<C-h>` | n | Move to left window | ✅ Keep |
| `<C-l>` | n | Move to right window | ✅ Keep |
| `<C-j>` | n | Move to lower window | ⚠️ **CONFLICT** with Telescope |
| `<C-k>` | n | Move to upper window | ⚠️ **CONFLICT** with Telescope |

### Quit Commands
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>Q` | n | Quit all | ✅ Keep |
| `<leader>q` | n | Open diagnostic quickfix | ✅ Keep |

### File Explorer
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `\` | n | Toggle Neo-tree | ✅ Keep (user requested) |

### Terminal
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<Esc><Esc>` | t | Exit terminal mode | ✅ Keep |

### Escape/Clear
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<Esc>` | n | Clear highlights + close floats | ✅ Keep |

---

## Search/Telescope (`<leader>s`)

| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>sh` | n | Search Help | ✅ Keep |
| `<leader>sk` | n | Search Keymaps | ✅ Keep |
| `<leader>sf` | n | Search Files | ✅ Keep |
| `<leader>ss` | n | Search Select Telescope | ✅ Keep |
| `<leader>sw` | n | Search current Word | ✅ Keep |
| `<leader>sg` | n | Search by Grep | ✅ Keep |
| `<leader>sd` | n | Search Diagnostics | ✅ Keep |
| `<leader>sr` | n | Search Resume | ✅ Keep |
| `<leader>s.` | n | Search Recent Files | ✅ Keep |
| `<leader>s/` | n | Search in open files | ✅ Keep |
| `<leader>sn` | n | Search Neovim config | ✅ Keep |
| `<leader>/` | n | Fuzzy search in buffer | ✅ Keep |
| `<leader><leader>` | n | Find buffers | ✅ Keep |

### Telescope Navigation (Within Telescope)
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<C-j>` | i | Next item | ⚠️ **CONFLICT** with window nav |
| `<C-k>` | i | Previous item | ⚠️ **CONFLICT** with window nav |

---

## Session (`<leader>S`)

| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>Ss` | n | Session save | ✅ Keep |
| `<leader>Sr` | n | Session restore | ✅ Keep |
| `<leader>Sd` | n | Session delete | ✅ Keep |

---

## LSP Keymaps (All Languages)

### Go-to Commands (`gr*`)
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `grd` | n | Go to Definition | ✅ Keep |
| `grD` | n | Go to Declaration | ✅ Keep |
| `gri` | n | Go to Implementation | ✅ Keep |
| `grr` | n | Go to References | ✅ Keep |
| `grt` | n | Go to Type Definition | ✅ Keep |
| `grn` | n | Rename | ✅ Keep |
| `gra` | n,v | Code Action | ⚠️ **DUPLICATE** (also `<leader>.` in Flutter) |

### Other LSP
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `K` | n | Hover Documentation | ✅ Keep |
| `gO` | n | Document Symbols | ✅ Keep |
| `gW` | n | Workspace Symbols | ✅ Keep |

---

## Toggle (`<leader>t`)

| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>th` | n | Toggle Inlay Hints | ✅ Keep |

---

## Diagnostics/Quickfix (`<leader>x`)

| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>xx` | n | Toggle diagnostics list (Trouble) | ✅ Keep |
| `<leader>xX` | n | Toggle buffer diagnostics (Trouble) | ✅ Keep |
| `<leader>xs` | n | Toggle symbols (Trouble) | ✅ Keep |

---

## Git Hunks (`<leader>h`)

| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>hs` | n,v | Stage hunk | ✅ Keep |
| `<leader>hr` | n,v | Reset hunk | ✅ Keep |
| `<leader>hS` | n | Stage buffer | ✅ Keep |
| `<leader>hu` | n | Undo stage hunk | ✅ Keep |
| `<leader>hR` | n | Reset buffer | ✅ Keep |
| `<leader>hp` | n | Preview hunk | ✅ Keep |
| `<leader>hb` | n | Blame line | ✅ Keep |
| `<leader>hd` | n | Diff this | ✅ Keep |
| `<leader>hD` | n | Diff this ~ | ✅ Keep |

---

## Language-Specific Keymaps

### Flutter/Dart (`<leader>f`, `<leader>d`)

#### Flutter Workflow
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>fr` | n | Flutter Run | ✅ Keep |
| `<leader>fR` | n | Flutter Hot Restart | ✅ Keep |
| `<leader>fq` | n | Flutter Quit | ✅ Keep |
| `<leader>fd` | n | Flutter Devices (select) | ✅ Keep |
| `<leader>fe` | n | Flutter Emulators | ✅ Keep |
| `<leader>fo` | n | Flutter Outline Toggle | ✅ Keep |
| `<leader>fc` | n | Flutter Copy Profiler URL | ✅ Keep |
| `<leader>fl` | n | Flutter LSP Restart | ✅ Keep |

#### Flutter Code Actions
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>.` | n,v | Code Actions (Cmd+.) | ⚠️ **DUPLICATE** with `gra` |
| `gra` | n,v | Code Action | ⚠️ **DUPLICATE** with `<leader>.` |

#### Debug (Flutter/Dart)
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<F5>` | n | Debug: Start/Continue | ✅ Keep |
| `<F10>` | n | Debug: Step Over | ✅ Keep |
| `<F11>` | n | Debug: Step Into | ✅ Keep |
| `<F12>` | n | Debug: Step Out | ✅ Keep |
| `<leader>db` | n | Debug: Toggle Breakpoint | ✅ Keep |
| `<leader>dB` | n | Debug: Conditional Breakpoint | ✅ Keep |
| `<leader>dc` | n | Debug: Continue | ⚠️ **DUPLICATE** with `<F5>` |
| `<leader>dt` | n | Debug: Terminate | ✅ Keep |
| `<leader>du` | n | Debug: Toggle UI | ✅ Keep |

### Rust (`<leader>r`, `<leader>c`)

#### Rust Tools
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>rh` | n | Rust Hover Actions | ✅ Keep |
| `<leader>ra` | n | Rust Code Actions | ✅ Keep |
| `<leader>re` | n | Rust Explain Error | ✅ Keep |
| `<leader>rc` | n | Rust Open Cargo.toml | ⚠️ **CONFLICT** with Crates (in Cargo.toml) |
| `<leader>rp` | n | Rust Parent Module | ✅ Keep |
| `<leader>rj` | n | Rust Join Lines | ✅ Keep |

#### Crates (Cargo.toml only)
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| `<leader>ct` | n | Crates Toggle | ✅ Keep |
| `<leader>cr` | n | Crates Reload | ⚠️ **CONFLICT** with `<leader>rc` in .rs files |
| `<leader>cv` | n | Crates Show Versions | ✅ Keep |
| `<leader>cf` | n | Crates Show Features | ✅ Keep |
| `<leader>cd` | n | Crates Show Dependencies | ✅ Keep |
| `<leader>cu` | n,v | Crates Update | ✅ Keep |
| `<leader>ca` | n | Crates Update All | ✅ Keep |
| `<leader>cU` | n,v | Crates Upgrade | ✅ Keep |
| `<leader>cA` | n | Crates Upgrade All | ✅ Keep |
| `<leader>ce` | n | Crates Expand to inline | ✅ Keep |
| `<leader>cE` | n | Crates Extract to table | ✅ Keep |
| `<leader>cH` | n | Crates Open Homepage | ✅ Keep |
| `<leader>cR` | n | Crates Open Repository | ✅ Keep |
| `<leader>cD` | n | Crates Open Documentation | ✅ Keep |
| `<leader>cC` | n | Crates Open Crates.io | ✅ Keep |

### Python (`<leader>p`)
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| (No keymaps defined yet) | - | - | ⚠️ Need to add |

### Svelte (`<leader>v`)
| Key | Mode | Action | Status |
|-----|------|--------|--------|
| (No keymaps defined yet) | - | - | ⚠️ Need to add |

---

## Conflicts & Duplicates

### 🔴 Critical Conflicts

1. **Window Navigation vs Telescope Navigation**
   - `<C-j>` and `<C-k>` used for BOTH window navigation AND Telescope item navigation
   - **Impact:** Medium - Can't navigate windows while Telescope is open
   - **Resolution:** Telescope should use different keys or remain as-is (works in insert mode)

2. **Code Actions: `gra` vs `<leader>.`**
   - Both do the same thing in Flutter/Dart files
   - **Impact:** Low - Just redundant
   - **Resolution:** Keep both (muscle memory from different editors)

3. **Debug Continue: `<F5>` vs `<leader>dc`**
   - Both do the same thing
   - **Impact:** Low - Just redundant
   - **Resolution:** Keep both (F5 is standard, leader-based for discoverability)

4. **Rust Cargo.toml conflicts**
   - `<leader>rc` means different things in `.rs` vs `Cargo.toml` files
   - `<leader>cr` means different things in `.rs` vs `Cargo.toml` files
   - **Impact:** High - Same key does different things based on filename
   - **Resolution:** This is acceptable since they're context-dependent (filetype-specific)

### 🟡 Minor Issues

1. **No Python or Svelte keymaps**
   - Missing language-specific shortcuts
   - **Resolution:** Add `<leader>p` for Python, `<leader>v` for Svelte

2. **No unified debug keymaps**
   - Debug keys only in Flutter, not available globally
   - **Resolution:** Move debug keymaps to global scope if DAP is loaded

---

## Proposed Organization

### Leader Key Groups (LazyVim-style with Icons)

```
<leader>
├── <leader><leader>  →  Buffers
├── <leader>/         →  Search in buffer
├── <leader>.         →  Code action (Flutter/Dart specific)
├── <leader>Q         →  Quit all
├── <leader>q         →  Quickfix diagnostics
│
├── 󰊄 <leader>b       →  [B]uffer operations (NEW)
│   ├── <leader>bd    →  Delete buffer
│   ├── <leader>bD    →  Delete buffer (force)
│   ├── <leader>bn    →  Next buffer
│   ├── <leader>bp    →  Previous buffer
│   └── <leader>bP    →  Pin buffer
│
├──  <leader>c       →  [C]ode operations (NEW - UNIFY CODE ACTIONS)
│   ├── <leader>ca    →  Code action
│   ├── <leader>cf    →  Format
│   ├── <leader>cr    →  Rename
│   └── <leader>cs    →  Symbol search
│
├──  <leader>d       →  [D]ebug (GLOBAL - move from Flutter-only)
│   ├── <leader>db    →  Toggle breakpoint
│   ├── <leader>dB    →  Conditional breakpoint
│   ├── <leader>dc    →  Continue
│   ├── <leader>di    →  Step into
│   ├── <leader>do    →  Step out
│   ├── <leader>dO    →  Step over
│   ├── <leader>dt    →  Terminate
│   └── <leader>du    →  Toggle UI
│
├──  <leader>f       →  [F]lutter (Dart files only)
│   ├── <leader>fr    →  Run
│   ├── <leader>fR    →  Hot restart
│   ├── <leader>fq    →  Quit
│   ├── <leader>fd    →  Devices
│   ├── <leader>fe    →  Emulators
│   ├── <leader>fo    →  Outline toggle
│   ├── <leader>fc    →  Copy profiler URL
│   └── <leader>fl    →  LSP restart
│
├──  <leader>g       →  [G]it (RENAME from <leader>h)
│   ├── <leader>gs    →  Stage hunk
│   ├── <leader>gr    →  Reset hunk
│   ├── <leader>gS    →  Stage buffer
│   ├── <leader>gu    →  Undo stage
│   ├── <leader>gR    →  Reset buffer
│   ├── <leader>gp    →  Preview hunk
│   ├── <leader>gb    →  Blame line
│   ├── <leader>gd    →  Diff this
│   └── <leader>gD    →  Diff this ~
│
├──  <leader>p       →  [P]ython (Python files only) (NEW)
│   ├── <leader>pr    →  Run file
│   ├── <leader>pR    →  Run with args
│   ├── <leader>pi    →  Import sort
│   ├── <leader>pe    →  Select environment
│   └── <leader>pt    →  Run tests
│
├──  <leader>r       →  [R]ust (Rust files only)
│   ├── <leader>rh    →  Hover actions
│   ├── <leader>ra    →  Code actions
│   ├── <leader>re    →  Explain error
│   ├── <leader>rc    →  Open Cargo.toml
│   ├── <leader>rp    →  Parent module
│   ├── <leader>rj    →  Join lines
│   ├── <leader>rt    →  Runnables
│   └── <leader>rr    →  Run (NEW)
│   │
│   └──  <leader>rc  →  [C]rates (Cargo.toml only)
│       ├── <leader>rct  →  Toggle
│       ├── <leader>rcr  →  Reload
│       ├── <leader>rcv  →  Show versions
│       ├── <leader>rcf  →  Show features
│       ├── <leader>rcd  →  Show dependencies
│       ├── <leader>rcu  →  Update crate
│       ├── <leader>rca  →  Update all
│       ├── <leader>rcU  →  Upgrade crate
│       └── <leader>rcA  →  Upgrade all
│
├──  <leader>s       →  [S]earch
│   ├── <leader>sh    →  Help
│   ├── <leader>sk    →  Keymaps
│   ├── <leader>sf    →  Files
│   ├── <leader>ss    →  Select Telescope
│   ├── <leader>sw    →  Current word
│   ├── <leader>sg    →  Grep
│   ├── <leader>sd    →  Diagnostics
│   ├── <leader>sr    →  Resume
│   ├── <leader>s.    →  Recent files
│   ├── <leader>s/    →  Open files
│   ├── <leader>sn    →  Neovim config
│   └── <leader>sc    →  Cheatsheet (NEW)
│
├──  <leader>S       →  [S]ession
│   ├── <leader>Ss    →  Save
│   ├── <leader>Sr    →  Restore
│   └── <leader>Sd    →  Delete
│
├──  <leader>t       →  [T]oggle
│   ├── <leader>th    →  Inlay hints
│   ├── <leader>td    →  Diagnostics
│   ├── <leader>tl    →  Line numbers
│   ├── <leader>tr    →  Relative numbers
│   ├── <leader>ts    →  Spell check
│   ├── <leader>tw    →  Wrap
│   └── <leader>tc    →  Conceallevel
│
├──  <leader>u       →  [U]I (NEW)
│   ├── <leader>un    →  Noice dismiss
│   ├── <leader>ul    →  Lazy
│   ├── <leader>um    →  Mason
│   └── <leader>ui    →  Inspect tree
│
├──  <leader>v       →  S[v]elte (Svelte files only) (NEW)
│   └── (TBD)
│
├──  <leader>w       →  [W]indow operations (NEW)
│   ├── <leader>ww    →  Other window
│   ├── <leader>wd    →  Delete window
│   ├── <leader>ws    →  Split below
│   ├── <leader>wv    →  Split right
│   └── <leader>wm    →  Maximize toggle
│
└──  <leader>x       →  Diagnostics/quickfi[X]
    ├── <leader>xx    →  Toggle diagnostics
    ├── <leader>xX    →  Buffer diagnostics
    └── <leader>xs    →  Symbols
```

### Non-Leader Keys

```
\        →  Toggle Neo-tree (file explorer)
K        →  Hover documentation (LSP)
<Esc>    →  Clear highlights + close floats

gr*      →  LSP "go to" commands
├── grd  →  Definition
├── grD  →  Declaration
├── gri  →  Implementation
├── grr  →  References
├── grt  →  Type definition
├── grn  →  Rename
└── gra  →  Code action

gO       →  Document symbols
gW       →  Workspace symbols

<C-hjkl> →  Window navigation
<F5-F12> →  Debug keys (when available)
```

---

## Next Steps

1. ✅ **Document current state** (this file)
2. ⏳ **Clean up duplicates** - Remove redundant keymaps
3. ⏳ **Reorganize which-key** - Add icons, proper groups, submenus
4. ⏳ **Add missing keymaps** - Python, Svelte, Buffer, Window, UI operations
5. ⏳ **Update language configs** - Move Crates under `<leader>rc`, standardize patterns
6. ⏳ **Implement cheatsheet** - Telescope-based searchable keymap reference
7. ⏳ **Test everything** - Ensure no conflicts, all descriptions visible
