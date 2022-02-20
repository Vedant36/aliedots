-- Vedant36's nvim init.lua
-- TODO: look into indent, smartindent, cindent after lsp setup
-- FIXME: nvim-autopairs doesn't work properly

-- impatient.nvim: improve startup {{{1
local _, impatient = pcall(require, 'impatient')
impatient.enable_profile() -- :LuaCacheProfile
-- }}}1
-- setup a default colorscheme too so i don't have to look at the horrible vim one
if not pcall(vim.cmd, "colorscheme palenight") then
  vim.cmd [[ colorscheme slate ]]
end

require 'vn36.autocmd'
require 'vn36.options'
require 'vn36.keymaps'
require 'vn36.plugins'


-- Custom plugins {{{1
vim.cmd [[
" trim trailing whitespace {{{2
function! StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff' && &filetype != 'gitcommit'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun
au BufWritePre * call StripTrailingWhitespaces()
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
function! ToggleHex()
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
" }}}2
]]
-- }}}1
-- useful commands {{{1
vim.cmd [[
" from https://vim.fandom.com/wiki/Load_multiple_files_with_a_single_command
" com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"
" :w !diff % - " to view diff with the original file
" :w ++enc=utf-8 " to write to file in utf-8 to solve CONVERSION ERROR
]]
-- non-lua plugin config that i can't be bothered to convert now {{{1
vim.cmd [[
" settings/variables {{{2
let g:copilot_filetypes = {
	\ '*': v:false,
	\ 'sh': v:true,
	\ 'zsh': v:true,
	\ 'python': v:true,
	\ 'vim': v:true,
	\ }

let g:gruvbox_italic = 1
let g:material_terminal_italics = 1
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:material_style = "palenight"
" lightline config {{{2
let g:lightline = {
	\ 'colorscheme': "palenight",
	\ 'active': {
	\ 	 'left': [ [ 'mode', 'paste' ], [ 'filename', 'modified' ] ],
	\ 	 'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'charvaluehex', 'filetype', 'linecount', 'fileinfo' ] ]
	\ },
	\ 'inactive': {
	\ 	 'left': [ [ 'filename' , 'modified', 'fileformat' ] ],
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
" }}}2
]]
