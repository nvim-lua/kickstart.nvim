
-- My personal mappings for this thingie.


-- Window size
vim.keymap.set('n','<leader>++','<C-w>10+', {desc = 'Do 10 bigger in vertical size'})
vim.keymap.set('n','<leader>--','<C-w>10-', {desc = 'Do 10 smaller in vertical size'})
vim.keymap.set('n','<leader>>>','<C-w>10>', {desc = 'Do 10 bigger in horizontal size'})
vim.keymap.set('n','<leader><<','<C-w>10<', {desc = 'Do 10 bigger in horizontal size'})

-- "In command line mode, <up> and <down> are more intelligent that <C-n> and
-- "<C-p>, because they remember the start of the command: that is
-- ":echo <up> will go to commands that started with echo, instead of just the
-- "previous.
-- This should work, I don't understand why it doesn't.
-- vim.keymap.set('c','<expr> <c-n>','wildmenumode() ? <Tab> : <down>', {desc = 'If wildmenu then do down instead of c-n'})
-- vim.keymap.set('c','<expr> <c-p>','wildmenumode() ? <s-Tab> : <up>', {desc = 'If wildmenu then do up instead of c-p'})
vim.keymap.set('c','<c-n>','<down>', {desc = 'If wildmenu then do down instead of c-n'})
vim.keymap.set('c','<c-p>','<up>', {desc = 'If wildmenu then do up instead of c-p'})

-- <C-l> redraws the screen in normal mode, this redraws and eliminates highlight
vim.keymap.set('n','<c-l>',':nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>', {desc = 'Redraw and remove highlight'})

-- Save file
vim.keymap.set('n','wf',':w<CR>', {desc = 'Save file'})

-- Escape from insert mode with kj
-- Do not do this in visual mode (interferes with selection)
-- or command mode (doesn't allow searching for kj)
vim.keymap.set('i','kj','<esc>:w<CR>', {desc = 'Save file'})

-- Open help in vertical split in the Right
-- Combine vertical[vert] and botright[bo] commands
vim.keymap.set('n','<leader>vh',':vertical botright help<CR>', {desc = 'Vertical help'})

-- Syntax name for current word
-- nnoremap <F10> :echo "hightlight<" . synIDattr(synID(line("."),col("."),1),"name") . '> transparent<'
-- \ . synIDattr(synID(line("."),col("."),0),"name") . "> SyntaxId<"
-- \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

-- nnoremap <leader>fe /\<error\>\|\<fail<cr>
-- nnoremap <leader>st :Startify<CR>

-- Switch horizontal split to vertical
-- Add <C-w>R to rotate it at the end
vim.keymap.set('n','<leader>htv','<C-w>t<C-w>H<C-w>R', {desc = 'Change horizontal split to vertical'})

-- Switch vertical split to horizontal
vim.keymap.set('n','<leader>vth','<C-w>t<C-w>K<C-w>R', {desc = 'Change vertical split to horizontal'})

-- nnoremap <leader>mm :make<CR>
-- nnoremap <leader>ma :AsyncRun :make<CR>
-- nnoremap <C-x><C-x><C-b> :AsyncRun cd\ $EMV_HOME\ &&\ bms\ build\ -b\ &&\ bms\ test<CR>

-- Select inner word.
vim.keymap.set('n','<space>','viw', {desc = 'Change vertical split to horizontal'})

-- #Navigate location list""""""""""""""""
-- nmap ln :lne<CR>
-- nmap lp  :lp<CR>
-- nnoremap <c-k><c-f> vi{=
-- Buffers
vim.keymap.set('n','bn',':bn<cr>', {desc = 'Next buffer'})
vim.keymap.set('n','bp',':bp<cr>', {desc = 'Previous buffer'})
vim.keymap.set('n','bf',':bf<cr>', {desc = 'First buffer'})
vim.keymap.set('n','bl',':bl<cr>', {desc = 'Last buffer'})
vim.keymap.set('n','bd',':bd<cr>', {desc = 'Delete buffer'})
-- Quickfix list
vim.keymap.set('n','cn',':cn<cr>', {desc = 'Next result'})
vim.keymap.set('n','cp',':cp<cr>', {desc = 'Previous result'})
vim.keymap.set('n','cf',':cfirst<cr>', {desc = 'First result'})
vim.keymap.set('n','cl',':clast<cr>', {desc = 'Last result'})
vim.keymap.set('n','co',':copen<cr>', {desc = 'Open quicfix list'})
vim.keymap.set('n','cq',':cclose<cr>', {desc = 'Close quickfix list'})
-- Location list
vim.keymap.set('n','ln',':lne<cr>', {desc = 'Change vertical split to horizontal'})
vim.keymap.set('n','lp',':lp<cr>', {desc = 'Change vertical split to horizontal'})

-- Edit and source vimrc
vim.keymap.set('n','<leader>sv',':source $MYVIMRC<CR>', {desc = 'Source vimrc file'})
vim.keymap.set('n','<leader>ev',':e $MYVIMRC<CR>', {desc = 'Change vimrc file'})

-- Make and recover default session.
vim.keymap.set('n','<F3>',': mksession! /home/$USER/.vim/files/nacho_vim_session<CR>', {desc = 'Make the default session'})
vim.keymap.set('n','<F4>',': source! /home/$USER/.vim/files/nacho_vim_session<CR>', {desc = 'Source the default session'})
