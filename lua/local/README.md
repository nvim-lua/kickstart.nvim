# Local Overrides

Placing lua files in this folder gives you the power to provide overrides at various points during initialization. Files in this directory are not checked into source control, so feel free to include machine-specific configurations.

## Local Plugins
Similar to `lua/custom`, you can add plugins under the `plugins` folder.

## Override Default Plugin Options
To override plugin options (like telescope and lsp), create `overrides.lua` with a table of the settings you'd like to change. These will be merged during plugin initialization. For example
```lua
return {
  telescope = {
    opts = {
      pickers = {
        lsp_document_symbols = {
          symbol_width = 40,
        },
      },
    },
  },
  lsp = {},
}
```

## Before init.lua
The file `prehook.lua` will be loaded and run before anything in `init.lua`. Here you can set various vim options or register callback functions.

## After init.lua
The file `posthook.lua` will be loaded as the last step in `init.lua`, allowing you to override any of the default configuration in `init.lua`.
