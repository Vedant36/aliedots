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
local bookmark_table = {
  v = '$XDG_CONFIG_HOME/nvim/init.lua',
  l = {
    a = '$XDG_CONFIG_HOME/nvim/lua/vn36/autocmd.lua',
    c = '$XDG_CONFIG_HOME/nvim/lua/vn36/colorscheme.lua',
    g = '$XDG_CONFIG_HOME/nvim/lua/vn36/gitsigns.lua',
    k = '$XDG_CONFIG_HOME/nvim/lua/vn36/keymaps.lua',
    l = '$XDG_CONFIG_HOME/nvim/lua/vn36/lualine.lua',
    o = '$XDG_CONFIG_HOME/nvim/lua/vn36/options.lua',
    t = {
      e = '$XDG_CONFIG_HOME/nvim/lua/vn36/telescope.lua',
      r = '$XDG_CONFIG_HOME/nvim/lua/vn36/treesitter.lua',
    },
  },
  p = '$XDG_CONFIG_HOME/nvim/lua/vn36/plugins.lua',

  t = {
    t = '~/dox/textfiles/todo.md',
    d = '~/dox/textfiles/data.md',
    s = '~/dox/textfiles/sites.md',
    a = '~/dox/textfiles/autocmd.md',
    m = '~/dox/textfiles/movies.md',
  },

  x = '$XDG_CONFIG_HOME/sx/sxrc',
  X = '$XDG_CONFIG_HOME/X11/Xresources',
  z = '$XDG_CONFIG_HOME/zsh/.zshrc',
  a = '$XDG_CONFIG_HOME/zsh/.zshaliases',
  e = '$XDG_CONFIG_HOME/zsh/.zshenv',
  f = '$XDG_CONFIG_HOME/zsh/.zshfunctions',
  k = '$XDG_CONFIG_HOME/kitty/kitty.conf',
  c = '$XDG_CONFIG_HOME/kitty/palenight.conf',
  q = '$XDG_CONFIG_HOME/qutebrowser/config.py',
  Q = '$XDG_CONFIG_HOME/qutebrowser/quickmarks',
  d = '$HOME/.local/opt/dwm/config.h',
  E = '$HOME/.local/lib/dotfiles/event.log',
  s = '$HOME/.local/lib/dotfiles/setup.bash',
  h = '$HISTFILE',
  y = '~/dox/Python/platformer_2/Plat.py',
}
local function bookmark(arg)
  local bookmarks = arg or bookmark_table
  -- print keys in alphabetical order
  local prompt="Available keys: "
  for i=97,122 do
    local tmp = string.char(i)
    if bookmarks[tmp] then prompt = prompt..tmp end
    if bookmarks[tmp:upper()] then prompt = prompt..tmp:upper() end
  end
  print(prompt..'> ')
  -- posibble errors: Keyboard Interrupt
  local ok, str = pcall(vim.fn.getcharstr)
  if ok then
    local val = bookmarks[str]
    if str == '\n' or str == '\r' then
      P(bookmarks)
    elseif val == nil then
      vim.notify("No such bookmark exists yet!", "warn")
    elseif type(val) == 'table' then
      bookmark(val)
    else
      pcall(vim.cmd, "edit "..val)
    end
  end
  print(" ") -- clear commandline after ending
end
map('n', 'gt', bookmark)
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
