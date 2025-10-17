# Optional Plugins

These are optional plugins that are not enabled by default but may be useful for certain workflows.

## How to Enable

To enable an optional plugin, simply move it from `lua/plugins/optional/` to `lua/plugins/` and restart Neovim.

For example:
```bash
mv lua/plugins/optional/debug.lua lua/plugins/debug.lua
```

Or create a symlink:
```bash
ln -s optional/debug.lua lua/plugins/debug.lua
```

## Available Optional Plugins

- **indent-blankline.lua** - Adds indentation guides on blank lines
- **debug.lua** - DAP debugger for Go (and extensible to other languages)
- **lint.lua** - Linting with nvim-lint (markdown example included)

## Alternative Approach

You can also import these directly by adding to your `init.lua`:
```lua
require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.optional.debug' },  -- Enable debug plugin
})
```
