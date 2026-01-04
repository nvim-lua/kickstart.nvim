-- lua/bootstrap/deps.lua
-- System-level deps for this config (Arch / pacman names)

return {
  -- bootstrap
  "neovim",
  "git",

  -- telescope / grep
  "ripgrep",
  "fd",

  -- builds native plugins (telescope-fzf-native, treesitter parsers, etc.)
  "base-devel",

  -- clipboard (Wayland)
  "wl-clipboard",
  -- X11 alternative (optional): "xclip",

  -- markdown-preview.nvim build/runtime
  "nodejs",
  "npm",

  -- toggleterm custom commands
  "lazygit",

  -- neo-tree external opener
  "imv",

  -- -- treesitter
  -- "tree-sitter-cli",
}

