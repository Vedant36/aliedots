" Vedant36's [n]vimrc
lua require'vn36'
lua require'vn36.options'
lua require'vn36.keymaps'
lua require'vn36.autocmd'
" TODO: look into indent, smartindent, cindent after lsp setup
" Custom plugins {{{1
" trim trailing whitespace {{{2
function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff' && &filetype != 'gitcommit'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun
au BufWritePre * call <SID>StripTrailingWhitespaces()
" " Auto Tabularize in tables by Tim Pope {{{2
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
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
" au filetype python setl foldmethod=expr foldexpr=PythonIndent(v:lnum)
" au bufnewfile,bufread config.py setl foldmethod=marker
function! IndentLevel(lnum)
	return indent(a:lnum) / &shiftwidth
endfunction
function! BetterIndent(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif
  if getline(a:lnum) =~ '\v^\s*[}\])],?$'
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
au filetype diff,gitcommit setl foldmethod=expr foldexpr=DiffFold(v:lnum)
function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^$'
      return 0
  elseif line =~ '^diff '
    return ">1"
  elseif line =~ '^@@'
    return ">2"
  else
    return "="
  endif
endfunction
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
" from https://vim.fandom.com/wiki/Load_multiple_files_with_a_single_command
" com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"
" :w !diff % - " to view diff with the original file
" :w ++enc=utf-8 " to write to file in utf-8 to solve CONVERSION ERROR
" plugins {{{1
try
	call plug#begin()
	" plugin calls {{{2
	Plug 'itchyny/lightline.vim'
	Plug 'mengelbrecht/lightline-bufferline'
	" Plug 'romgrk/barbar.nvim'
	" Plug 'lambdalisue/nerdfont.vim'
	Plug 'github/copilot.vim', { 'on': 'Copilot' }
	" Plug 'tom-doerr/vim_codex', { 'on': 'CreateCompletionLine' }
	" Plug 'jessfraz/openai.vim' " for completions from openai

	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
	" Plug 'godlygeek/tabular'
	" Plug 'bling/vim-bufferline' " nice compact bufferline
	" Plug 'tpope/vim-vinegar'
	" Plug 'lifepillar/vim-mucomplete'
	" Plug 'neoclide/coc.nvim', {'branch': 'release'} " comlpetion engine
	Plug 'norcalli/nvim-colorizer.lua' " Faster but requires tru color
	Plug 'tpope/vim-unimpaired'
	Plug 'google/vim-searchindex'

    " lua plugins
	" Plug 'nvim-lualine/lualine.nvim'
    Plug 'folke/zen-mode.nvim'
	Plug 'samirettali/shebang.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'mfussenegger/nvim-lint'
	Plug 'kyazdani42/nvim-web-devicons'
    Plug 'windwp/nvim-autopairs'

	" Themes {{{2
	Plug 'drewtempelmeyer/palenight.vim'
	Plug 'ghifarit53/tokyonight-vim'
	Plug 'morhetz/gruvbox'
	Plug 'sainnhe/sonokai'
	Plug 'glepnir/zephyr-nvim'

    Plug 'tomasr/molokai'
    Plug 'crusoexia/vim-monokai'
    Plug 'marko-cerovac/material.nvim'
    Plug 'RRethy/nvim-base16'
    Plug 'JoosepAlviste/palenightfall.nvim'
	" }}}2
	call plug#end()
catch //
	" !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	" PlugInstall
endtry
" plugin config
" settings/variables {{{2
let g:copilot_filetypes = {
	\ '*': v:false,
	\ 'sh': v:true,
	\ 'zsh': v:true,
	\ 'python': v:true,
	\ 'vim': v:true,
	\ }

let g:lightline#bufferline#enable_nerdfont = 1
let g:lightline#bufferline#show_number = 2
" let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#min_buffer_count = 2
" let g:lightline#bufferline#auto_hide = 400

let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true

let g:bufferline_rotate = 2

let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_style_pythonic = 1
let g:markdown_fenced_languages = [ 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'js=javascript', 'ts=typescript', 'py=python' ]

let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1
" let g:tokyonight_transparent_background = 0
let g:palenight_terminal_italics=1
let g:gruvbox_italic = 1
let g:material_terminal_italics = 1
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:material_style = "palenight"
colorscheme palenight
" keybinds {{{2
nn <silent><c-p> :Telescope git_files<cr>
nn <silent><c-n> :Telescope oldfiles<cr>
nmap <leader>i <Plug>CommentaryLine
nmap <leader>u <Plug>Commentary<Plug>Commentary
vmap <leader>i <Plug>Commentary
" lightline config {{{2
let g:lightline = {
	\ 'colorscheme': colors_name,
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
	" \ 'separator': { 'left': '', 'right': '' },
	" \ 'subseparator': { 'left': '', 'right': '' },
" Telescope config {{{2
lua <<EOF
check'telescope'.setup{
  defaults = {
    -- ...
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    git_files = {
      theme = "dropdown",
    },
    oldfiles = {
      theme = "dropdown",
    }
  },
  extensions = {
    -- ...
  }
}
EOF
" colorizer config {{{2
lua <<EOF
check'colorizer'.setup ({
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
" treesitter highlighting config {{{2
lua << EOF
check'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}
EOF
" nvim-lint config {{{2
lua << EOF
check'lint'.linters_by_ft = {
    -- markdown = {'vale'},
    -- haskell = {'hlint'},
    sh = {'shellcheck'},
    bash = {'shellcheck'},
    zsh = {'shellcheck'},
	-- python = {'pycodestyle'},
    python = {'pylint'},
}
if check'lint'.ok then
  vim.cmd [[ au BufRead,BufWritePost <buffer> lua require('lint').try_lint() ]]
end
EOF
" Gitsigns {{{2
" TODO: switch to vim.keymap.set when 0.7 releases(preferably when switched to init.lua)
lua <<EOF
check'gitsigns'.setup {
  signcolumn = false,
  numhl      = true,
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
EOF
" }}}2
" nvim-autopairs {{{2
lua<<EOF
require('nvim-autopairs').setup{
    ignored_next_char = "[%w%.%$]"
}
EOF
" }}}1
