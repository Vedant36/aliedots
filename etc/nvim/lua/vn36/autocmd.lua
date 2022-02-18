vim.cmd [[
  augroup _custom
    au Bufwritepost $XDG_CONFIG_HOME/X11/Xresources silent !xrdb $XDG_CONFIG_HOME/X11/Xresources
    " manually edit PREFIX in config.mk
    au Bufwritepost config.h :make clean install
    au TermOpen * startinsert
    " au TextChanged,TextChangedI <buffer> silent write
    au TextYankPost * silent! lua require'vim.highlight'.on_yank({higroup='Visual', timeout=50, on_visual=false})
    au VimResized * tabdo wincmd =
  augroup end

  augroup _custom_filetype_setting
    au!
    au Bufnewfile,Bufread *.log* setf log
    au Bufnewfile,Bufread *.conf* setf cfg
    au Bufnewfile,Bufread .zsh* setf zsh
    au Bufnewfile,Bufread .gitignore setlocal commentstring=#\ %s
    au Bufnewfile,Bufread *.qss setf css
    au Bufnewfile,Bufread *.rasi setf rasi
    au Termopen term://* setf terminal
  augroup end

  augroup _markdown
    au Filetype markdown nn <buffer> j gj
    au Filetype markdown nn <buffer> k gk
    " macro to convert url to markdown: url -> [|](url), where | is the cursor
    au Filetype markdown nn <buffer> <leader>1 A)<esc>I[](<esc>hi
    au Filetype markdown setl cc=
    au Filetype markdown nn <silent>zq :Toc<cr>
    " to immediately close the quickfix list after choosing an option
    au Filetype markdown au filetype qf nn <silent><cr> <cr>:lcl<cr>
  augroup end

  augroup _filetype
    au!
    au Filetype crontab setlocal commentstring=#\ %s
    au Filetype diff if &readonly | set noreadonly | setl readonly foldmethod=manual | endif
    au Filetype json,yaml setl foldmethod=expr foldexpr=BetterIndent(v:lnum)
    au Filetype help,man nn <buffer><silent> q ZQ<cr>
    au Filetype lua nn <buffer><silent> <F7> :sp \| term time lua %:S<cr>
    au Filetype man set nobuflisted
    au Filetype netrw setl bufhidden=wipe
    au Filetype netrw nmap <buffer>l <cr>2j | nmap <buffer>h -
    au Filetype python nn <buffer><silent> <F7> :sp \| term time python %:S<cr>
    au Filetype upstart setlocal commentstring=#\ %s
    au Filetype vim nn <buffer> <leader>1 oPlug ''<esc>h
    au Filetype xdefaults setlocal commentstring=!\ %s
    au Filetype qf nn <silent>q :lcl<cr>
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
