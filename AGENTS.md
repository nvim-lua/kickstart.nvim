# AGENTS.md - Development Guide for AI Coding Agents

This file provides essential information for AI coding agents working in this Neovim configuration repository. It covers build/lint/test commands, code style guidelines, and project conventions.

## Build/Lint/Test Commands

### Linting
- **Command**: `:lua require('lint').try_lint()`
- **Description**: Run linting on current buffer using nvim-lint plugin
- **File types**: Currently configured for markdown files with `markdownlint`
- **Manual command**: `markdownlint-cli file.md` (if available globally)
- **CI**: GitHub Actions runs stylua formatting checks

### Formatting
- **Command**: `:lua require('conform').format({ async = true, lsp_format = 'fallback' })`
- **Keybinding**: `<leader>f` (normal/visual mode)
- **Formatters by filetype**: Lua: `stylua`, Python: `isort`/`black`, JavaScript: `prettier`, Go: `gofmt`, Rust: `rustfmt`, YAML: `yamlfix`, TOML: `taplo`, Terraform: `terraform_fmt`, Markdown: `markdownlint`

### Testing
- **Status**: No automated testing framework configured
- **Manual testing**: `:checkhealth` for Neovim health checks, `:Lazy` for plugin status
- **Single test execution**: N/A - use `:checkhealth` for comprehensive checks

## Code Style Guidelines

### Formatting (.stylua.toml)
- Column width: 160 characters, indent: 2 spaces, quote style: auto-prefer single quotes
- Call parentheses: omit when possible, simple statements: always collapse

### Imports & Naming
```lua
-- Standard require pattern
local module = require('module.name')

-- Conditional requires with error handling
local ok, plugin = pcall(require, 'optional.plugin')
if not ok then vim.notify('Plugin failed: ' .. result, vim.log.levels.WARN) end
```
- **Variables/Functions**: `camelCase` (e.g., `local bufferNumber = 1`, `function setupLsp() end`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `local MAX_RETRIES = 3`)
- **Modules**: `snake_case` for file names
- **Descriptive names**: Prefer clarity over brevity

### Error Handling & Comments
```lua
-- Safe plugin loading
local ok, result = pcall(require, 'plugin.name')
if not ok then
  vim.notify('Plugin failed to load: ' .. result, vim.log.levels.WARN)
  return
end
```
```lua
-- Single line comments, TODO/FIXME/NOTE
-- EmmyLua annotations: ---@param name type: description
---@param buffer number: The buffer number
---@return boolean: Success status
```

### Function & Table Style
```lua
-- Anonymous functions for keymaps
vim.keymap.set('n', '<leader>key', function() end, { desc = 'Description' })

-- Named functions for complex logic
local function setupPlugin() end

-- Consistent table formatting
local config = {
  option1 = true,
  nested = { setting = 42 },
  timeout_ms = 500,  -- Align when readable
}
```

### Autocommands & Keymaps
```lua
-- Use descriptive augroup names
local augroup = vim.api.nvim_create_augroup('plugin-name-feature', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'lua',
  callback = function() end,
})
```
```lua
-- Always include descriptions
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
-- Use leader key (<space>), group related mappings under prefixes
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
└── custom/             # User customizations
```

### Plugin Management
- **Manager**: lazy.nvim
- **Commands**: `:Lazy` (status), `:Lazy update`, `:Lazy clean`, `:Lazy profile`

### Commit Messages
- Follow conventional commit format
- Be descriptive about Neovim-specific changes and plugin references

### Plugin Configuration Pattern
```lua
return {
  'author/plugin-name',
  event = 'VimEnter',           -- Lazy loading trigger
  dependencies = { 'dep1', 'dep2' },
  opts = { setting = value },   -- Simple options
  config = function()           -- Complex setup
    local plugin = require('plugin')
    plugin.setup({ config })
  end,
  keys = {                      -- Keybindings
    { '<leader>key', function() end, desc = 'Description' },
  },
}
```

## Development Workflow

1. **Setup**: Clone repository and start Neovim
2. **Plugin management**: Use `:Lazy` commands
3. **Testing**: `:checkhealth`, `:Lazy`, manual testing
4. **Formatting**: `<leader>f` or conform commands
5. **Linting**: Use lint commands for supported file types
6. **Git workflow**: Standard branching, commit, and PR process

## Neovim-Specific Considerations

- **API usage**: Prefer `vim.api.nvim_*` over deprecated `vim.*`
- **Version compatibility**: Target latest stable Neovim
- **Plugin compatibility**: Check lazy-lock.json for pinned versions
- **Performance**: Mindful of startup time and memory usage
- **User experience**: Consider mouse and keyboard workflows

This guide ensures AI agents can contribute effectively while maintaining consistency with existing patterns and conventions.