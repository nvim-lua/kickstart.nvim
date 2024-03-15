return {
  'numToStr/FTerm.nvim',
  config = function()
    require('FTerm').setup {
      dimensions = {
        height = 0.6,
        width = 0.6,
      },
      -- Initial cmd setting is generic, will be dynamically updated later
      cmd = 'Powershell.exe',
    }

    -- Custom function to toggle FTerm with dynamic working directory
    local function toggle_ft_with_cwd()
      local cwd = vim.fn.getcwd()
      -- Update the cmd to change directory to cwd upon opening
      require('FTerm'):setup {
        cmd = 'Powershell.exe -NoLogo -NoExit -Command "cd \'' .. cwd .. '\'"',
      }
      -- Toggle FTerm after updating the command
      require('FTerm').toggle()
    end

    -- Keymap to use the custom toggle function
    vim.keymap.set('n', '<leader>tt', toggle_ft_with_cwd, { noremap = true, silent = true, desc = '[T]oggle [T]erminal' })
  end,
}
