return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      -- Ensure these tools are installed
      opts.ensure_installed = opts.ensure_installed or {}

      local ensure_installed = {
        'ts_ls',
        'biome',
        'docker_compose_language_service',
        'dockerls',
        'graphql',
        'jsonls',
        'sqlls',
        'yamlls',
        'eslint',
        'bashls',
      }

      -- Merge with existing ensure_installed if any
      for _, tool in ipairs(ensure_installed) do
        if not vim.tbl_contains(opts.ensure_installed, tool) then
          table.insert(opts.ensure_installed, tool)
        end
      end

      return opts
    end,
  },
}
