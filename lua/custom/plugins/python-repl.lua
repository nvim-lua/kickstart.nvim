# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

-- python-debugging.lua: Debugging Python code with DAP
--

return {
  -- PYTHON REPL
  -- A basic REPL that opens up as a horizontal split
  -- - use `<leader>i` to toggle the REPL
  -- - use `<leader>I` to restart the REPL
  -- - `+` serves as the "send to REPL" operator. That means we can use `++`
  -- to send the current line to the REPL, and `+j` to send the current and the
  -- following line to the REPL, like we would do with other vim operators.
  {
    'Vigemus/iron.nvim',
    keys = {
      { '<leader>i', vim.cmd.IronRepl, desc = '󱠤 Toggle REPL' },
      { '<leader>I', vim.cmd.IronRestart, desc = '󱠤 Restart REPL' },

      -- these keymaps need no right-hand-side, since that is defined by the
      -- plugin config further below
      { '+', mode = { 'n', 'x' }, desc = '󱠤 Send-to-REPL Operator' },
      { '++', desc = '󱠤 Send Line to REPL' },
    },

    -- since irons's setup call is `require("iron.core").setup`, instead of
    -- `require("iron").setup` like other plugins would do, we need to tell
    -- lazy.nvim which module to via the `main` key
    main = 'iron.core',

    opts = {
      keymaps = {
        send_line = '++',
        visual_send = '+',
        send_motion = '+',
      },
      config = {
        -- This defines how the repl is opened. Here, we set the REPL window
        -- to open in a horizontal split to the bottom, with a height of 10.
        repl_open_cmd = 'horizontal bot 10 split',

        -- This defines which binary to use for the REPL. If `ipython` is
        -- available, it will use `ipython`, otherwise it will use `python3`.
        -- since the python repl does not play well with indents, it's
        -- preferable to use `ipython` or `bypython` here.
        -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
        repl_definition = {
          python = {
            command = function()
              local ipythonAvailable = vim.fn.executable('ipython') == 1
              local binary = ipythonAvailable and 'ipython' or 'python3'
              return { binary }
            end,
          },
        },
      },
    },
  },
}
