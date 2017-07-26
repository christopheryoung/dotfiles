execute pathogen#infect()
syntax on
filetype plugin indent on

set sw=4
set sts=4
set expandtab
set si

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
