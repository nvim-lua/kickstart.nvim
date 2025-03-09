-- This code configures Neovim's ShaDa file (short for Shared data) to be stored separately for each project.
-- The benefit of this approach is that each project gets its own independent ShaDa file, which means:
-- - Project-specific histories don't mix
-- - Marks and registers are isolated per project
-- - Buffer lists are maintained separately
-- - Less chance of conflicts between different projects
--
-- For example, if you're working on two different projects:
-- - Project A: `/home/user/projectA` -> Gets its own ShaDa file
-- - Project B: `/home/user/projectB` -> Gets its own ShaDa file
--
-- This keeps the project-specific data cleanly separated instead of having all projects share the same ShaDa file.

vim.opt.shadafile = (function()
  local data = vim.fn.stdpath 'data'

  local cwd = vim.fn.getcwd()
  cwd = vim.fs.root(cwd, '.git') or cwd

  local cwd_b64 = vim.base64.encode(cwd)

  local file = vim.fs.joinpath(data, 'project_shada', cwd_b64)
  vim.fn.mkdir(vim.fs.dirname(file), 'p')

  return file
end)()
