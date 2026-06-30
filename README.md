# River's Neovim config

This configuration targets **Neovim 0.12.x** and pins the complete plugin graph
in `lazy-lock.json`. Normal editor startup never updates plugins. A weekly GitHub
Actions job proposes lockfile updates in a pull request, and the same isolated
smoke test runs on every push and pull request.

That gives updates a rollback point and keeps upstream breaking changes out of
the working editor until they pass CI. It cannot make arbitrary upstream
changes risk-free, but it turns them into reviewed, reversible changes instead
of surprise startup failures.

## Install

Required: Neovim 0.12.x, Git, a C compiler, `make`, `unzip`, and `ripgrep`. A Nerd
Font is recommended. Language servers, formatters, and debuggers are installed
through Mason on first interactive startup.

```sh
git clone https://github.com/RiverMatsumoto/kickstart.nvim.git \
  "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

To try it without replacing another config:

```sh
git clone https://github.com/RiverMatsumoto/kickstart.nvim.git ~/.config/nvim-river
NVIM_APPNAME=nvim-river nvim
```

## Updates

- Do not use `:Lazy update` on the main branch for routine updates.
- Merge the automated `chore: update locked Neovim plugins` pull request after
  its checks pass.
- To test an update locally, run `scripts/nvim-test.sh update`. This uses
  isolated data/cache directories and changes only `lazy-lock.json`.
- Restore the committed versions at any time with `:Lazy restore`.

The Neovim version is pinned in `.nvim-version`. Upgrade Neovim separately from
plugin updates so failures have one clear cause.

## Design choices

The version guard, modular setup conventions, native `vim.lsp.config` API, and
current Treesitter `main` API follow the useful compatibility patterns in
[jdhao/nvim-config](https://github.com/jdhao/nvim-config). The system package
installer is intentionally not run from Neovim; editor startup should never ask
for administrator privileges or mutate the operating system.
