#!/usr/bin/env bash
set -euo pipefail

mode="${1:-restore}"
if [[ "$mode" != "restore" && "$mode" != "update" ]]; then
  echo "usage: $0 [restore|update]" >&2
  exit 2
fi

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
nvim="${NVIM_BIN:-nvim}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/config"
ln -s "$root" "$tmp/config/nvim"

export XDG_CONFIG_HOME="$tmp/config"
export XDG_DATA_HOME="$tmp/data"
export XDG_STATE_HOME="$tmp/state"
export XDG_CACHE_HOME="$tmp/cache"
export NVIM_SKIP_TOOL_INSTALL=1

"$nvim" --headless "+Lazy! $mode" +qa
"$nvim" --headless \
  "+Lazy load all" \
  "+lua assert(vim.fn.exists(':Lazy') == 2, 'lazy.nvim did not load')" \
  "+lua if vim.v.errmsg ~= '' then print(vim.v.errmsg); vim.cmd('cquit 1') end" \
  +qa

"$nvim" --headless \
  "+checkhealth vim.deprecated" \
  "+silent write! $tmp/deprecated.txt" \
  +qa

if grep -q 'WARNING\|ERROR' "$tmp/deprecated.txt"; then
  cat "$tmp/deprecated.txt"
  exit 1
fi
