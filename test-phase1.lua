-- Test script for Phase 1 features
-- Run with: nvim -l test-phase1.lua

local test_results = {}
local function test(name, fn)
  local ok, err = pcall(fn)
  table.insert(test_results, {
    name = name,
    passed = ok,
    error = err
  })
  if ok then
    print("✓ " .. name)
  else
    print("✗ " .. name .. ": " .. tostring(err))
  end
end

-- Mock vim globals for testing
_G.vim = _G.vim or {
  fn = {
    stdpath = function(what)
      if what == 'config' then
        return os.getenv("HOME") .. "/.config/nvim"
      elseif what == 'data' then
        return os.getenv("HOME") .. "/.local/share/nvim"
      end
    end,
    expand = function(str)
      if str == '%:t' then return 'test.lua' end
      return str
    end,
    getcwd = function() return os.getenv("PWD") or "/tmp" end,
    mkdir = function() return true end,
  },
  api = {
    nvim_buf_get_lines = function() return {"line1", "line2"} end,
    nvim_create_buf = function() return 1 end,
    nvim_buf_set_lines = function() end,
    nvim_buf_set_option = function() end,
    nvim_open_win = function() return 1 end,
    nvim_win_set_option = function() end,
    nvim_buf_set_keymap = function() end,
  },
  bo = { filetype = 'lua' },
  o = { columns = 80, lines = 24 },
  loop = {
    fs_stat = function(path)
      if path:match('%.lua$') then
        return { type = 'file' }
      else
        return { type = 'directory' }
      end
    end
  },
  notify = function(msg, level)
    print("[NOTIFY] " .. tostring(msg))
  end,
  log = { levels = { INFO = 1, WARN = 2, ERROR = 3 } },
  json = {
    encode = function(t) return vim.inspect(t) end,
    decode = function(s) return {} end,
  },
  inspect = function(t)
    if type(t) == 'table' then
      return '{table}'
    end
    return tostring(t)
  end,
  tbl_deep_extend = function(behavior, ...)
    local result = {}
    for _, tbl in ipairs({...}) do
      for k, v in pairs(tbl) do
        result[k] = v
      end
    end
    return result
  end,
  tbl_isempty = function(t)
    return next(t) == nil
  end,
  wait = function() end,
}

-- Add to package path
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"

-- Test 1: Plugin loads without errors
test("Plugin loads", function()
  local claude = require('nvim-claude')
  assert(claude ~= nil, "Plugin module should load")
  assert(type(claude.setup) == 'function', "setup function should exist")
end)

-- Test 2: Configuration validation
test("Config validation accepts valid config", function()
  local claude = require('nvim-claude')
  claude.setup({
    tmux = {
      split_direction = 'v',
      split_size = 30,
    },
    agents = {
      max_agents = 3,
      cleanup_days = 5,
    }
  })
  assert(claude.config.tmux.split_direction == 'v')
  assert(claude.config.tmux.split_size == 30)
end)

test("Config validation rejects invalid config", function()
  local claude = require('nvim-claude')
  local captured_errors = {}
  local old_notify = vim.notify
  vim.notify = function(msg)
    table.insert(captured_errors, msg)
  end
  
  claude.setup({
    tmux = {
      split_direction = 'x',  -- Invalid
      split_size = 150,       -- Invalid
    }
  })
  
  vim.notify = old_notify
  assert(#captured_errors > 0, "Should have validation errors")
end)

-- Test 3: Registry operations
test("Registry can register and retrieve agents", function()
  local registry = require('nvim-claude.registry')
  registry.setup({})
  
  -- Mock file operations
  registry.save = function() return true end
  
  local id = registry.register("Test task", "/tmp/agent-test", "window123", "claude-test")
  assert(id ~= nil, "Should return agent ID")
  
  local agent = registry.get(id)
  assert(agent ~= nil, "Should retrieve agent")
  assert(agent.task == "Test task", "Should have correct task")
  assert(agent.status == "active", "Should be active")
end)

test("Registry tracks active count", function()
  local registry = require('nvim-claude.registry')
  registry.agents = {}  -- Clear
  
  registry.register("Task 1", "/tmp/agent1", "win1", "claude1")
  registry.register("Task 2", "/tmp/agent2", "win2", "claude2")
  
  assert(registry.get_active_count() == 2, "Should have 2 active agents")
  
  -- Mark one as completed
  local agents = registry.agents
  for id, _ in pairs(agents) do
    registry.update_status(id, "completed")
    break
  end
  
  assert(registry.get_active_count() == 1, "Should have 1 active agent")
end)

-- Test 4: Tmux text batching
test("Tmux send_text_to_pane creates temp file", function()
  local tmux = require('nvim-claude.tmux')
  local utils = require('nvim-claude.utils')
  
  -- Mock exec to capture commands
  local executed_commands = {}
  utils.exec = function(cmd)
    table.insert(executed_commands, cmd)
    return "", nil
  end
  
  -- Mock os.tmpname
  local tmpfile = "/tmp/test-nvim-claude.txt"
  os.tmpname = function() return tmpfile end
  
  tmux.send_text_to_pane("pane123", "Multi\nline\ntext")
  
  -- Should have load-buffer and paste-buffer commands
  local found_load = false
  local found_paste = false
  for _, cmd in ipairs(executed_commands) do
    if cmd:match("load%-buffer") then found_load = true end
    if cmd:match("paste%-buffer") then found_paste = true end
  end
  
  assert(found_load, "Should use tmux load-buffer")
  assert(found_paste, "Should use tmux paste-buffer")
end)

-- Test 5: Utils functions
test("Utils timestamp format", function()
  local utils = require('nvim-claude.utils')
  local ts = utils.timestamp()
  assert(ts:match("^%d%d%d%d%-%d%d%-%d%d%-%d%d%d%d%d%d$"), "Should match timestamp format")
end)

test("Utils agent dirname sanitization", function()
  local utils = require('nvim-claude.utils')
  local dirname = utils.agent_dirname("Fix bug in foo/bar.lua!")
  assert(not dirname:match("/"), "Should not contain slashes")
  assert(not dirname:match("!"), "Should not contain special chars")
  assert(dirname:match("^agent%-"), "Should start with agent-")
end)

-- Print summary
print("\n=== Test Summary ===")
local passed = 0
local failed = 0
for _, result in ipairs(test_results) do
  if result.passed then
    passed = passed + 1
  else
    failed = failed + 1
  end
end

print(string.format("Passed: %d", passed))
print(string.format("Failed: %d", failed))
print(string.format("Total:  %d", passed + failed))

os.exit(failed > 0 and 1 or 0)