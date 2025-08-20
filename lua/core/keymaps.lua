--[lua/core/keymaps.lua]

-- See `:help vim.keymap.set()` for more information

-- [[ General Keymaps ]]

-- Function to compile and run the current file based on its filetype
local function compile_and_run()
-- Save the current file before running
vim.cmd('w')

local filetype = vim.bo.filetype
local command

-- You can add more languages and their commands here
if filetype == 'cpp' then
    command = 'clang++ % -o %< && ./%<'
    elseif filetype == 'c' then
        command = 'clang % -o %< && ./%<'
        elseif filetype == 'python' then
            command = 'python3 %'
            elseif filetype == 'typescript' then
                -- Use ts-node if available, otherwise fallback to node
                command = vim.fn.executable('ts-node') == 1 and 'ts-node %' or 'node %'
                elseif filetype == 'javascript' then
                    command = 'node %'
                    elseif filetype == 'lua' then
                        command = 'lua %'
                        else
                            vim.notify('No compile/run command configured for filetype: ' .. filetype, vim.log.levels.WARN)
                            return
                            end

                            -- Execute the command in a new terminal buffer
                            vim.cmd('vsplit | terminal ' .. command)
                            end

                            vim.keymap.set('n', '<F5>', compile_and_run, { desc = 'Compile and Run File' })

                            -- Clear highlights on search when pressing <Esc> in normal mode
                            --  See `:help hlsearch`
                            vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

                            -- Diagnostic keymaps
                            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

                            -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
                            -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
                            -- is not what someone will guess without a bit more experience.
                            --
                            -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
                            -- or just use <C-\><C-n> to exit terminal mode
                            vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

                            -- TIP: Disable arrow keys in normal mode
                            -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
                            -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
                            -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
                            -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

                            -- Keybinds to make split navigation easier.
                            --  Use CTRL+<hjkl> to switch between windows
                            --
                            --  See `:help wincmd` for a list of all window commands
                            vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
                            vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
                            vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
                            vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

                            -- [[ Autocommands ]]
                            --  See `:help lua-guide-autocommands`

                            -- Highlight when yanking (copying) text
                            --  Try it with `yap` in normal mode
                            --  See `:help vim.highlight.on_yank()`
                            vim.api.nvim_create_autocmd('TextYankPost', {
                                desc = 'Highlight when yanking (copying) text',
                                                          group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
                                                          callback = function()
                                                          vim.highlight.on_yank()
                                                          end,
                            })

                            -- (The extra brace at the end has been removed)
