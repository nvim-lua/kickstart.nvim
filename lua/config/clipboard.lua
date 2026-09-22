local remote = vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY

-- On the local host, Neovim uses the native provider (wl-copy, xclip, pbcopy,
-- etc.) for two-way sync, including inside Zellij. For a remote Zellij session,
-- OSC 52 is the only route back to the host clipboard. Zellij blocks OSC 52
-- reads by default, so paste falls back to Neovim's last yank in that case.
if vim.env.ZELLIJ and remote then
  local function paste()
    return vim.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"')
  end

  vim.g.clipboard = {
    name = "OSC 52 (Zellij)",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
elseif remote then
  vim.g.clipboard = "osc52"
end
