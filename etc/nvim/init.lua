-- Vedant36's nvim init.lua
-- TODOO: configure autopairs
-- TODO: switch to lualine and a lua-based buftabline
-- TODO: setup and configure nvim-cmp and lsp
-- TODO: look into indent, smartindent, cindent after lsp setup
-- TODO: reduce memory usage of nvim, especially for the textfiles window
-- FIXME: nvim-autopairs behaves unpredictably
-- FIXME: when resourcing(<F3>), plugin configuration doesn't reload
-- FIXME: loading the ts-rainbow plugin causes the E13 error when writing any file
-- IDEA: move all plugin configuration into a seperate folder in lua/

-- impatient.nvim: improve startup {{{1
local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end -- :LuaCacheProfile

-- globals {{{1
function P(...) -- pretty printing using vim-notify
  vim.notify(vim.inspect(...))
end
function R(module) -- reloads a module
  package.loaded[module] = nil
  return require(module)
end
-- }}}1

R 'vn36.autocmd'
R 'vn36.options'
R 'vn36.keymaps'
R 'vn36.plugins'
R 'vn36.colorscheme'

vim.opt.background = "dark"
if vim.env.DISPLAY == nil or not pcall(vim.cmd, "colorscheme palenight") then
  vim.opt.termguicolors = false
  vim.cmd [[ colorscheme slate ]]
end
-- list of colorschemes i use for completion: palenight, tokyonight, gruvbox


-- Custom plugins {{{1
vim.cmd [[
" trim trailing whitespace {{{2
function! StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff' && &filetype != 'gitcommit' && &filetype != 'git'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun
augroup _trimwhitespace
  autocmd!
  autocmd BufWritePre * call StripTrailingWhitespaces()
augroup END
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
" set foldtext=NeatFoldText()

" better indent folding https://learnvimscriptthehardway.stevelosh.com/chapters/49.html {{{2
" au filetype python setl foldmethod=expr foldexpr=PythonIndent(v:lnum)
" au bufnewfile,bufread config.py setl foldmethod=marker
function! IndentLevel(lnum)
	return indent(a:lnum) / &shiftwidth
endfunction
function! BetterIndent(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '='
  endif
  if (IndentLevel(a:lnum) == 0)
    return ">1"
  endif
  if getline(a:lnum) =~ '\v^\s*[}\])],?;?$'
    return IndentLevel(a:lnum-1) - 1
  endif

  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(a:lnum+1)

  if next_indent > this_indent
    return '>' . next_indent
  else
    return this_indent
  endif
endfunction
augroup _foldexpr
  autocmd!
  autocmd Filetype json,yaml setl foldmethod=expr foldexpr=BetterIndent(v:lnum)
  autocmd Filetype c,cpp setl foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
augroup END

" folding for diff from vimwiki https://vim.fandom.com/wiki/Folding_for_diff_files {{{2
augroup _difffold
  autocmd!
  autocmd FileType diff,gitcommit,git setl foldmethod=expr foldexpr=DiffFold(v:lnum)
augroup END
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
--   :w !diff % - " to view diff with the original file
--   :w ++enc=utf-8 " to write to file in utf-8 to solve CONVERSION ERROR
-- from https://vim.fandom.com/wiki/Load_multiple_files_with_a_single_command
--   com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"
-- lightline config {{{1
vim.cmd [[
let g:lightline = {
	\ 'colorscheme': colors_name,
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
