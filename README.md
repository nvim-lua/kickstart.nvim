# Neovim Configuration

This is my personal Neovim configuration, originally forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and expanded into a Windows-first setup. It uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management and is aimed at Unreal Engine and game-development workflows, especially C++ and Python. It also supports general-purpose development in Lua, TypeScript, CSS, and HTML.

## Managing Plugins

### Adding a plugin

Create a new file in `lua/plugins/` that returns a lazy.nvim plugin spec table. Those plugin specs are loaded through `lua/setup/lazy.lua`, so keeping each plugin in its own file is the intended workflow.

### Removing a plugin

Delete the plugin file in `lua/plugins/`, empty it, or remove the plugin spec you no longer want. If you want to keep the file around, you can also disable the plugin in place.

### Disabling a plugin temporarily

Add `enabled = false` to the plugin spec table.

```lua
return {
  'plugin/name',
  enabled = false,
  -- other options...
}
```

### Machine-specific paths

Copy `machine.json.template` to `machine.json` (it is gitignored), then fill in the machine-specific paths for `basedpyright`, `clangd`, and optionally `ue_python`.

## Keybinds

Leader key: `<Space>`

### Navigation

| Key           | Mode | Action                                   |
| ------------- | ---- | ---------------------------------------- |
| `\`           | n    | Open file tree (Neo-tree)                |
| `<C-h>`       | n    | Move to left split                       |
| `<C-j>`       | n    | Move to lower split                      |
| `<C-k>`       | n    | Move to upper split                      |
| `<C-l>`       | n    | Move to right split                      |
| `<A-h>`       | n    | Resize split left                        |
| `<A-j>`       | n    | Resize split down                        |
| `<A-k>`       | n    | Resize split up                          |
| `<A-l>`       | n    | Resize split right                       |
| `<C-d>`       | n    | Scroll half-page down (centered)         |
| `<C-u>`       | n    | Scroll half-page up (centered)           |
| `n` / `N`     | n    | Next/prev search result (centered)       |
| `]b` / `[b`   | n    | Next/prev buffer                         |
| `]d` / `[d`   | n    | Next/prev diagnostic                     |
| `]c` / `[c`   | n    | Next/prev git hunk (in git buffers)      |
| `]q` / `[q`   | n    | Next/prev quickfix item                  |
| `j` / `k`     | n    | Move by visual lines when no count given |
| `<C-h/j/k/l>` | i    | Move cursor in insert mode               |
| `J` / `K`     | v    | Move selected lines down/up              |

### Search (Telescope)

| Key                | Action                         |
| ------------------ | ------------------------------ |
| `<leader>sf`       | Find files                     |
| `<leader>sg`       | Live grep                      |
| `<leader>sw`       | Search current word            |
| `<leader>sd`       | Search diagnostics             |
| `<leader>sh`       | Search help tags               |
| `<leader>sk`       | Search keymaps                 |
| `<leader>ss`       | Select Telescope picker        |
| `<leader>sr`       | Resume last search             |
| `<leader>s.`       | Recent files                   |
| `<leader><leader>` | Find open buffers              |
| `<leader>/`        | Fuzzy search in current buffer |
| `<leader>s/`       | Grep in open files             |
| `<leader>sn`       | Search Neovim config files     |

### LSP

| Key          | Action                                                 |
| ------------ | ------------------------------------------------------ |
| `grd`        | Go to definition (Telescope)                           |
| `grD`        | Go to declaration                                      |
| `grr`        | Go to references (Telescope)                           |
| `gri`        | Go to implementation (Telescope)                       |
| `grt`        | Go to type definition (Telescope)                      |
| `gd`         | Go to definition (native)                              |
| `gO`         | Document symbols                                       |
| `gW`         | Workspace symbols                                      |
| `K`          | Hover documentation                                    |
| `grn`        | Rename symbol                                          |
| `<leader>n`  | Rename symbol                                          |
| `gra`        | Code action (n/x)                                      |
| `<leader>lh` | Toggle inlay hints (per buffer)                        |
| `<leader>ld` | Toggle diagnostic mode (all lines ↔ current line only) |
| `<leader>li` | Toggle inlay hints (global)                            |
| `<leader>q`  | Send diagnostics to quickfix list                      |
| `<leader>pi` | Organize imports (Python/basedpyright)                 |

### Git

| Key          | Action                    |
| ------------ | ------------------------- |
| `<leader>gs` | Git status (fugitive)     |
| `<leader>gd` | Git diff split            |
| `<leader>gb` | Git blame (fugitive)      |
| `<leader>gl` | Git log                   |
| `<leader>gp` | Git push                  |
| `<leader>hs` | Stage hunk (n/v)          |
| `<leader>hr` | Reset hunk (n/v)          |
| `<leader>hS` | Stage buffer              |
| `<leader>hu` | Undo stage hunk           |
| `<leader>hR` | Reset buffer              |
| `<leader>hp` | Preview hunk (popup)      |
| `<leader>hP` | Preview hunk inline       |
| `<leader>hb` | Blame line                |
| `<leader>hd` | Diff against index        |
| `<leader>hD` | Diff against last commit  |
| `<leader>tb` | Toggle line blame         |
| `<leader>tD` | Toggle show deleted lines |
| `<leader>tw` | Toggle word diff          |

### Debug (DAP)

| Key         | Action                     |
| ----------- | -------------------------- |
| `<F5>`      | Start / Continue           |
| `<F1>`      | Step into                  |
| `<F2>`      | Step over                  |
| `<F3>`      | Step out                   |
| `<F7>`      | Toggle DAP UI              |
| `<leader>b` | Toggle breakpoint          |
| `<leader>B` | Set conditional breakpoint |

### Build (CMake)

| Key           | Action         |
| ------------- | -------------- |
| `<leader>cmg` | CMake Generate |
| `<leader>cmb` | CMake Build    |
| `<leader>cmr` | CMake Run      |
| `<leader>cmd` | CMake Debug    |
| `<leader>cms` | CMake Stop     |

### AI

| Key          | Action                      |
| ------------ | --------------------------- |
| `<leader>cc` | CodeCompanion Chat toggle   |
| `<leader>ca` | CodeCompanion Actions (n/v) |
| `<leader>cd` | Generate docstring (visual) |

### Toggles & Utilities

| Key              | Action                                 |
| ---------------- | -------------------------------------- |
| `<C-\>`          | Toggle terminal (float)                |
| `<leader>tf`     | Toggle floating terminal               |
| `<leader>th`     | Toggle horizontal terminal             |
| `<Esc>`          | Clear search highlight                 |
| `<Space><Space>` | Clear search highlight                 |
| `<leader>jk`     | Escape (n/v/i/t)                       |
| `<leader>p`      | Paste over selection (v, no overwrite) |
| `<leader>d`      | Delete to black hole (n/v)             |

### Commands (no keybind, but worth knowing)

| Command                           | Action                             |
| --------------------------------- | ---------------------------------- |
| `:LspRestart <name>`              | Restart a named LSP server         |
| `:LspInfo`                        | Show comprehensive LSP info        |
| `:LspStatus`                      | Show LSP clients on current buffer |
| `:LspCapabilities`                | Show LSP capabilities              |
| `:LspDiagnostics`                 | Show diagnostic counts             |
| `:Unreal`                         | Manually initialize Unreal-Nvim    |
| `:LspPyrightOrganizeImports`      | Organize Python imports            |
| `:LspPyrightSetPythonPath <path>` | Set Python interpreter path        |

## Unreal Engine

### Auto-initialization

Unreal-Nvim auto-initializes when opening:

- `*.uproject`, `*.uplugin`, `*.Build.cs`, `*.Target.cs`
- C/C++ files (`*.cpp`, `*.h`, `*.hpp`, `*.c`) when the cwd contains a `.uproject`
- New C/C++ files created inside a UE project cwd

If auto-init does not trigger, run `:Unreal` manually.

### C++ Workflow

- Open Neovim from the Unreal project root so `clangd` picks up `compile_commands.json` or `compile_flags.txt`
- Use `CMakeGenerate` / `CMakeBuild` (`<leader>cmg`, `<leader>cmb`) or UBT directly
- Debugging uses the `codelldb` adapter via DAP (`<F5>` to start, `<leader>b` for breakpoints)
- `clangd` provides completion, hover, and go-to-definition for UE C++ headers
- You can set a machine-specific `clangd` binary path in `machine.json` under the `clangd` key

### Python (Editor Scripting)

- Open Neovim from the Unreal project root so Python stub detection works correctly
- `basedpyright` picks up `Intermediate/PythonStub` automatically when Unreal-Nvim is initialized
- Plugin Python paths (`Plugins/*/Content/Python`) are added to `extraPaths` automatically
- Set the UE Python interpreter in `machine.json` under the `ue_python` key
- Use `<leader>pi` to organize imports
- Python debugging uses `debugpy` via DAP (`<F5>`)

## Troubleshooting

### LSP not starting

- Run `:LspInfo` to check whether a client is attached
- Ensure the language server binary is on `PATH` or configured in `machine.json`
- Run `:LspRestart <name>` to force-restart a specific server

### Plugins not loading

- Run `:Lazy` to open the plugin manager UI
- Check `:Lazy log` for errors
- Run `:Lazy sync` to update all plugins

### machine.json missing

- Copy `machine.json.template` to `machine.json` and fill in the required paths
- Without it, LSP servers fall back to binaries on `PATH`, which may or may not work on your system

### Python debugging fails on first launch

- On first run, Mason installs `debugpy` in the background; Python DAP is wired automatically once installation completes
- If it still fails, restart Neovim and try again

### Unreal LSP/Python not working

- Ensure Neovim is opened from the Unreal project root (the directory containing the `.uproject`)
- Run `:Unreal` to manually trigger Unreal-Nvim initialization
- Check that `ue_python` is set in `machine.json` for the correct UE Python interpreter

### Clangd not finding headers

- Ensure a `compile_commands.json` or `compile_flags.txt` exists in the project root (generated by CMake or UBT)
- Set the `clangd` path in `machine.json` if you use a custom LLVM build
