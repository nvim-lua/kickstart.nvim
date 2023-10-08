local function lsp_name(msg)
  msg = msg or "Inactive"
  local buf_clients = vim.lsp.get_active_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return "Inactive"
    end
    return msg
  end
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  return table.concat(buf_client_names, ", ")
end

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_y = {
        {
          lsp_name,
          icon = "",
        },
      },
    }
  },
}
