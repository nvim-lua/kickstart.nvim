vim.diagnostic.config({
  virtual_text = { source = 'if_many', spacing = 2, format = function(d) return d.message end, current_line = nil },
  underline = { severity = vim.diagnostic.severity.ERROR },
})
vim.diagnostic.config({ virtual_text = { current_line = true }, underline = false })
local cfg = vim.diagnostic.config()
print(vim.inspect(cfg.virtual_text))
print(vim.inspect(cfg.underline))
vim.cmd('qa!')
