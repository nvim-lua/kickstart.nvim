--- @diagnostic disable: missing-fields -- disables annoying warnings

-- Must happen before plugins are required
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("angryluck.options")
require("angryluck.keymaps")
require("angryluck.commands")

-- [[ Install lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup(
  "angryluck.plugins",
  -- For multiple sources:
  -- {
  --   { import = "angryluck.plugins" },
  --   { import = "kickstart.plugins" },
  -- },
  {
    change_detection = { notify = false },
    ui = {
      -- Default icons, if no nerd font installed
      icons = vim.g.have_nerd_font and {} or {
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🔑",
        plugin = "🔌",
        runtime = "💻",
        require = "🌙",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
    },
  }
)

-- modeline
-- vim: tabstop=2 softtabstop=4 shiftwidth=2 expandtab
