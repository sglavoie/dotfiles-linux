if ! exists(':FZF')
    finish
endif

" Allows FZF to ignore patterns in .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
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

" Make use of FZF command instead of CtrlP - Git files
map <C-p> :FzfPreviewGitFiles<CR>

" Git files with modified status
map <C-M-p> :FzfPreviewGitStatus<CR>

" All files
map <M-S-p> :FzfPreviewDirectoryFiles<CR>

" All lines in loaded buffers
map <M-S-l> :FzfPreviewBufferLines<CR>

" All lines in current buffer
map <C-M-l> :FzfPreviewLines<CR>

" All tags in current buffer
nnoremap <leader>t :FzfPreviewBufferTags<CR>

" Grep project files from args word
map <M-S-k> :FzfPreviewProjectCommandGrep<space>

" Open list of buffers ready for fuzzy finder
nnoremap <leader>b :FzfPreviewBuffers<CR>

" Select mark
nnoremap <leader>m :FzfPreviewMarks<CR>

" Select jump list item
nnoremap <leader>j :FzfPreviewJumps<CR>

" Select change list item
nnoremap <leader>c :FzfPreviewChanges<CR>

" Select location list item
nnoremap <leader>l :FzfPreviewLocationList<CR>

" Select quickfix list item
nnoremap <leader>qq :FzfPreviewQuickFix<CR>

command! Colors :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })
