# AGENTS.md - Development Guide for AI Coding Agents

This file provides essential information for AI coding agents working in this Neovim configuration repository. It covers build/lint/test commands, code style guidelines, and project conventions to ensure consistent development.

## Build/Lint/Test Commands

### Linting
- **Command**: `:lua require('lint').try_lint()`
- **Description**: Run linting on current buffer using nvim-lint plugin
- **File types**: Currently configured for markdown files with `markdownlint`
- **Manual command**: `markdownlint-cli file.md` (if available globally)

### Formatting
- **Command**: `:lua require('conform').format({ async = true, lsp_format = 'fallback' })`
- **Keybinding**: `<leader>f` (normal/visual mode)
- **Description**: Format current buffer using conform.nvim
- **Formatters by filetype**:
  - Lua: `stylua`
  - Python: `isort`, `black`
  - JavaScript: `prettierd`, `prettier`
  - Go: `gofmt`
  - Rust: `rustfmt`
  - YAML: `yamlfix`
  - TOML: `taplo`
  - Terraform: `terraform_fmt`
  - Markdown: `markdownlint`

### Testing
- **Status**: No automated testing framework configured
- **Reason**: This is a Neovim configuration repository, not an application with unit tests
- **Manual testing**: `:checkhealth` for Neovim health checks, `:Lazy` for plugin status

### Single Test Execution
- **N/A**: No test suite exists for this configuration repository

### Health Checks
- **Command**: `:checkhealth`
- **Description**: Comprehensive Neovim health check including plugins and configuration

## Code Style Guidelines

### Formatting (.stylua.toml)
- **Column width**: 160 characters
- **Indent type**: Spaces
- **Indent width**: 2 spaces
- **Quote style**: Auto-prefer single quotes
- **Call parentheses**: None (omit when possible)
- **Simple statements**: Always collapse

### Imports
```lua
-- Standard require pattern
local module = require('module.name')

-- For plugins and external libraries
local telescope = require('telescope')
local conform = require('conform')

-- Conditional requires with error handling
local ok, plugin = pcall(require, 'optional.plugin')
if not ok then
  -- Handle missing plugin gracefully
end
```

### Naming Conventions
- **Variables**: `camelCase` (e.g., `local bufferNumber = 1`)
- **Functions**: `camelCase` (e.g., `function setupLsp() end`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `local MAX_RETRIES = 3`)
- **Modules**: `snake_case` for file names (e.g., `lsp_config.lua`)
- **Descriptive names**: Prefer clarity over brevity (e.g., `diagnosticConfig` over `diagCfg`)

### Error Handling
```lua
-- Safe plugin loading
local ok, result = pcall(require, 'plugin.name')
if not ok then
  vim.notify('Plugin failed to load: ' .. result, vim.log.levels.WARN)
  return
end

-- Safe function calls
local success, err = pcall(function()
  -- Potentially failing operation
end)
if not success then
  vim.notify('Operation failed: ' .. err, vim.log.levels.ERROR)
end
```

### Comments
```lua
-- Single line comments for explanations
-- Use for Neovim-specific behavior or complex logic

-- TODO: Future improvements
-- FIXME: Known issues
-- NOTE: Important information for maintainers

-- EmmyLua type annotations (when used)
---@param buffer number: The buffer number
---@return boolean: Success status
function processBuffer(buffer)
  -- Implementation
end
```

### Function Organization
```lua
-- Anonymous functions for keymaps
vim.keymap.set('n', '<leader>key', function()
  -- Implementation
end, { desc = 'Description of what this does' })

-- Named functions for complex logic
local function setupPlugin()
  -- Setup code here
end

-- Call setup functions
setupPlugin()
```

### Table/Configuration Style
```lua
-- Consistent indentation and alignment
local config = {
  option1 = true,
  option2 = 'value',
  nested = {
    setting = 42,
    enabled = false,
  },
  -- Align values when it improves readability
  timeout_ms = 500,
  max_retries = 3,
}

-- Plugin configurations follow this pattern
return {
  'plugin/name',
  opts = {
    -- Options here
  },
  config = function()
    -- Setup code
  end,
}
```

### Autocommands
```lua
-- Use descriptive augroup names
local augroup = vim.api.nvim_create_augroup('plugin-name-feature', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'lua',
  callback = function()
    -- Callback implementation
  end,
})
```

### Keymaps
```lua
-- Always include descriptions for discoverability
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
  desc = '[S]earch [H]elp'
})

-- Use leader key consistently (<space>)
-- Group related mappings under leader prefixes
-- Follow existing patterns: s=search, t=toggle, h=git hunk, etc.
```

## Project Conventions

### File Organization
```
lua/
├── options.lua          # Vim options and settings
├── keymaps.lua          # Keybindings
├── autocommands.lua     # Autocommands
├── lazy-config.lua      # Lazy plugin manager setup
├── plugins_config/      # Plugin-specific configurations
│   ├── lsp.lua         # LSP setup
│   ├── conform.lua     # Formatting setup
│   ├── telescope.lua   # Fuzzy finder setup
│   └── ...
└── custom/             # User customizations
```

### Plugin Management
- **Manager**: lazy.nvim
- **Check status**: `:Lazy`
- **Update**: `:Lazy update`
- **Clean**: `:Lazy clean`
- **Profile**: `:Lazy profile`

### Commit Messages
- Follow conventional commit format when possible
- Be descriptive about Neovim-specific changes
- Reference plugin names and features clearly

### Plugin Configuration Pattern
```lua
return {
  'author/plugin-name',
  event = 'VimEnter',           -- Lazy loading trigger
  dependencies = { 'dep1', 'dep2' },
  opts = {                       -- Simple options
    setting = value,
  },
  config = function()            -- Complex setup
    local plugin = require('plugin')
    plugin.setup({
      -- Configuration
    })
  end,
  keys = {                       -- Keybindings
    { '<leader>key', function() end, desc = 'Description' },
  },
}
```

## Development Workflow

1. **Setup**: Clone repository and start Neovim
2. **Plugin management**: Use `:Lazy` commands for plugin operations
3. **Testing changes**: `:checkhealth`, `:Lazy`, manual testing
4. **Formatting**: Use `<leader>f` or conform commands
5. **Linting**: Use lint commands for supported file types
6. **Git workflow**: Standard branching, commit, and PR process

## Neovim-Specific Considerations

- **API usage**: Prefer `vim.api.nvim_*` functions over deprecated `vim.*`
- **Version compatibility**: Target latest stable Neovim
- **Plugin compatibility**: Check lazy-lock.json for pinned versions
- **Performance**: Be mindful of startup time and memory usage
- **User experience**: Consider both mouse and keyboard workflows

This guide ensures AI agents can contribute effectively to this Neovim configuration while maintaining consistency with existing patterns and conventions.