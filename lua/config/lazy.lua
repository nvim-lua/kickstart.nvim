local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local path_separator = vim.fn.has("win32") == 1 and ";" or ":"

-- Make Mason-managed tools available to eager plugins during startup. Mason's
-- own setup does this too, but Treesitter loads before the LSP stack.
vim.env.PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin") .. path_separator .. vim.env.PATH

if not vim.uv.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Could not install lazy.nvim:\n" .. result)
  end
end

vim.opt.rtp:prepend(lazypath)

local spec = { { import = "plugins" } }
if pcall(require, "local.plugins") then
  table.insert(spec, { import = "local.plugins" })
end

require("lazy").setup({
  spec = spec,
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
