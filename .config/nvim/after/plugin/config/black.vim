if ! exists(':Black')
    finish
endif

let g:black_linelength = 79
nnoremap <F7> :Black<CR>
