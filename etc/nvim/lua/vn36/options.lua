#!/usr/bin/lua
-- vim options
local o=vim.opt

local options={
    history=500,
    compatible=false,
    termguicolors=true,
    linebreak=true,
    -- pastetoggle="<F10>",
    pumheight=10,
    autoread=true,
    modelines=1,
    expandtab=true, shiftround=false,
    tabstop=4, softtabstop=4, shiftwidth=4, joinspaces=false,
    -- textwidth=79,
    inccommand="split",
    colorcolumn="80,160",
    scrolloff=2,
    showmatch=true, matchtime=1,
    list=true,
    splitbelow=true, splitright=true,
    hlsearch=true, ignorecase=true, incsearch=true, smartcase=true,
    updatetime=300, timeoutlen=300,
    number=true, relativenumber=true,
    switchbuf="usetab",
    nrformats="bin,hex",
    title=true, lazyredraw=true, showmode=false, hidden=true,
    autochdir=true,
    numberwidth=4,
    grepprg="rg --vimgrep",
    fileformats="unix,dos,mac",
    showtabline=2,
    laststatus=3,
    omnifunc="syntaxcomplete#Complete",
    sessionoptions="buffers,curdir,folds,tabpages,globals",
    foldmethod="marker", fillchars="fold:-",
    mouse="a",
    wrap=true,
    smoothscroll=true,
}

for k, v in pairs(options) do
    vim.opt[k]=v
end
o.shortmess:append"mrwsIcF" -- avoid longer messages and stuff
o.completeopt:append"menuone"
o.path:append"**"
-- Nice looking tab chracters: ▏│❯>→
o.listchars:append"tab:▏ "

-- vim.g.loaded_python3_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.diff_translations=0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
-- vim.g.netrw_list_hide=netrw_gitignore#Hide()
vim.g.python_space_error_highlight = 1
