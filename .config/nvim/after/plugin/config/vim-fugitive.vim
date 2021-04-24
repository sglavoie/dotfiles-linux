if ! exists(':Gstatus')
    finish
endif

nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gs :G<CR>

" Add git capability to the status line with vim-fugitive
set statusline+=%{fugitive#statusline()}

" Stage / unstage in visual mode
vnoremap <leader>g :diffget<CR>
vnoremap <leader>p :diffput<CR>

" Merge conflicts from left or right (//2 appear on the left)
nmap <leader>gH :diffget //2<CR>
nmap <leader>gL :diffget //3<CR>
