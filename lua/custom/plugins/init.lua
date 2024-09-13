-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function create_plugin(plugin_name)
  return {
    plugin_name,
    opts = {},
    config = function() end,
  }
end

return {
  create_plugin 'ojroques/vim-oscyank',
  create_plugin 'thaerkh/vim-workspace',
  create_plugin 'fatih/vim-go',
  create_plugin 'preservim/nerdcommenter',
  create_plugin 'mtdl9/vim-log-highlighting',
}
