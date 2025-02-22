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

return {
  'ThePrimeagen/harpoon',
  config = function()
    require('harpoon').setup()
    vim.keymap.set('n', '<leader>ha', require('harpoon.mark').add_file, { desc = '[H]arpoon [A]dd file' })
    vim.keymap.set(
      'n',
      '<leader>ht',
      require('harpoon.ui').toggle_quick_menu,
      { desc = '[H]arpoon [T]oggle quick menu' }
    )
    vim.keymap.set('n', '<leader>hn', require('harpoon.ui').nav_next, { desc = '[H]arpoon nav [N]ext' })
    vim.keymap.set('n', '<leader>hp', require('harpoon.ui').nav_prev, { desc = '[H]arpoon nav [P]revious' })
    vim.keymap.set('n', '<leader>h1', function()
      require('harpoon.ui').nav_file(1)
    end, { desc = '[H]arpoon goto file [1]' })
    vim.keymap.set('n', '<leader>h2', function()
      require('harpoon.ui').nav_file(2)
    end, { desc = '[H]arpoon goto file [2]' })
    vim.keymap.set('n', '<leader>h3', function()
      require('harpoon.ui').nav_file(3)
    end, { desc = '[H]arpoon goto file [3]' })
    vim.keymap.set('n', '<leader>h4', function()
      require('harpoon.ui').nav_file(4)
    end, { desc = '[H]arpoon goto file [4]' })
    vim.keymap.set('n', '<leader>hm1', function()
      require('harpoon.tmux').gotoTerminal(1)
    end, { desc = '[H]arpoon goto {T]mux window [1]' })
    vim.keymap.set('n', '<leader>hm2', function()
      require('harpoon.tmux').gotoTerminal(2)
    end, { desc = '[H]arpoon goto {T]mux window [2]' })
    vim.keymap.set('n', '<leader>hm3', function()
      require('harpoon.tmux').gotoTerminal(3)
    end, { desc = '[H]arpoon goto {T]mux window [3]' })
    vim.keymap.set('n', '<leader>hm4', function()
      require('harpoon.tmux').gotoTerminal(4)
    end, { desc = '[H]arpoon goto {T]mux window [4]' })
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
