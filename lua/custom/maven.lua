-- Maven command runner with UI
local M = {}

-- Store last command for quick re-run
M.last_command = nil

-- Common Maven phases and goals
M.maven_commands = {
  -- Lifecycle Phases
  { name = "clean", desc = "Clean the project (remove target/)" },
  { name = "validate", desc = "Validate project structure" },
  { name = "compile", desc = "Compile source code" },
  { name = "test", desc = "Run unit tests" },
  { name = "test-compile", desc = "Compile test sources" },
  { name = "package", desc = "Package compiled code (JAR/WAR)" },
  { name = "verify", desc = "Run integration tests" },
  { name = "install", desc = "Install package to local repository" },
  { name = "deploy", desc = "Deploy to remote repository" },

  -- Common Combined Commands
  { name = "clean compile", desc = "Clean and compile" },
  { name = "clean test", desc = "Clean and test" },
  { name = "clean package", desc = "Clean and package" },
  { name = "clean install", desc = "Clean and install" },

  -- Plugin Goals
  { name = "dependency:tree", desc = "Display dependency tree" },
  { name = "dependency:analyze", desc = "Analyze dependencies" },
  { name = "versions:display-dependency-updates", desc = "Check for dependency updates" },
  { name = "help:effective-pom", desc = "Show effective POM" },

  -- Spring Boot specific (if applicable)
  { name = "spring-boot:run", desc = "Run Spring Boot application" },

  -- Testing specific
  { name = "test -Dtest=", desc = "Run specific test class (specify after =)", custom_input = true },
  { name = "test -Dtest=*Test", desc = "Run all test classes" },
  { name = "surefire-report:report", desc = "Generate test report" },
}

-- Execute Maven command
function M.execute_maven(cmd, opts)
  opts = opts or {}

  -- Check if mvn exists
  local mvn_cmd = vim.fn.executable("mvn") == 1 and "mvn" or nil
  if not mvn_cmd then
    vim.notify("Maven (mvn) not found in PATH. Install with: brew install maven", vim.log.levels.ERROR)
    return
  end

  -- Store last command
  M.last_command = cmd

  -- Determine if we're in a Maven project
  local pom_exists = vim.fn.filereadable(vim.fn.getcwd() .. "/pom.xml") == 1
  if not pom_exists then
    vim.notify("No pom.xml found in current directory: " .. vim.fn.getcwd(), vim.log.levels.WARN)
    local proceed = vim.fn.confirm("Run Maven anyway?", "&Yes\n&No", 2)
    if proceed ~= 1 then
      return
    end
  end

  local full_cmd = "mvn " .. cmd

  -- Choose display method based on preference
  if opts.background then
    -- Run in background, show in quickfix
    vim.notify("Running: " .. full_cmd, vim.log.levels.INFO)
    vim.fn.setqflist({}, 'r', { title = full_cmd, lines = {} })
    vim.cmd("copen")

    vim.fn.jobstart(full_cmd, {
      on_stdout = function(_, data)
        if data then
          vim.fn.setqflist({}, 'a', { lines = data })
        end
      end,
      on_stderr = function(_, data)
        if data then
          vim.fn.setqflist({}, 'a', { lines = data })
        end
      end,
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.notify("Maven command completed successfully", vim.log.levels.INFO)
        else
          vim.notify("Maven command failed with exit code: " .. exit_code, vim.log.levels.ERROR)
        end
      end,
    })
  else
    -- Run in terminal split
    vim.cmd("botright 15split | terminal " .. full_cmd)
    vim.cmd("startinsert")
  end
end

-- Show Maven menu using vim.ui.select
function M.show_menu()
  local choices = {}
  for i, cmd in ipairs(M.maven_commands) do
    choices[i] = string.format("%-40s | %s", cmd.name, cmd.desc)
  end

  vim.ui.select(choices, {
    prompt = "Select Maven command:",
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    if not choice then
      return
    end

    local selected = M.maven_commands[idx]

    -- Handle custom input commands
    if selected.custom_input then
      vim.ui.input({
        prompt = "Enter Maven command: ",
        default = selected.name,
      }, function(input)
        if input and input ~= "" then
          M.execute_maven(input)
        end
      end)
    else
      M.execute_maven(selected.name)
    end
  end)
end

-- Run last Maven command
function M.run_last()
  if M.last_command then
    vim.notify("Re-running: mvn " .. M.last_command, vim.log.levels.INFO)
    M.execute_maven(M.last_command)
  else
    vim.notify("No previous Maven command to run", vim.log.levels.WARN)
    M.show_menu()
  end
end

-- Quick command to run specific test
function M.run_test(test_name)
  if test_name then
    M.execute_maven("test -Dtest=" .. test_name)
  else
    -- Try to infer test name from current file
    local current_file = vim.fn.expand("%:t:r") -- filename without extension
    if current_file:match("Test$") or current_file:match("Tests$") then
      vim.ui.input({
        prompt = "Test class name:",
        default = current_file,
      }, function(input)
        if input and input ~= "" then
          M.execute_maven("test -Dtest=" .. input)
        end
      end)
    else
      M.execute_maven("test")
    end
  end
end

-- User command to run Maven
vim.api.nvim_create_user_command("Maven", function(opts)
  if opts.args and opts.args ~= "" then
    M.execute_maven(opts.args)
  else
    M.show_menu()
  end
end, {
  nargs = "*",
  desc = "Run Maven command",
  complete = function()
    local completions = {}
    for _, cmd in ipairs(M.maven_commands) do
      table.insert(completions, cmd.name)
    end
    return completions
  end,
})

-- User command to run tests
vim.api.nvim_create_user_command("MavenTest", function(opts)
  M.run_test(opts.args ~= "" and opts.args or nil)
end, {
  nargs = "?",
  desc = "Run Maven tests",
})

return M
