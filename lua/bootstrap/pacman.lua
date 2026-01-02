-- ~/.config/nvim/lua/bootstrap/pacman.lua
-- Fix1: run pacman inside a Neovim terminal so sudo has a real TTY.

local M = {}

local function has_exe(exe)
  return vim.fn.executable(exe) == 1
end

local function pacman_has(pkg)
  local out = vim.fn.system({ "pacman", "-Qi", pkg })
  return vim.v.shell_error == 0 and out ~= nil and out ~= ""
end

local function missing_pkgs(pkgs)
  local missing = {}
  for _, p in ipairs(pkgs) do
    if not pacman_has(p) then
      table.insert(missing, p)
    end
  end
  return missing
end

local function shell_escape_arg(s)
  -- minimal quoting for a shell command string
  return "'" .. tostring(s):gsub("'", [['"'"']]) .. "'"
end

local function open_install_terminal(pkgs)
  if #pkgs == 0 then
    return true
  end

  if not has_exe("sudo") then
    vim.notify("Missing `sudo`; cannot auto-install pacman deps.", vim.log.levels.ERROR)
    return false
  end

  -- Build a single shell command so sudo prompts normally.
  local parts = { "sudo", "pacman", "-S", "--needed" }
  for _, p in ipairs(pkgs) do
    table.insert(parts, shell_escape_arg(p))
  end
  local cmd = table.concat(parts, " ")

  vim.notify("Opening terminal to install:\n" .. table.concat(pkgs, ", "), vim.log.levels.WARN)

  -- Open a terminal split and run the command. User can enter sudo password normally.
  vim.cmd("botright 15split")
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")

  return true
end

function M.check()
  if not has_exe("pacman") then
    vim.notify("pacman not found. This bootstrap is Arch-specific.", vim.log.levels.WARN)
    return {}
  end
  local deps = require("bootstrap.deps")
  return missing_pkgs(deps)
end

function M.install(opts)
  opts = opts or {}
  local miss = M.check()
  if #miss == 0 then
    if not opts.quiet then
      vim.notify("All system deps already installed.", vim.log.levels.INFO)
    end
    return true
  end

  local prompt = "Missing system deps:\n\n"
    .. table.concat(miss, "\n")
    .. "\n\nOpen a terminal and run sudo pacman to install them?"

  local ok = true
  if not opts.force then
    ok = (vim.fn.confirm(prompt, "&Yes\n&No", 1) == 1)
  end
  if not ok then
    return false
  end

  return open_install_terminal(miss)
end

-- Commands
vim.api.nvim_create_user_command("DepsCheck", function()
  local miss = M.check()
  if #miss == 0 then
    vim.notify("DepsCheck: OK (no missing packages).", vim.log.levels.INFO)
  else
    vim.notify("DepsCheck missing:\n" .. table.concat(miss, ", "), vim.log.levels.WARN)
  end
end, {})

vim.api.nvim_create_user_command("DepsInstall", function()
  M.install({ force = true })
end, {})

-- Run once per session (prompt-based)
if vim.g.__deps_bootstrap_ran ~= true then
  vim.g.__deps_bootstrap_ran = true
  M.install({ force = false, quiet = true })
end

return M
