local java_21_home_dir = '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/bin/java'

require('java').setup()
require('lspconfig').jdtls.setup {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = java_21_home_dir .. '/bin/java',
            default = true,
          },
        },
      },
    },
  },
}

local function is_java_file()
  return vim.bo.filetype == 'java'
end

-- Function to run the Maven Wildfly redeploy command
local function redeploy_wildfly()
  vim.cmd '!mvn wildfly:redeploy'
end

-- Create the keymap
vim.keymap.set('n', '<leader>jd', function()
  if is_java_file() then
    redeploy_wildfly()
  else
    vim.notify 'This keymap only works for Java files.'
  end
end, { desc = 'Redeploy Wildfly' })
