# nvim

Personal Neovim config based on `kickstart.nvim`, tuned for backend-heavy work
in JavaScript/TypeScript, C/C++, Kubernetes, and server development.

This README is the working manual for what is configured, why it exists, and
how to use it quickly.

## Design principles

- Additive, not disruptive: new plugins and mappings are added without replacing
  existing behavior.
- Modular plugin specs: each concern lives in `lua/custom/plugins/*.lua`.
- Terminal-friendly workflow: most actions map to short leader sequences and
  preserve CLI-first habits.
- Keep startup stable: major features are lazy-loaded by command, filetype, or
  explicit keymaps where possible.

## Repository layout

- `init.lua`: base options, core plugin setup, LSP, formatting, treesitter.
- `lua/custom/plugins/*.lua`: modular plugin specs and custom behavior.
- `doc/nvim.txt`: Vim help document (`:help nvim-config`).
- `lazy-lock.json`: plugin lockfile managed by lazy.nvim.

## Quick validation commands

Run these after config changes:

```sh
nvim --headless "+qa"
nvim --headless "+checkhealth" "+qa"
luac -p init.lua lua/custom/**/*.lua
```

Useful maintenance commands:

```sh
nvim --headless "+Lazy! sync" "+qa"
nvim --headless "+MasonToolsInstallSync" "+qa"
```

## Keymap manual

### Git workflow

- `<leader>gg`: open Neogit UI
- `<leader>gd`: open Diffview
- `<leader>gD`: close Diffview
- `<leader>gf`: Diffview file history (current file)
- `<leader>gF`: Diffview repo history
- `<leader>h...`: Gitsigns hunk actions (`:which-key <leader>h`)

### Diagnostics and code navigation

- `<leader>xx`: Trouble diagnostics
- `<leader>xw`: Trouble workspace diagnostics
- `<leader>xd`: Trouble current buffer diagnostics
- `<leader>xq`: Trouble quickfix list
- `<leader>xl`: Trouble location list
- `<leader>tc`: toggle treesitter context header
- `<leader>jm` / `<leader>jk`: next/previous function start
- `<leader>jM` / `<leader>jK`: next/previous function end
- `<leader>jc` / `<leader>jC`: next/previous class start
- Textobject select (operator-pending/visual): `af`/`if` for function, `ac`/`ic` for class

### Tests and debug

- `<leader>nr`: neotest run nearest
- `<leader>nf`: neotest run current file
- `<leader>ns`: neotest run suite (cwd)
- `<leader>nd`: neotest debug nearest via DAP
- `<leader>nn`: neotest summary toggle
- `<leader>no`: neotest output for nearest test
- `<leader>nO`: neotest output panel toggle
- `<leader>na`: attach to running neotest process
- `<leader>nS`: stop neotest run

Existing DAP keys are unchanged:

- `<F5>` continue/start, `<F1>` step into, `<F2>` step over, `<F3>` step out
- `<F7>` toggle dap-ui, `<leader>b` toggle breakpoint, `<leader>B` conditional bp

### Search, replace, and explorer

- `<leader>sR`: project search/replace with grug-far
- `<leader>eo`: open Oil explorer view (optional, non-default explorer)

### CMake workflow (optional)

- `<leader>cg`: CMake generate
- `<leader>cb`: CMake build
- `<leader>cr`: CMake run
- `<leader>ct`: CMake test
- `<leader>cc`: CMake select build type

## Plugin stack by workflow

### LSP and language intelligence

- `nvim-lspconfig` + `mason-lspconfig` + `mason-tool-installer`
- Vue integration:
  - `vue_ls` enabled
  - `ts_ls` scoped to `vue` with `@vue/typescript-plugin`
  - keeps `typescript-tools.nvim` available for TS/JS workflows
- Kubernetes/Helm integration:
  - `yamlls` with schema mappings for Kubernetes, Helm chart, Helmfile,
    and Kustomize
  - `helm_ls` enabled
  - `vim-helm` added for Helm syntax support

### Treesitter and structural editing

- `nvim-treesitter` uses current API (`require('nvim-treesitter').setup()`).
- `nvim-treesitter-context` provides sticky scope context.
- `nvim-treesitter-textobjects` adds structure-aware function/class jumps.

### Debugging

- Core: `nvim-dap`, `nvim-dap-ui`, `mason-nvim-dap`, `nvim-dap-go`.
- JS/TS: `nvim-dap-vscode-js` configured with `js-debug-adapter` and
  `pwa-node` launch/attach defaults.
- C/C++: `codelldb` installation via Mason and baseline launch profile
  (`Launch current file (codelldb)`).

### Testing

- `neotest` core with adapters:
  - `neotest-jest`
  - `neotest-vitest`
  - `neotest-gtest`

Notes for C++ tests:

- `neotest-gtest` needs executable mapping per project (use `:ConfigureGtest`
  from the neotest summary window).

### Formatting and linting

- Formatting via `conform.nvim`:
  - JS/TS/JSON/YAML: `prettierd` -> `prettier`
  - C/C++: `clang_format`
  - Lua: `stylua`
- Linting via `nvim-lint`:
  - markdown: `markdownlint`
  - dockerfile: `hadolint`
  - yaml / yaml.helm-values: `yamllint`

Linting is executable-aware for configured linters to avoid noisy diagnostics
when a linter binary is unavailable.

### Project workflow plugins

- `trouble.nvim`: focused diagnostics/issues panel
- `grug-far.nvim`: project-wide search/replace
- `oil.nvim`: optional file editing explorer (does not replace default explorer)
- `cmake-tools.nvim`: CMake build/run/test helpers (lazy and optional)

## Mason-managed tools and servers

This config ensures installation for key tools used by the workflows above,
including:

- `prettierd`, `prettier`, `clang-format`
- `hadolint`, `yamllint`, `markdownlint`, `stylua`
- `js-debug-adapter`, `codelldb`
- configured LSP servers from `servers` table (including `helm_ls`)

Check with `:Mason` and install manually if needed.

## Typical workflows

### JS/TS service workflow

1. Edit with LSP + treesitter context.
2. Run nearest test with `<leader>nr` or file with `<leader>nf`.
3. Debug test or code path with `<leader>nd` / `<F5>`.
4. Use `<leader>sR` for safe project refactors.

### C/C++ workflow

1. Navigate symbols with `<leader>jm/jk/jc/jC`.
2. Build/test with CMake mappings if project uses CMake.
3. Debug using existing DAP keys and select `Launch current file (codelldb)`.
4. Run gtest via neotest after `:ConfigureGtest` setup.

### Kubernetes/Helm workflow

1. Edit manifests with `yamlls` schema-backed completion/validation.
2. Edit charts/templates with Helm support (`helm_ls`, `vim-helm`).
3. Use `<leader>sR` for scoped multi-file YAML refactors.

## Troubleshooting

- Verify startup: `nvim --headless "+qa"`
- Verify health: `nvim --headless "+checkhealth" "+qa"`
- Verify LSP clients in current buffer: `:LspInfo`
- Verify formatter mapping: `:ConformInfo`
- Verify Mason state: `:Mason`
- Re-sync plugins: `:Lazy sync`

If a new feature appears missing, first confirm lazy-loading trigger
(keymap/filetype/command) was actually used.

## Help docs

This repo ships a Vim help file:

- `:help nvim-config`
- `:help nvimn-config`
