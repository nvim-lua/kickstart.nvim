# Neovim Keybind Analysis & Natural Language Search Plugin Design

## Current Keybind Inventory

### Core Navigation & Windows
- `<C-h>` - Move focus to the left window
- `<C-l>` - Move focus to the right window  
- `<C-j>` - Move focus to the lower window
- `<C-k>` - Move focus to the upper window
- `<Esc>` - Clear search highlights
- `<Esc><Esc>` - Exit terminal mode

### Search & File Operations (`<leader>s*`)
- `<leader>sf` - Search Files
- `<leader>sh` - Search Help
- `<leader>sk` - Search Keymaps
- `<leader>ss` - Search Select Telescope
- `<leader>sw` - Search current Word
- `<leader>sg` - Search by Grep
- `<leader>sd` - Search Diagnostics
- `<leader>sr` - Search Resume
- `<leader>s.` - Search Recent Files
- `<leader>s/` - Search in Open Files
- `<leader>sn` - Search Neovim files
- `<leader>/` - Fuzzily search in current buffer
- `<leader><leader>` - Find existing buffers

### LSP Operations (Dynamic - Buffer Specific)
- `grn` - LSP: Rename
- `gra` - LSP: Code Action
- `grr` - LSP: References
- `gri` - LSP: Implementations
- `grd` - LSP: Definitions
- `grD` - LSP: Declaration
- `gO` - LSP: Open Document Symbols
- `gW` - LSP: Open Workspace Symbols
- `grt` - LSP: Type Definition
- `<leader>lr` - LSP Reload all servers

### Debug Operations (`<leader>d*`) - From Commented Plugin
- `<leader>dc` - DAP: Continue show UI
- `<leader>db` - DAP: Toggle Breakpoint
- `<leader>dl` - DAP: Run Last
- `<leader>di` - DAP: Step Into
- `<leader>dk` - DAP: Step Over
- `<leader>do` - DAP: Step Out
- `<leader>dx` - DAP: Run to Cursor
- `<leader>dt` - DAP: Terminate
- `<leader>dr` - DAP: Open REPL
- `<leader>du` - DAP: Toggle UI

### Toggle Operations (`<leader>t*`)
- `<leader>tp` - Toggle path completion (from commented plugin)
- `<leader>th` - Toggle Inlay Hints (LSP dynamic)

### Other Operations
- `<leader>q` - Open diagnostic Quickfix list
- `<leader>f` - Format buffer (from main config)

### Which-Key Groups
- `<leader>s` - [S]earch group
- `<leader>t` - [T]oggle group  
- `<leader>h` - Git [H]unk group

## Issues & Opportunities

### 1. **Duplicate Keybinds**
Both main `init.lua` and custom telescope plugin define identical telescope keybinds. The custom ones likely override the main ones.

### 2. **Commented Out Functionality**
Many useful keybinds are in commented-out plugin files:
- Debug operations (`<leader>d*`)
- Path completion toggle (`<leader>tp`)
- Additional telescope configurations

### 3. **Missing Categories**
No git operations visible (though which-key defines git hunk group), file operations beyond search, etc.

### 4. **Inconsistent Description Patterns**
- Some use `[X]` bracket notation
- Some use full words
- LSP uses `LSP:` prefix
- DAP uses `DAP:` prefix

## Natural Language Search Plugin Design

### Core Concept
Create a Telescope extension that indexes all keybinds and allows fuzzy natural language search.

### Implementation Approach

#### 1. **Keybind Parser Module** (`lua/custom/plugins/keyfinder/parser.lua`)
```lua
-- Scan all config files for vim.keymap.set calls
-- Extract: key, mode, description, file location
-- Build searchable index with synonyms
```

#### 2. **Natural Language Matcher** (`lua/custom/plugins/keyfinder/matcher.lua`)
```lua
-- Map natural language to keybind concepts:
-- "find file" -> ["search", "file", "find", "open"]
-- "debug breakpoint" -> ["debug", "breakpoint", "dap", "pause"]
-- "restart lsp" -> ["lsp", "restart", "reload", "server"]
```

#### 3. **Telescope Extension** (`lua/custom/plugins/keyfinder/telescope.lua`)
```lua
-- Telescope picker that searches through indexed keybinds
-- Shows: Keybind | Description | Mode | File
-- Supports: fuzzy matching on natural language
```

#### 4. **Usage Examples**
- Type "find files" → Shows `<leader>sf` - Search Files
- Type "debug step" → Shows debug stepping keybinds
- Type "lsp rename" → Shows `grn` - LSP: Rename  
- Type "reload" → Shows `<leader>lr` - LSP Reload all servers

### Integration Points

#### With Which-Key
- Read which-key group definitions for context
- Show which-key popup for discovered keybinds
- Integrate with which-key's delay system

#### With Telescope
- Reuse telescope's fuzzy matching
- Follow telescope's UI patterns
- Allow chaining to other telescope commands

#### With Help System  
- Link to `:help` entries when available
- Show function signatures for LSP commands
- Display source file locations

### Technical Implementation

#### File Scanning Strategy
1. **Static Analysis**: Parse Lua AST for `vim.keymap.set` calls
2. **Runtime Introspection**: Query `vim.api.nvim_get_keymap()` for active bindings
3. **Plugin Integration**: Hook into lazy.nvim plugin loading to catch dynamic bindings

#### Search Algorithm
1. **Tokenization**: Split natural language into keywords
2. **Synonym Expansion**: "find" → ["search", "find", "locate", "open"]
3. **Weighted Scoring**: Boost exact matches, penalize partial matches
4. **Context Awareness**: Consider mode, plugin context, frequency of use

#### Performance Considerations
- **Lazy Loading**: Only scan when plugin is first used
- **Caching**: Store parsed results, invalidate on config changes  
- **Incremental Updates**: Watch for file changes, update index incrementally

### User Experience

#### Primary Interface
- `<leader>?` or `<leader>sk` (extend existing keymap search)
- Telescope popup with natural language prompt
- Live preview of matching keybinds

#### Secondary Features
- **Keybind Execution**: Press Enter to execute the found keybind
- **Help Integration**: `<C-h>` to show help for selected keybind
- **Source Navigation**: `<C-s>` to jump to keybind definition
- **Usage Statistics**: Track most-used searches, suggest improvements

## Next Steps

1. **Prototype Parser**: Build basic keybind extraction from config files
2. **Simple Matcher**: Implement keyword-based search
3. **Telescope Integration**: Create basic picker interface
4. **Test & Iterate**: Use with real workflows, refine search algorithm
5. **Advanced Features**: Add synonym expansion, usage tracking, help integration

## Natural Language → Keybind Examples

| Natural Language | Expected Keybind | Current Status |
|------------------|------------------|----------------|
| "find files" | `<leader>sf` | ✅ Active |
| "search in file" | `<leader>/` | ✅ Active |  
| "debug breakpoint" | `<leader>db` | ⚠️ Commented out |
| "lsp rename" | `grn` | ✅ Active (LSP buffer only) |
| "reload lsp" | `<leader>lr` | ✅ Active |
| "git blame" | ? | ❌ Not found |
| "format code" | `<leader>f` | ✅ Active |
| "open terminal" | ? | ❌ Not found |
| "toggle diagnostics" | ? | ❌ Not found |

This analysis reveals both the potential and the gaps in your current keybind setup. The natural language search plugin would be most valuable for discovering the numerous LSP keybinds and managing the complexity of your growing configuration.