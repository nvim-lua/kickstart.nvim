return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    ft = 'python', -- Load only for Python files
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    opts = {
      settings = {
        options = {
          -- If you put the callback here as a global option, its used for all searches (including the default ones by the plugin)
          on_telescope_result_callback = function(filename)
            return filename:gsub('/bin/python', '')
          end,
        },
        debug = true,

        search = {
          my_venvs = {
            command = 'fd -H -I python$ ~/Documents/Projects/',
            on_telescope_result_callback = function(filename)
              return filename:gsub('/bin/python', '')
            end,
          },
          my_conda_envs = {
            command = 'fd -t l python$ /usr/local/Caskroom/miniforge/base/envs/',
            on_telescope_result_callback = function(filename)
              return filename:gsub('/bin/python', '')
            end,
          },
        },
      },
    },
    keys = {
      { ',v', '<cmd>VenvSelect<cr>' },
    },
  },
}
