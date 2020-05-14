if ! exists(':GitGutter')
    finish
endif

" Move to next/previous Git hunk (change)
nmap <M-}> <Plug>(GitGutterNextHunk)
nmap <M-{> <Plug>(GitGutterPrevHunk)

" Fold all unchanged lines, leaving just the hunks visible (toggle)
nmap <M-z> :GitGutterFold<CR>

