return { -- DAP for Godot - https://docs.godotengine.org/en/stable/tutorials/editor/external_editor.html#lsp-dap-support
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    dap.adapters.godot = {
      type = 'server',
      host = '127.0.0.1',
      port = 6006,
    }

    dap.configurations.gdscript = {
      {
        launch_game_instance = false,
        launch_scene = false,
        name = 'Launch scene',
        project = '${workspaceFolder}',
        request = 'launch',
        type = 'godot',
      },
    }
  end,
}
