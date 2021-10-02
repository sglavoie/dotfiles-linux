set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=0
set expandtab
set autoindent
set fileformat=unix

" Prevents hijacking default <Tab> key to go to next link:
" Without setting a mapping for VimwikiPrevLink and VimwikiNextLink
" <C-i> would be overridden in normal mode as it's the same as <Tab>.
nmap <F8> <Plug>VimwikiPrevLink
nmap <F9> <Plug>VimwikiNextLink
nmap <F10> <Plug>VimwikiAddHeaderLevel
nmap <S-F10> <Plug>VimwikiRemoveHeaderLevel
