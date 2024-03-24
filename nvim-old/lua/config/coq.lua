local M = {}

function M.setup()
  local coq = require "coq"
  coq.Now() -- Start coq

  -- 3party sources
  require "coq_3p" {
    { src = "nvimlua", short_name = "nLUA", conf_only = false }, -- Lua
    { src = "bc", short_name = "MATH", precision = 6 }, -- Calculator
    { src = "cow", trigger = "!cow" }, -- cow command
    { src = "figlet", trigger = "!big" }, -- figlet command
    {
      src = "repl",
      sh = "zsh",
      shell = { p = "perl", n = "node" },
      max_lines = 99,
      deadline = 500,
      unsafe = { "rm", "poweroff", "mv" },
    },
  }
end

return M
