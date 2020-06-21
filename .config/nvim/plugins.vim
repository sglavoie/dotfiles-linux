call plug#begin($HOME . '/.local/share/nvim/plugged')

"""" Code completion {{{
Plug 'neoclide/coc.nvim', {'branch': 'release',
            \ 'for': ['python', 'javascript', 'cpp', 'c']}
"""" }}}

"""" Design & appearance {{{
Plug 'arcticicestudio/nord-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
"""" }}}

"""" Formatting {{{
Plug 'psf/black', { 'tag': '19.10b0', 'for': 'python' }
"""" }}}

"""" Language specific {{{
Plug 'ap/vim-css-color'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript', 'markdown'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
"""" }}}

"""" Moving/editing around {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
"""" }}}

"""" Note-taking {{{
Plug 'vimwiki/vimwiki'
"""" }}}

"""" Useful features {{{
Plug 'SirVer/ultisnips', { 'for': 'python' }
Plug 'junegunn/fzf', { 'dir': $HOME . '/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'romainl/vim-qf'
Plug 'vifm/vifm.vim'
"""" }}}

"""" Git related {{{
Plug 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] }
Plug 'tpope/vim-fugitive'
" }}}

call plug#end()
" vim:fdm=marker
