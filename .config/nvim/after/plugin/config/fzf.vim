" Allows FZF to ignore patterns in .gitignore
let $FZF_DEFAULT_OPTS = "--bind ctrl-b:preview-up --bind ctrl-f:preview-down"

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --no-ignore --hidden --glob "!.git/*" --glob "!node_modules/*" --glob "!.venv/*" --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>1)

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file)
" imap <c-x><c-l> <plug>(fzf-complete-line)

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
