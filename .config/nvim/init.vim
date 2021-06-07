" vim settings
" .vimrc {{{1
scriptencoding utf-8
set encoding=utf-8
set history=500
set nocompatible
set path+=**
" set mouse=a
set autoread
set nomodeline modelines=0
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent nojoinspaces
set colorcolumn=
set list " lcs=tab:❯\ ,trail:-,nbsp:+
set listchars=tab:→\ ,eol:\ ,trail:·
set splitbelow splitright
set hlsearch ignorecase incsearch smartcase
set updatetime=300 timeoutlen=300
set number relativenumber
set switchbuf=usetab
set nrformats=alpha,bin,hex,octal
set title lazyredraw noshowmode hidden
set autochdir
set numberwidth=4
set grepprg=rg\ --color=never
set fileformats=unix,dos,mac
set showtabline=2
set omnifunc=syntaxcomplete#Complete
set completeopt+=menuone
set shortmess+=c " Shut off completion messages
set noexpandtab noshiftround " to check if tab is better
set foldmethod=marker
if !($TERM == 'rxvt-unicode-256color')
	set termguicolors
endif
" if has('termguicolors')
" 	set termguicolors
" endif
let mapleader = "\<Space>"
let maplocalleader = "\\"
filetype on
filetype plugin indent on
let $PAGER=''
let $FZF_DEFAULT_COMMAND = 'find . -path "*/.git" -prune -o -path "*/.cache" -prune -o -print 2>/dev/null | sed 1d'
" global variables {{{1
let g:netrw_banner=0
" let g:netrw_list_hide=netrw_gitignore#Hide()
" abbreviates {{{1
ab intlctl Vedant36 is not a intellectual
ab coke cocain
" autocmd {{{1
au bufnewfile,bufread *.log* setf logtalk
au bufnewfile,bufread *.conf* setf cfg
au bufnewfile,bufread .zsh* setf zsh
au termopen term://* setf terminal
" au bufnewfile,bufread *man* setf man " doesn't work
au bufwritepost ~/.Xresources silent !xrdb ~/.Xresources
" au TextChanged,TextChangedI <buffer> silent write
augroup custom_filetype
	au!
	au filetype help nn <buffer><silent> q :bd<cr>
	au filetype man nn <buffer><silent> ]] :call search('^\S')<cr>
	au filetype man nn <buffer><silent> [[ :call search('^\S','b')<cr>
	au filetype man set nobuflisted
	au filetype markdown nn j gj
	au filetype markdown nn k gk
	au filetype markdown nn <leader>1 A)<esc>I[](<esc>hi
	au filetype markdown nn zq :vimgrep /^#\+ .*.*/ %<Left><Left><Left><Left><Left>
	au filetype markdown setlocal commentstring=<!--\ %s\ -->
	au filetype netrw setl bufhidden=wipe
	au filetype python setl noet ts=4
	au filetype upstart setlocal commentstring=#\ %s
	au filetype vim nn <leader>1 oPlug ''<esc>h
	au filetype xdefaults setlocal commentstring=!\ %s
augroup END

" keybinds ∑ { n ∈ ▲ } 🅇(n) ○-> Ⓨ[n] ▢△◈ {{{1
" uncategorized {{{2
tno <c-a> <C-\><C-N>
nn <leader>y "*yiw
nn Y y$
"  leaderbinds {{{2
nn <leader>a gg"*yG``
nn <leader>e :echo<space>
nn <leader>h :h<space>
nn <leader>l $
nn <leader><leader> <C-^>
nn <leader>r :sp\| terminal<cr>i
nn <leader>s :%s/
nn <silent> <leader>b :ls<cr>:b<space>
nn <silent> <leader>c "+
vn <silent> <leader>c "+
nn <silent> <leader>d yyp
nn <silent> <leader>d yyp
nn <silent> <leader>n :E<cr>
nn <silent> <leader>p "*
vn <silent> <leader>p "*
nn <silent> <leader>q @q
nn <silent> <leader>w :w<cr>
" <f>unction keybinds {{{2
nn <silent> <F3> :so $MYVIMRC<cr>
ino <silent> <F3> <esc>:so $MYVIMRC<cr>gi
nn <silent> <F5> :w!<cr>
ino <silent> <F5> <esc>:w!<cr>gi
nn <silent> <F6> :set invspell<cr>
ino <silent> <F6> <C-O>:set invspell<cr>
nn <silent> <F7> :!./'%'<cr>
nn <silent><F9> :bufdo e!<cr>
" inoremaps {{{2
imap jk <esc>
imap kj <esc>
ino <m-b> <C-Left>
ino <m-f> <C-Right>
" buffer/tab switching {{{2
nm <silent> <m-1> <Plug>lightline#bufferline#go(1)
nm <silent> <m-2> <Plug>lightline#bufferline#go(2)
nm <silent> <m-3> <Plug>lightline#bufferline#go(3)
nm <silent> <m-4> <Plug>lightline#bufferline#go(4)
nm <silent> <m-5> <Plug>lightline#bufferline#go(5)
nm <silent> <m-6> <Plug>lightline#bufferline#go(6)
nm <silent> <m-7> <Plug>lightline#bufferline#go(7)
nm <silent> <m-8> <Plug>lightline#bufferline#go(8)
nm <silent> <m-9> <Plug>lightline#bufferline#go(9)
nn <silent> <m-0> :bl<cr>
nn <silent> <tab> :bn<cr>
nn <silent> <s-tab> :bp<cr>
" quick move between most used files {{{2
nn <silent> <leader>ox :e ~/.Xresources<cr>
nn <silent> <leader>on :e ~/.config/nvim/init.vim<cr>
nn <silent> <leader>oa :e ~/.config/zsh/.zshaliases<cr>
nn <silent> <leader>oe :e ~/.config/zsh/.zshenv<cr>
nn <silent> <leader>of :e ~/.config/zsh/.zshfunctions<cr>
nn <silent> <leader>oz :e ~/.config/zsh/.zshrc<cr>
nn <silent> <leader>oh :e $HISTFILE<cr>
nn <silent> <leader>ol :e ~/dox/Cplus/c/begin.c<cr>
nn <silent> <leader>oy :e ~/dox/Python/platformer_2/Plat.py<cr>
nn <silent> <leader>ov :e ~/dl/dotfiles/dot.sh<cr>
" sus {{{2
nn <C-s> :echo  " ⠀⠀⠀⡯⡯⡾⠝⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢊⠘⡮⣣⠪⠢⡑⡌\n
				\ ⠀⠀⠀⠟⠝⠈⠀⠀⠀⠡⠀⠠⢈⠠⢐⢠⢂⢔⣐⢄⡂⢔⠀⡁⢉⠸⢨⢑⠕⡌\n
				\ ⠀⠀⡀⠁⠀⠀⠀⡀⢂⠡⠈⡔⣕⢮⣳⢯⣿⣻⣟⣯⣯⢷⣫⣆⡂⠀⠀⢐⠑⡌\n
				\ ⢀⠠⠐⠈⠀⢀⢂⠢⡂⠕⡁⣝⢮⣳⢽⡽⣾⣻⣿⣯⡯⣟⣞⢾⢜⢆⠀⡀⠀⠪\n
				\ ⣬⠂⠀⠀⢀⢂⢪⠨⢂⠥⣺⡪⣗⢗⣽⢽⡯⣿⣽⣷⢿⡽⡾⡽⣝⢎⠀⠀⠀⢡\n
				\ ⣿⠀⠀⠀⢂⠢⢂⢥⢱⡹⣪⢞⡵⣻⡪⡯⡯⣟⡾⣿⣻⡽⣯⡻⣪⠧⠑⠀⠁⢐\n
				\ ⣿⠀⠀⠀⠢⢑⠠⠑⠕⡝⡎⡗⡝⡎⣞⢽⡹⣕⢯⢻⠹⡹⢚⠝⡷⡽⡨⠀⠀⢔\n
				\ ⣿⡯⠀⢈⠈⢄⠂⠂⠐⠀⠌⠠⢑⠱⡱⡱⡑⢔⠁⠀⡀⠐⠐⠐⡡⡹⣪⠀⠀⢘\n
				\ ⣿⣽⠀⡀⡊⠀⠐⠨⠈⡁⠂⢈⠠⡱⡽⣷⡑⠁⠠⠑⠀⢉⢇⣤⢘⣪⢽⠀⢌⢎\n
				\ ⣿⢾⠀⢌⠌⠀⡁⠢⠂⠐⡀⠀⢀⢳⢽⣽⡺⣨⢄⣑⢉⢃⢭⡲⣕⡭⣹⠠⢐⢗\n
				\ ⣿⡗⠀⠢⠡⡱⡸⣔⢵⢱⢸⠈⠀⡪⣳⣳⢹⢜⡵⣱⢱⡱⣳⡹⣵⣻⢔⢅⢬⡷\n
				\ ⣷⡇⡂⠡⡑⢕⢕⠕⡑⠡⢂⢊⢐⢕⡝⡮⡧⡳⣝⢴⡐⣁⠃⡫⡒⣕⢏⡮⣷⡟\n
				\ ⣷⣻⣅⠑⢌⠢⠁⢐⠠⠑⡐⠐⠌⡪⠮⡫⠪⡪⡪⣺⢸⠰⠡⠠⠐⢱⠨⡪⡪⡰\n
				\ ⣯⢷⣟⣇⡂⡂⡌⡀⠀⠁⡂⠅⠂⠀⡑⡄⢇⠇⢝⡨⡠⡁⢐⠠⢀⢪⡐⡜⡪⡊\n
				\ ⣿⢽⡾⢹⡄⠕⡅⢇⠂⠑⣴⡬⣬⣬⣆⢮⣦⣷⣵⣷⡗⢃⢮⠱⡸⢰⢱⢸⢨⢌\n
				\ ⣯⢯⣟⠸⣳⡅⠜⠔⡌⡐⠈⠻⠟⣿⢿⣿⣿⠿⡻⣃⠢⣱⡳⡱⡩⢢⠣⡃⠢⠁\n
				\ ⡯⣟⣞⡇⡿⣽⡪⡘⡰⠨⢐⢀⠢⢢⢄⢤⣰⠼⡾⢕⢕⡵⣝⠎⢌⢪⠪⡘⡌⠀\n
				\ ⡯⣳⠯⠚⢊⠡⡂⢂⠨⠊⠔⡑⠬⡸⣘⢬⢪⣪⡺⡼⣕⢯⢞⢕⢝⠎⢻⢼⣀⠀\n
				\ ⠁⡂⠔⡁⡢⠣⢀⠢⠀⠅⠱⡐⡱⡘⡔⡕⡕⣲⡹⣎⡮⡏⡑⢜⢼⡱⢩⣗⣯⣟\n
				\ ⢀⢂⢑⠀⡂⡃⠅⠊⢄⢑⠠⠑⢕⢕⢝⢮⢺⢕⢟⢮⢊⢢⢱⢄⠃⣇⣞⢞⣞⢾\n
				\ ⢀⠢⡑⡀⢂⢊⠠⠁⡂⡐⠀⠅⡈⠪⠪⠪⠣⠫⠑⡁⢔⠕⣜⣜⢦⡰⡎⡯⡾⡽"<cr>
" categorized but less so misc {{{2
nn ; :
nn : ;
vn ; :

nn n nzzNn
nn N NzzNn

nn zuj zjk
vn zp zdgvzf

nn ZA :wqa<cr>
nn ZX :qa<cr>
nn ZS :w !echo \| dmenu \| sudo -S tee %<cr>

nn <M-m> ddkP
nn <M-n> ddp
nn <silent> <C-j> <C-w>w
nn <silent> <C-k> <C-w>W
nn <expr><silent> cot ':<c-u>set tabstop='.v:count1.'<cr>'
" }}}1
" Custom plugins {{{1
" ranger {{{2
" nn <expr> <leader>y :term ranger --chosefile
" fun customRanger()
" 	let l:files = 
" endfun
" HexMode from vimwiki {{{2
nn <silent> <F10> :Hexmode<CR>
ino <silent> <F10> <Esc>:Hexmode<CR>
vn <silent> <F10> :<C-U>Hexmode<CR>
" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()
let g:xxdopts=''
function ToggleHex()
	" hex mode should be considered a read-only operation
	" save values for modified and read-only for restoration later,
	" and clear the read-only flag for now
	let l:modified = &l:modified
	let l:oldreadonly = &l:readonly
	let l:oldmodifiable = &l:modifiable
	setlocal noreadonly
	setlocal modifiable
	if !exists("b:editHex") || !b:editHex
		" save old options
		let b:oldft = &l:ft
		let b:oldbin = &l:bin
		" set status
		let b:editHex=1
		" switch to hex editor
		silent exe "%!xxd " . g:xxdopts
		" set new options
		let &l:bin=1 " make sure it overrides any textwidth, etc.
		let &l:ft="xxd"
	else
		" restore old options
		let &l:ft = b:oldft
		let &l:bin = b:oldbin
		" return to normal editing
		silent exe "%!xxd -r " . g:xxdopts
		" set status
		let b:editHex=0
	endif
	" restore values for modified and read only state
	let &l:modified = l:modified
	let &l:readonly = l:oldreadonly
	let &l:modifiable = l:oldmodifiable
endfunction

" " custom start page {{{2
" fun! Start()
"	 " Don't run if: we have commandline arguments, we don't have an empty buffer, if we've not invoked as vim or gvim, or if we'e start ino insert mode
"	 if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
"		 return
"	 endif
"	 " Start a new buffer ...
"	 enew
"	 " ... and set some options for it
"	 setlocal bufhidden=wipe buftype=nofile nobuflisted nocursorcolumn nocursorline nolist nonumber noswapfile norelativenumber
"	 " Now we can just write to the buffer, whatever you want.
"	 for line ino split(system('fortune -a'), '\n')
"		 call append('$', '		' . l:line)
"	 endfor
"	 call append('$', '')
"	 " No modifications to this buffer
"	 setlocal nomodifiable nomodified
"	 " When we go to insert mode start a new buffer, and start insert
"	 nn <buffer><silent> e :enew<CR>
"	 nn <buffer><silent> i :enew <bar> startinsert<CR>
"	 nn <buffer><silent> o :enew <bar> startinsert<CR>
" endfun

" " Run after doing all the startup stuff
" autocmd VimEnter * call Start()
" " alternate start page {{{2
" fun! Start()
" 	enew
" 	setlocal bufhidden=wipe buftype=nofile nobuflisted nocursorcolumn nocursorline nolist nonumber noswapfile norelativenumber
" 	call append('$', '   sus')
" 	nn i :enew<cr>
" endfun
" au BufNewFile * call Start()
" }}}1
" useful commands {{{1
" :w !diff % - " to view diff with the original file
" .nvimrc {{{1
if has('nvim')
	set inccommand=split
	augroup LuaHighlight
		autocmd!
		autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
	augroup END
endif

" plugins {{{1
" if empty(glob("${XDG_DATA_HOME-$HOME/.local/share}/nvim/site/autoload"))
try
	" throw 'no'
	" plugin calls {{{2
	call plug#begin()
	Plug 'itchyny/lightline.vim'
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'plasticboy/vim-markdown'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'francoiscabrol/ranger.vim'
	" Plug 'bling/vim-bufferline'
	" Plug 'tpope/vim-vinegar'
	" Plug 'lifepillar/vim-mucomplete'
	" Plug 'neoclide/coc.nvim', {'branch': 'release'} " comlpetion engine
	" Plug 'fabi1cazenave/suckless.vim' " epic winow management
	Plug 'norcalli/nvim-colorizer.lua' " Faster but requires tru color
	Plug 'lambdalisue/nerdfont.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-unimpaired'

	" Themes
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'ghifarit53/tokyonight-vim'
	Plug 'morhetz/gruvbox'
	call plug#end()

	" plugin config {{{2
	" settings/variables
	let g:lightline#bufferline#enable_nerdfont = 1
	let g:lightline#bufferline#show_number = 2
	" let g:lightline#bufferline#unicode_symbols = 1
	let g:lightline#bufferline#min_buffer_count = 2

	let g:bufferline_rotate = 2

	let g:vim_markdown_folding_style_pythonic = 1
	let g:markdown_fenced_languages = [ 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'js=javascript', 'ts=typescript', 'py=python' ]

	let g:tokyonight_style = 'storm' " available: night, storm
	let g:tokyonight_enable_italic = 1
	let g:tokyonight_transparent_background = 1
	let g:palenight_terminal_italics=1
	let g:gruvbox_italic = 1
	let g:material_terminal_italics = 1
	let g:material_theme_style = 'darker' " default, palenight, ocean, lighter, and darker
	" let g:material_style = 'moonlight'
	colorscheme palenight
	au BufEnter * silent! lcd %:p:h " https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file that works with plugins
	" keybinds
	nn <c-p> :Files<cr>
	nmap <leader>i <Plug>CommentaryLine
	nmap <leader>u <Plug>Commentary<Plug>Commentary
	vmap <leader>i <Plug>Commentary
	" lightline config
	let g:lightline = {
		\ 'colorscheme': 'palenight',
		\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
		\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
		\ 'active': {
		\ 	 'left': [ [ 'mode', 'paste' ], [ 'filename', 'modified' ] ],
		\ 	 'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'charvaluehex', 'filetype', 'linecount', 'fileinfo' ] ]
		\ },
		\ 'inactive': {
		\ 	 'left': [ [ 'filename' , 'modified', 'fileformat' ]],
		\ 	 'right': [ [ 'lineinfo' ] ]
		\ },
		\ 'component': {
		\ 	 'charvaluehex': '%b 0x%B',
		\ 	 'fileinfo': '%{&ff}[%{&fenc!=#""?&fenc:&enc}]',
		\ 	 'linecount': '%L'
		\ },
		\ 'tabline': {
		\   'left': [ ['buffers'] ],
		\   'right': [ ['close'] ]
		\ },
		\ 'component_expand': {
		\   'buffers': 'lightline#bufferline#buffers'
		\ },
		\ 'component_type': {
		\   'buffers': 'tabsel'
		\ }
		\ }
		" \ 'separator': { 'left': '\ue0b8', 'right': '\ue0be' }
		" \ 'subseparator': { 'left': '\ue0b9', 'right': '\ue0b9' }
		" \ 'tabline_separator': { 'left': '\ue0bc', 'right': '\ue0ba' }
		" \ 'tabline_subseparator': { 'left': '\ue0bb', 'right': '\ue0bb' }
	" }}}2
catch /^no/
	echo "alskdjalksdjlkasjdlkajsdlk"
catch //
	!sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	PlugInstall
endtry

