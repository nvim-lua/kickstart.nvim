local function setup_format_xml_command()
  local python_code = [[
import vim
import xml.dom.minidom

def format_xml():
    buf = vim.current.buffer
    xml_data = '\n'.join(buf)
    dom = xml.dom.minidom.parseString(xml_data)
    pretty_xml = dom.toprettyxml()
    formatted_lines = pretty_xml.split('\n')
    buf[:] = formatted_lines

format_xml()
]]

  vim.api.nvim_command("command! FormatXML :py3 " .. python_code)
end

-- Call the function to set up the command
setup_format_xml_command()

return {}
