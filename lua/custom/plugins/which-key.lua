return {
  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        { '', group = 'Git [H]unk' },
        { '', group = '[W]orkspace' },
        { '', group = '[S]earch' },
        { '', group = '[C]ode' },
        { '', group = '[R]ename' },
        { '', group = '[T]oggle' },
        { '', group = '[D]ocument' },
        { '', desc = '', hidden = true, mode = { 'n', 'n', 'n', 'n', 'n', 'n', 'n' } },
      }
      -- visual mode
      require('which-key').register({
        { '', desc = '<leader>h', mode = 'v' },
      }, { mode = 'v' })
    end,
  },
}
