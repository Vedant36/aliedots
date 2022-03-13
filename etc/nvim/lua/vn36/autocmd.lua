-- TODO: convert to vim.api.nvim_create_au{group,tocmd}
vim.cmd [[
  augroup _custom
    autocmd!
    au Bufwritepost $XDG_CONFIG_HOME/X11/Xresources silent !xrdb $XDG_CONFIG_HOME/X11/Xresources
    " manually edit PREFIX in config.mk
    au Bufwritepost config.h :make clean install
    " au TextChanged,TextChangedI <buffer> silent write
    au TextYankPost * silent! lua require'vim.highlight'.on_yank({higroup='Visual', timeout=50, on_visual=false})
    au VimResized * tabdo wincmd =
  augroup end

  augroup _terminal
    autocmd!
    autocmd Bufnewfile,Bufread,TermOpen term://* setf terminal
    autocmd TermOpen,BufEnter term://* startinsert
  augroup END

  augroup _custom_filetype_setting
    au!
    au Bufnewfile,Bufread *.log* setf log
    au Bufnewfile,Bufread *.conf* setf cfg
    au Bufnewfile,Bufread .zsh* setf zsh
    au Bufnewfile,Bufread .gitignore setlocal commentstring=#\ %s
    au Bufnewfile,Bufread *.qss setf css
    au Bufnewfile,Bufread *.rasi setf rasi
  augroup end

  augroup _markdown
    autocmd!
    autocmd Filetype markdown nn <buffer> j gj
    autocmd Filetype markdown nn <buffer> k gk
    " macro to convert url to markdown: url -> [|](url), where | is the cursor
    autocmd Filetype markdown nn <buffer> <leader>1 A)<esc>I[](<esc>hi
    autocmd Filetype markdown setl cc=
    autocmd Filetype markdown nn <buffer> <silent> zq :Toc<cr>
    " to immediately close the quickfix list after choosing an option
    autocmd Filetype markdown  au Filetype qf nn <buffer> <silent> <cr> <cr>:lcl<cr>
  augroup end

  augroup _filetype
    au!
    au Filetype crontab setlocal commentstring=#\ %s
    au Filetype c,cpp setl shiftwidth=8 tabstop=8 noexpandtab
    au Filetype diff if &readonly | set noreadonly | setl readonly foldmethod=manual | endif
    au Filetype help,man nn <buffer> <silent> q ZZ<cr>
    au Filetype lua nn <buffer> <silent> <F7> :sp \| term time lua %:p:S<cr>
    au Filetype lua se sw=2
    au Filetype man set nobuflisted
    au Filetype netrw setl bufhidden=wipe
    au Filetype netrw nmap <buffer> l <cr>2j | nmap <buffer>h -
    au Filetype python nn <buffer> <silent> <F7> :sp \| term time python %:p:S<cr>
    au Filetype python se expandtab sw=4
    au Filetype upstart setlocal commentstring=#\ %s
    au Filetype vim nn <buffer> <leader>1 ouse ''<left>
    au Filetype xdefaults setlocal commentstring=!\ %s
    au Filetype qf nn <buffer> <silent> q :lcl<cr>
  augroup END

  " "" to make any background transparent
  " "augroup transparent
  " "  au!
  " "   " Workaround for creating transparent bg
  " "  autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
  " "    \ |    highlight LineNr     ctermbg=NONE guibg=NONE
  " "    \ |    highlight SignColumn ctermbg=NONE guibg=NONE
  " "augroup END
]]
