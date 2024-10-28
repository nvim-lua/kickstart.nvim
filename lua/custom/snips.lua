local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

-- Function to generate the namespace based on the file path
local function generate_namespace()
  local file_path = vim.fn.expand '%:p:h' -- Get the file path of the current buffer
  -- Adjust 'src' or 'project_root' based on your directory structure
  local namespace = file_path:gsub('.*src[\\/]', ''):gsub('[\\/]', '.') -- Replace slashes with dots
  return 'namespace ' .. namespace
end

-- Function to get the file name (without extension) as the class name
local function get_class_name()
  return vim.fn.expand '%:t:r' -- Get the file name without the extension
end

-- Snippet for C# class generation
ls.add_snippets('cs', {
  s('myclass', { -- Updated the trigger from 'class' to 'myclass'
    -- Insert the namespace based on the file path
    f(generate_namespace, {}),
    t { '', '' }, -- Line break after namespace
    -- Generate class name based on file name
    t 'public class ',
    f(get_class_name, {}),
    t { '', '{', '\t' },
    ls.insert_node(0), -- Cursor here
    t { '', '}' }, -- End of class
  }),
})
