# ToggleTerm.nvim Guide: A Flexible Terminal Integration for Neovim

ToggleTerm is a highly customizable plugin for Neovim that provides enhanced terminal functionality, making it easy to toggle and use multiple terminals directly within your Neovim environment.

## Features

- Multiple terminal instances with persistent state
- Different terminal layouts (floating, horizontal split, vertical split, tab)
- Custom terminal commands and automation
- Terminal toggling with a single keystroke
- Seamless integration with existing Neovim workflow
- Support for terminal-specific keymaps
- Custom commands for specific applications (like lazygit)

## Quick Start Guide

### Basic Usage

1. **Toggle Default Terminal**: Press `<Ctrl-\>` to show/hide the terminal
2. **Exit Terminal Mode**: Press `<Esc>` to switch from terminal mode to normal mode
3. **Navigate Away**: Use regular Neovim window commands (`<Ctrl-w>h/j/k/l`) when in normal mode

### Terminal Layouts

Press these keys in normal mode:

- `<leader>tf` - Toggle floating terminal (appears in the center of your screen)
- `<leader>th` - Toggle horizontal terminal (split at bottom)
- `<leader>tv` - Toggle vertical terminal (split on right)
- `<leader>tt` - Toggle terminal in new tab

### Multiple Terminal Instances

- `<leader>t1` - Toggle terminal #1
- `<leader>t2` - Toggle terminal #2
- `<leader>t3` - Toggle terminal #3

You can have multiple terminal instances running different commands simultaneously.

### Special Terminal Integrations

- `<leader>lg` - Toggle LazyGit in a floating window
- `<leader>py` - Toggle Python REPL in a horizontal split

## Terminal Navigation and Control

When in a terminal buffer:

| Keybinding | Action                                   |
| ---------- | ---------------------------------------- |
| `<Esc>`    | Exit terminal mode and enter normal mode |
| `<C-h>`    | Move focus to the window on the left     |
| `<C-j>`    | Move focus to the window below           |
| `<C-k>`    | Move focus to the window above           |
| `<C-l>`    | Move focus to the window on the right    |
| `<C-v>`    | Paste from clipboard in terminal mode    |

## Advanced Usage

### Creating Custom Terminal Commands

You can define custom terminals for specific commands in the configuration file. Here's an example:

```lua
-- Creating a custom terminal for a Node.js REPL
local node = Terminal:new({
  cmd = "node",
  direction = "horizontal",
  close_on_exit = false,
})

function _NODE_TOGGLE()
  node:toggle()
end

vim.keymap.set('n', '<leader>nd', '<cmd>lua _NODE_TOGGLE()<CR>', {noremap = true})
```

### Running Commands in Terminal

You can run commands in a terminal directly from Neovim:

```lua
-- Example: Run npm commands
local npm_install = Terminal:new({
  cmd = "npm install",
  dir = "git_dir",
  direction = "float",
  close_on_exit = true,
  on_open = function(term)
    vim.cmd("startinsert!")
  end,
})

function _NPM_INSTALL()
  npm_install:toggle()
end

vim.keymap.set('n', '<leader>ni', '<cmd>lua _NPM_INSTALL()<CR>', {noremap = true})
```

### Terminal-Specific Settings

For custom terminal settings:

```lua
local opts = {
  shell = '/bin/zsh', -- Set specific shell
  env = { ['VAR'] = 'VALUE' }, -- Set environment variables
  clear_env = false, -- Don't clear environment between terminals
}

require("toggleterm").setup(opts)
```

## Troubleshooting Common Issues

### Terminal Not Opening

- Ensure the keybinding (`<Ctrl-\>`) isn't overridden by another plugin
- Check if your terminal size settings are valid (they should be numbers or functions)

### Terminal Looks Incorrect

- Try changing the `border` option in `float_opts` to another value
- Adjust the `shading_factor` if the terminal is too dark/light

### Terminal Not Persisting History

- Check that `persist_size` is set to `true`
- Try setting `close_on_exit = false` to maintain session history

## Customizing Your Terminal Experience

### Changing The Default Terminal Layout

To change the default terminal appearance, modify the `direction` option:

```lua
direction = "horizontal", -- or "vertical", "float", "tab"
```

### Customizing Terminal Appearance

```lua
float_opts = {
  border = "double", -- Try "single", "double", "curved", etc.
  width = 80, -- Fixed width for floating window
  height = 20, -- Fixed height for floating window
},
```

### Customizing Terminal Behavior

```lua
start_in_insert = true, -- Start in insert mode
persist_mode = true, -- Remember if terminal was in insert mode
auto_scroll = true, -- Auto-scroll to bottom when entering terminal
```

## Integration with Other Plugins

ToggleTerm works well with:

- **lazygit**: For Git operations (already configured in our setup)
- **vim-test**: Run tests in a terminal
- **nnn**: File manager in a terminal
- **Any CLI tool**: MySQL client, HTTP clients, etc.

## Conclusion

With ToggleTerm.nvim, you can keep your workflow within Neovim while having powerful terminal functionality at your fingertips. The plugin is highly customizable, allowing you to tailor it precisely to your needs.

For more details and advanced configurations, visit the [ToggleTerm GitHub page](https://github.com/akinsho/toggleterm.nvim).
