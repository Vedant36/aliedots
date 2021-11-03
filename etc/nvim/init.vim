" Vedant36's [n]vimrc
" .vimrc settings {{{1
scriptencoding utf-8
set encoding=utf-8
set history=500
set nocompatible
set pastetoggle=<F10>
set path+=**
" set mouse=a
set autoread
set modelines=1
set tabstop=4 softtabstop=4 shiftwidth=4 noautoindent nojoinspaces
set colorcolumn=80 cursorline
set scrolloff=5
set showmatch matchtime=1
set list " lcs=tab:❯\ ,trail:-,nbsp:+
" set listchars=tab:→\ ,eol:\ ,trail:·
set listchars=tab:\|_,eol:\ ,trail:·
set splitbelow splitright
set hlsearch ignorecase incsearch smartcase
set updatetime=300 timeoutlen=300
set number relativenumber
set switchbuf=usetab
set nrformats=alpha,bin,hex,octal
set title lazyredraw noshowmode hidden
set autochdir
set numberwidth=4
set grepprg=rg\ --vimgrep
set fileformats=unix,dos,mac
set showtabline=2
set omnifunc=syntaxcomplete#Complete
set completeopt+=menuone
set shortmess=aoOstTIcF " Shut off completion messages
set sessionoptions=buffers,curdir,folds,tabpages,globals
set noexpandtab noshiftround " to check if tab is better
set foldmethod=marker fillchars=fold:-
set browsedir=~/dox/
if !($TERM == 'rxvt-unicode-256color')
	set termguicolors
