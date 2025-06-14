--[[
  JDTLS Configuration
  
  This file configures the Java Development Tools Language Server (jdtls)
  to fix deprecation warnings and JVM restrictions.
]]

return {
  -- Override the default jdtls setup
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Configure jdtls with the necessary JVM arguments to fix warnings
      setup = {
        jdtls = function(_, opts)
          -- Get existing Java arguments or initialize an empty table
          local java_args = opts.cmd or {}
          
          -- Add the necessary JVM arguments to fix the deprecation warnings
          local fixed_java_args = {
            -- Enable unrestricted access to JDK internal API
            "--enable-native-access=ALL-UNNAMED",
            -- Explicitly allow these modules to eliminate warnings
            "--add-modules=jdk.incubator.vector",
            -- Suppress deprecation warnings
            "-Dsun.misc.Unsafe.allowDeprecation=true",
          }
          
          -- Find the java command index in the cmd array
          local java_cmd_index = 1
          for i, arg in ipairs(java_args) do
            if arg:match("java$") then
              java_cmd_index = i
              break
            end
          end
          
          -- Insert our arguments after the java command
          for i, arg in ipairs(fixed_java_args) do
            table.insert(java_args, java_cmd_index + i, arg)
          end
          
          -- Update the command
          opts.cmd = java_args
          
          -- Return false to let the default handler continue
          return false
        end,
      },
    },
  }
}
