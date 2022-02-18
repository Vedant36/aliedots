local function map(mode, l, r, opts)
  opts = opts or {noremap = true, silent = true}
  vim.keymap.set(mode, l, r, opts)
end

-- Leader
map('', '<Space>', '')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Uncategorised {{{1
map('n', '\\', 'ciw')
map('n', '<leader><leader>', '<C-^>')
map({'n', 'v'}, '<leader>c', '"+')
map({'n', 'v'}, '<leader>p', '"*')
map('n', '<leader>d', 'yyp')
map('n', '<leader>e', '<c-o>:r !date<cr><end>:<space>')
map('n', '<leader>e', '<Cmd>Lex 15<cr>')
map('n', '<leader>q', '@q')
map('n', '<leader>r', '<Cmd>sp | terminal<cr>')
map('n', '<leader>w', '<Cmd>w<cr>')
map('n', '<leader>y', '"*yiw')
map('n', '<leader>s', ':%s/', {noremap=true})
-- <f>unction keybinds {{{1
map('n', '<F3>', '<Cmd>so $MYVIMRC<cr>')
map('n', '<F6>', '<Cmd>set invspell<cr>')
map('i', '<F6>', '<C-O>:set invspell<cr>')
map('n', '<F7>', '<Cmd>sp | term time ./%:S<cr>')
map('n', '<F9>', '<Cmd>bufdo e!<cr>')
-- inoremaps {{{1
map('i', '<M-CR>', '<c-o>O')
map('i', '<c-w>', '<c-g>u<c-w>')
map('i', '<c-u>', '<c-g>u<c-u>')
map('i', 'jk', '<esc>')
map('i', 'kj', '<esc>')
map('i', '<m-tab>', '<c-f>')
-- readline keybinds
map('i', '<c-b>', '<Left>',    {noremap = true})
map('i', '<c-f>', '<Right>',   {noremap = true})
map('!', '<m-b>', '<C-Left>',  {noremap = true})
map('!', '<m-f>', '<C-Right>', {noremap = true})
-- buffer switching {{{1
map('n', '<m-`>', '<Plug>lightline#bufferline#go(1)')
map('n', '<m-1>', '<Plug>lightline#bufferline#go(2)')
map('n', '<m-2>', '<Plug>lightline#bufferline#go(3)')
map('n', '<m-3>', '<Plug>lightline#bufferline#go(4)')
map('n', '<m-4>', '<Plug>lightline#bufferline#go(5)')
map('n', '<m-5>', '<Plug>lightline#bufferline#go(6)')
map('n', '<m-6>', '<Plug>lightline#bufferline#go(7)')
map('n', '<m-7>', '<Plug>lightline#bufferline#go(8)')
map('n', '<m-8>', '<Plug>lightline#bufferline#go(9)')
map('n', '<m-9>', '<Cmd>bl<cr>')
map('n', '<tab>', '<Cmd>bn<cr>')
map('n', '<s-tab>', '<Cmd>bp<cr>')
map('n', 'L', '<Cmd>bn<cr>')
map('n', 'H', '<Cmd>bp<cr>')
-- window management {{{1
map('n', '<C-j>', '<C-w>w')
map('n', '<C-k>', '<C-w>W')
-- Note: no window agnostic keybinds exist because if there are three windows
-- side by side there is no way to tell which side should be {in,de}creasing
map('n', '<m-j>', '<Cmd>resize -2<cr>')
map('n', '<m-k>', '<Cmd>resize +2<cr>')
map('n', '<m-h>', '<Cmd>vertical resize -2<cr>')
map('n', '<m-l>', '<Cmd>vertical resize +2<cr>')
-- quick move between most used files {{{1
-- TODO: convert this to an operator because vim doesn't wait for keys after gt
map('n', 'gtv', '<Cmd>e $XDG_CONFIG_HOME/nvim/init.lua<cr>')
map('n', 'gtx', '<Cmd>e $XDG_CONFIG_HOME/sx/sxrc<cr>')
map('n', 'gtX', '<Cmd>e $XDG_CONFIG_HOME/X11/Xresources<cr>')
map('n', 'gtz', '<Cmd>e $XDG_CONFIG_HOME/zsh/.zshrc<cr>')
map('n', 'gta', '<Cmd>e $XDG_CONFIG_HOME/zsh/.zshaliases<cr>')
map('n', 'gte', '<Cmd>e $XDG_CONFIG_HOME/zsh/.zshenv<cr>')
map('n', 'gtf', '<Cmd>e $XDG_CONFIG_HOME/zsh/.zshfunctions<cr>')
map('n', 'gtt', '<Cmd>e $XDG_CONFIG_HOME/kitty/kitty.conf<cr>')
map('n', 'gtq', '<Cmd>e $XDG_CONFIG_HOME/qutebrowser/config.py<cr>')
map('n', 'gtd', '<Cmd>e $HOME/.local/opt/dwm/config.h<cr>')
map('n', 'gtE', '<Cmd>e $HOME/.local/lib/dotfiles/event.log<cr>')
map('n', 'gts', '<Cmd>e $HOME/.local/lib/dotfiles/setup.bash<cr>')
map('n', 'gth', '<Cmd>e $HISTFILE<cr>')
map('n', 'gty', '<Cmd>e ~/dox/zmisc_code/02-Plat.py<cr>')
-- Note: there is currently no way to automatically set global marks
--   so I have to overwrite gt(goto is nice to remember and who uses tabs?)
-- categorized but less so misc {{{1
map('n', ',', 'za')
map('x', ',', 'zf')
map('x', '>', '>gv')
map('x', '<', '<gv')
map('n', ';', ':', {noremap = true})
map('x', ';', ':', {noremap = true})
map('n', ':', ';')
map('n', 'ZA', '<Cmd>xa<cr>')
map('n', 'ZX', '<Cmd>qa<cr>')
map('n', 'ZS', '<Cmd>w !echo <bar> dmenu <bar> sudo -S tee %<cr>')
map('n', 'ZW', '<Cmd>cq<cr>')
-- terminal {{{1
map('t', '<c-x>', '<C-\\><C-N>')
map('t', '<c-j>', '<c-\\><c-n><c-w>w')
map('t', '<c-k>', '<c-\\><c-n><c-w>W')