endif
" if has('termguicolors')
" 	set termguicolors
" endif
let mapleader = "\<space>"
let maplocalleader = "\\"
filetype on
filetype plugin indent on
let $PAGER=''
let $FZF_DEFAULT_COMMAND = 'find . -path "*/.git" -prune -o -path "*/.cache" -prune -o -print 2>/dev/null | sed 1d'
" global variables {{{1
let g:diff_translations = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 1
" let g:netrw_list_hide=netrw_gitignore#Hide()
let python_space_error_highlight = 1
" abbreviates {{{1
ab intlctl Vedant36 is not a intellectual
ab coke cocain
" keybinds ∑ { n ∈ ▲ } 🅇(n) ○-> Ⓨ[n] ▢△◈ {{{1
" uncategorized {{{2
" nn g/ /\<\><left><left>
nn <silent> \ :Goyo<cr>
nn <M-CR> <c-o>o
nn <esc> :echoe "pressed esc nerd"<cr>
nn , ciw
tno <c-a> <C-\><C-N>
nn Y y$
nn <silent><c-n> :browse filter! /\v(man:\/\/<bar>term:\/\/<bar>\/tmp\/)/ oldfiles<cr>
"  leaderbinds {{{2
nn <leader><leader> <C-^>
nn <leader>a gg"*yG``
nn <silent> <leader>b :ls<cr>:b<space>
nn <silent> <leader>c "+
xn <silent> <leader>c "+
nn <silent> <leader>d yyp
nn <silent> <leader>e o<c-o>:r !date<cr><end>:<space>
nn <expr> <leader>g ":vimgrep /\\\<" . expand("<cword>") . "\\\>/j ** <bar> cw<cr>"
nn <leader>h :h<space>
nn <leader>m <nop>
nn <silent> <leader>n :E<cr>
nn <silent> <leader>p "*
xn <silent> <leader>p "*
nn <silent> <leader>q @q
nn <leader>r :sp\| terminal<cr>i
nn <leader>s :%s/
nn <silent> <leader>w :w<cr>
nn <leader>y "*yiw
" <f>unction keybinds {{{2
nn <silent> <F3> :so $MYVIMRC<cr>
ino <silent> <F3> <esc>:so $MYVIMRC<cr>gi
nn <silent> <F5> :w!<cr>
ino <silent> <F5> <esc>:w!<cr>gi
nn <silent> <F6> :set invspell<cr>
ino <silent> <F6> <C-O>:set invspell<cr>
nn <silent> <F7> :!time ./%:S<cr>
nn <silent><F9> :bufdo e!<cr>
" inoremaps {{{2
ino jk <esc>
ino kj <esc>
ino <m-tab> <c-f>
" readline keybinds
ino <c-b> <Left>
ino <c-f> <Right>
ino <m-b> <C-Left>
ino <m-f> <C-Right>
" buffer/tab switching {{{2
nm <silent> <m-`> <Plug>lightline#bufferline#go(1)
nm <silent> <m-1> <Plug>lightline#bufferline#go(2)
nm <silent> <m-2> <Plug>lightline#bufferline#go(3)
nm <silent> <m-3> <Plug>lightline#bufferline#go(4)
nm <silent> <m-4> <Plug>lightline#bufferline#go(5)
nm <silent> <m-5> <Plug>lightline#bufferline#go(6)
nm <silent> <m-6> <Plug>lightline#bufferline#go(7)
nm <silent> <m-7> <Plug>lightline#bufferline#go(8)
nm <silent> <m-8> <Plug>lightline#bufferline#go(9)
nn <silent> <m-9> :bl<cr>
nn <silent> <tab> :bn<cr>
nn <silent> <s-tab> :bp<cr>
" quick move between most used files {{{2
nn <silent> <leader>ox :e $XDG_CONFIG_HOME/X11/xinitrc<cr>
nn <silent> <leader>on :e $XDG_CONFIG_HOME/nvim/init.vim<cr>
nn <silent> <leader>oa :e $XDG_CONFIG_HOME/zsh/.zshaliases<cr>
nn <silent> <leader>oe :e $XDG_CONFIG_HOME/zsh/.zshenv<cr>
nn <silent> <leader>of :e $XDG_CONFIG_HOME/zsh/.zshfunctions<cr>
nn <silent> <leader>oz :e $XDG_CONFIG_HOME/zsh/.zshrc<cr>
nn <silent> <leader>od :e $HOME/.local/opt/dwm/config.h<cr>
nn <silent> <leader>oh :e $HISTFILE<cr>
nn <silent> <leader>ol :e ~/dox/CPlus/c/begin.c<cr>
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
nn Q gq
nn QQ gqq
nn <space> za
xn <space> zf
xn > >gv
xn < <gv
nn [j <c-o>
nn ]j <c-i>
nn ; :
nn : ;
xn ; :
nn n nzzNn
nn N NzzNn
nn zuj zjk
xn zp zdgvzf
nn ZA :xa<cr>
nn ZX :qa<cr>
nn ZS :w !echo <bar> dmenu <bar> sudo -S tee %<cr>
nn <silent> <C-j> <C-w>w
nn <silent> <C-k> <C-w>W
nn <expr><silent> cot ':<c-u>set tabstop='.v:count1.'<cr>'

" nn h <nop>
" nn j <nop>
" nn k <nop>
" nn l <nop>
" }}}1
" autocmd {{{1
au bufnewfile,bufread *.log* setf logtalk
au bufnewfile,bufread *.conf* setf cfg
au bufnewfile,bufread .zsh* setf zsh
au bufnewfile,bufread .gitignore setlocal commentstring=#\ %s
au bufnewfile,bufread *.qss setf css
au termopen term://* setf terminal
" au bufnewfile,bufread *man* setf man " doesn't work
au bufwritepost $XDG_CONFIG_HOME/X11/Xresources silent !xrdb $XDG_CONFIG_HOME/X11/Xresources
au bufwritepost config.h :make PREFIX=$HOME/.local clean install
" au TextChanged,TextChangedI <buffer> silent write
augroup custom_filetype
	au!
	au filetype diff if &readonly | set noreadonly | setl readonly foldmethod=manual | endif
	au filetype json,yaml set foldmethod=expr foldexpr=BetterIndent(v:lnum)
	au filetype help,man nn <buffer><silent> q ZQ<cr>
	au filetype man nn <buffer><silent> ]] :call search('^\S')<cr>
	au filetype man nn <buffer><silent> [[ :call search('^\S','b')<cr>
	au filetype man set nobuflisted
	au filetype markdown nn <buffer> j gj
	au filetype markdown nn <buffer> k gk
	au filetype markdown nn <buffer> <leader>1 A)<esc>I[](<esc>hi
	" au filetype markdown nn zq :vimgrep /^#\+ .*.*/ %<Left><Left><Left><Left><Left>
	au filetype markdown nn <silent>zq :Toc<cr>
	au filetype markdown setl cc=
	au filetype markdown setlocal commentstring=<!--\ %s\ -->
	au filetype markdown au filetype qf nn <silent><cr> <cr>:lcl<cr>
	au filetype netrw setl bufhidden=wipe
	au filetype netrw nmap <buffer>l <cr>2j | nmap <buffer>h -
	au filetype python setl noet ts=4
	au filetype upstart setlocal commentstring=#\ %s
	au filetype vim nn <buffer> <leader>1 oPlug ''<esc>h
	au filetype xdefaults setlocal commentstring=!\ %s
augroup END
augroup transparent
	au!
	 " Workaround for creating transparent bg
    autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
            \ |    highlight LineNr     ctermbg=NONE guibg=NONE
            \ |    highlight SignColumn ctermbg=NONE guibg=NONE
augroup END

" Custom plugins {{{1
" " Auto Tabularize in tables by Tim Pope {{{2
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction
" " Filename completion with glob {{{2
" function! MyCompleteFileName()
"     " match a (potential) wildcard preceding cursor position
"     " note: \f is a filename character, see :h 'isfname'
"     let l:pattern = matchstr(strpart(getline('.'), 0, col('.') - 1), '\v(\f|\*|\?)*$')
"     " set the matches
"     call complete(col('.') - len(l:pattern), getcompletion(l:pattern, "file"))
"     " must return an empty string to show the menu
"     return ''
" endfunction

" " rebind <C-X><C-F> to invoke our custom function
" inoremap <silent> <C-X><C-F> <C-R>=MyCompleteFileName()<CR>

" Neat foldtext {{{2
" Credit: https://dhruvasagar.com/2013/03/28/vim-better-foldtext https://www.reddit.com/r/vim/comments/fzcz5b
function! NeatFoldText()
	" let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
	let line = trim(getline(v:foldstart),substitute(&commentstring,'%s','','').&foldmarker.1234567890.' 	:-;')
	let lines_count_text = '> ' . printf("%10s", (v:foldend - v:foldstart + 1) . ' lines') . ' <'
	let foldchar = matchstr(&fillchars, 'fold:\zs.')
	let foldtextstart = strpart(repeat(' ', v:foldlevel * 2 + indent(v:foldstart)/2 - 3) . ' ' . line . ' <', 0, (winwidth(0)*2)/3)
	let foldtextend = lines_count_text . repeat(foldchar, 8)
	let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" better indent folding https://learnvimscriptthehardway.stevelosh.com/chapters/49.html {{{2
" au filetype python setl foldmethod=expr foldexpr=BetterIndent(v:lnum)
" function! NextNonBlankLine(lnum)
" 	let numlines = line('$')
" 	let current = a:lnum + 1

" 	while current <= numlines
" 		if getline(current) =~? '\v\S'
" 			return current
" 		endif

" 		let current += 1
" 	endwhile

" 	return -2
" endfunction
function! IndentLevel(lnum)
	return indent(a:lnum) / &shiftwidth
endfunction
function! BetterIndent(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif
	if getline(a:lnum) =~ '\v^\s*[}\]],?$'
		" return '-1'
		return IndentLevel(a:lnum-1)
	endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(a:lnum+1)
    " let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

" folding for diff from vimwiki https://vim.fandom.com/wiki/Folding_for_diff_files {{{2
au filetype diff setl foldmethod=expr foldexpr=DiffFold(v:lnum)
function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^\(diff\|---\|+++\|@@\) '
    return 1
  elseif line[0] =~ '[-+ ]'
    return 2
  else
    return 0
  endif
endfunction
" ranger {{{2
" nn <expr> <leader>y :term ranger --chosefile
" fun customRanger()
" 	let l:files = 
" endfun
" HexMode from vimwiki https://vim.fandom.com/wiki/Improved_hex_editing {{{2
nn <silent> <F10> :Hexmode<CR>
" ino <silent> <F10> <Esc>:Hexmode<CR>
xn <silent> <F10> :<C-U>Hexmode<CR>
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
" :w ++enc=utf-8 " to write to file in utf-8 to solve CONVERSION ERROR
" plugins {{{1
try
	" plugin calls {{{2
	call plug#begin()
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	Plug 'lambdalisue/nerdfont.vim'
	Plug 'github/copilot.vim', { 'on': 'Copilot enable' }
	Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
	" Plug 'jessfraz/openai.vim' " for completions from openai
	" Plug 'nvim-lualine/lualine.nvim'
	" Plug 'kyazdani42/nvim-web-devicons'

	Plug 'tpope/vim-commentary'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
	" Plug 'godlygeek/tabular'
	" Plug 'bling/vim-bufferline' " nice compact bufferline
	" Plug 'tpope/vim-vinegar'
	" Plug 'lifepillar/vim-mucomplete'
	" Plug 'neoclide/coc.nvim', {'branch': 'release'} " comlpetion engine
	Plug 'norcalli/nvim-colorizer.lua' " Faster but requires tru color
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-unimpaired'
	Plug 'google/vim-searchindex'

	" Themes
	Plug 'kaicataldo/material.vim'
	" Plug 'projekt0n/github-nvim-theme'
	Plug 'drewtempelmeyer/palenight.vim', { 'on': 'colorscheme palenight' }
	" Plug 'fioncat/vim-oceanicnext'
	Plug 'ghifarit53/tokyonight-vim', { 'on': 'colorscheme tokyonight' }
	Plug 'morhetz/gruvbox', { 'on': 'colorscheme gruvbox' }
	call plug#end()
	" }}}2
catch //
	" !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	" PlugInstall
endtry
" plugin config 
" settings/variables {{{2
let g:goyo_width = '95%'
let g:goyo_height = '95%'
let g:goto_linenr = 0

let g:copilot_filetypes = {
	\ '*': v:false,
	\ 'markdown': v:false,
	\ }

let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#show_number = 2
" let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#min_buffer_count = 2

let g:bufferline_rotate = 2

let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_style_pythonic = 1
let g:markdown_fenced_languages = [ 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'js=javascript', 'ts=typescript', 'py=python' ]

let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
let g:palenight_terminal_italics=1
let g:gruvbox_italic = 1
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight' " default, palenight, ocean, lighter, and darker
" au BufEnter * silent! lcd %:p:h " https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file that works with plugins
colorscheme gruvbox
" keybinds {{{2
nn <c-p> :Files<cr>
nmap <leader>i <Plug>CommentaryLine
nmap <leader>u <Plug>Commentary<Plug>Commentary
vmap <leader>i <Plug>Commentary
" lightline config {{{2
let g:lightline = {
	\ 'colorscheme': colors_name,
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
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
" colorizer config {{{2
lua <<EOF
require 'colorizer'.setup ({
	-- '*';
	-- '!markdown';
}, {
	RGB      = true;         -- #RGB hex codes
	RRGGBB   = true;         -- #RRGGBB hex codes
	names    = true;         -- "Name" codes like Blue
	RRGGBBAA = true;         -- #RRGGBBAA hex codes
	rgb_fn   = true;        -- CSS rgb() and rgba() functions
	hsl_fn   = true;        -- CSS hsl() and hsla() functions
	css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode     = 'background'; -- Set the display mode.
})
EOF
" }}}1
" .nvimrc {{{1
if has('nvim')
	set inccommand=split
	augroup LuaHighlight
		autocmd!
		autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
	augroup END
	" luafile $XDG_CONFIG_HOME/nvim/script.lua
endif
" }}}1
