# Duplicate Keymaps Reference

This document lists all keymaps where the same action can be performed using multiple key combinations.

## Philosophy

Having duplicate keymaps is **intentional and beneficial**:
- **Vim defaults + Modern alternatives**: Keep familiar vim keys while adding intuitive modern ones
- **Consistency across plugins**: Same keys work the same way in Telescope and Neo-tree
- **Ergonomics**: Function keys (F5-F12) AND leader keys for debugging
- **Context switching**: Use what feels natural in different workflows

## Debug Actions

| Action | Keys | Notes |
|--------|------|-------|
| Continue | `F5` or `<Space>dc` | F5 is standard in many IDEs |
| Step over | `F10` or `<Space>dO` | Uppercase O for over |
| Step into | `F11` or `<Space>di` | |
| Step out | `F12` or `<Space>do` | Lowercase o for out |

**Why duplicates?** Function keys are muscle memory from other IDEs. Leader keys are more discoverable via which-key and don't conflict with terminal function keys.

## Neo-tree vs Consistent Actions

| Action | Neo-tree Default | Consistent Alternative | Notes |
|--------|------------------|------------------------|-------|
| Vertical split | `s` | `Ctrl-v` | Matches Telescope |
| Horizontal split | `S` | `Ctrl-x` | Matches Telescope |
| New tab | `t` | `Ctrl-t` | Matches Telescope |
| Next source | `>` | `Ctrl-j` | Matches Telescope navigation |
| Previous source | `<` | `Ctrl-k` | Matches Telescope navigation |
| Close window | `q` | `\` or `Esc` | Backslash mirrors toggle |
| Open file | `<CR>` | `o` | Two ways to open |

**Why duplicates?** Neo-tree defaults are efficient single-key presses. Consistent alternatives (`Ctrl-x/v/t/j/k`) work the same way in Telescope, reducing cognitive load when switching between file finder and file tree.

## Flutter Code Actions

| Action | Keys | Notes |
|--------|------|-------|
| Code actions | `<Space>.` or `gra` | Period mimics Cmd+. in IDEs, gra is standard LSP |

**Why duplicates?** Flutter developers coming from IDEs expect `.` (like Cmd+.). `gra` is the standard LSP keymap used everywhere else.

## Telescope Navigation

| Action | Keys | Notes |
|--------|------|-------|
| Next/prev item | `Ctrl-j/k` or `j/k` (normal) | Insert mode uses Ctrl, normal mode uses plain |
| Close | `Ctrl-c` or `Esc` or `q` (normal) | Three ways to exit |

**Why duplicates?** `Ctrl-j/k` work in insert mode without switching modes. In normal mode, plain `j/k` are more natural.

## Vim Defaults

| Action | Keys | Notes |
|--------|------|-------|
| Save and quit | `:wq` or `ZZ` | ZZ is faster |
| Quit without save | `:q!` or `ZQ` | ZQ is faster |

**Why duplicates?** Both are vim defaults. ZZ/ZQ are faster but less discoverable.

## Summary of Duplicate Patterns

1. **Debug**: F-keys + Leader keys (muscle memory from IDEs + discoverability)
2. **Splits/Tabs**: Single keys + Ctrl combos (efficiency + consistency)
3. **Navigation**: Plain + Ctrl variants (context-dependent ergonomics)
4. **Close/Exit**: Multiple keys (q, Esc, Ctrl-c, \\) (different mental models)

## Design Principles

1. **Never remove defaults** unless they conflict
2. **Add consistent alternatives** that work across plugins
3. **Document all options** so users can choose their preferred style
4. **Optimize for discoverability** (leader keys show in which-key)
5. **Respect muscle memory** (keep vim and IDE conventions)

## Quick Reference: Cross-Plugin Consistency

These keys work the same way in **both Telescope and Neo-tree**:

- `Ctrl-x` → Horizontal split
- `Ctrl-v` → Vertical split
- `Ctrl-t` → New tab
- `Ctrl-j` → Next/down
- `Ctrl-k` → Previous/up
- `?` → Show help

This consistency means once you learn these in one plugin, they work the same everywhere.
