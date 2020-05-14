if ! exists(':Gstatus')
    finish
endif

" Git status when appropriate
nnoremap <leader>s :Gstatus<CR>

" Git diff when appropriate
nnoremap <leader>dd :Gdiff<CR>

" Git diff split current buffer
nnoremap <leader>D :Gdiffsplit<CR>

" Add git capability to the status line with vim-fugitive
set statusline+=%{fugitive#statusline()}

