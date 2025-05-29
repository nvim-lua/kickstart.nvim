return {
  'ldelossa/nvim-dap-projects',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    local dap_projects = require 'nvim-dap-projects'
    dap_projects.search_project_config()
  end
}
