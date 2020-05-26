" Allows FZF to ignore patterns in .gitignore
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let $FZF_DEFAULT_OPTS = "--bind ctrl-b:preview-up --bind ctrl-f:preview-down"

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
" (expand word completing window)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '20%'})

" Make use of FZF command instead of CtrlP – All files
map <C-p> :Files!<CR>

" Git files
map <C-M-p> :GFiles!<CR>

" Git files with modified status
map <M-S-p> :GFiles!?<CR>

" All lines in loaded buffers
map <M-S-l> :Lines!<CR>

" All lines in current buffer
map <C-M-l> :BLines!<CR>

" All tags in loaded buffers
nnoremap <leader>T :Tags!<CR>

" All tags in current buffer
nnoremap <leader>t :BTags!<CR>

" Open list of buffers ready for fuzzy finder
nnoremap <leader>b :Buffers!<CR>

" Select mark
nnoremap <leader>m :Marks!<CR>

" Navigate inside Vim help tags
nnoremap <leader>hh :Helptags!<CR>

command! Colors :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })

" Access color schemes with FZF
nnoremap <M-c> :Colors<CR>
