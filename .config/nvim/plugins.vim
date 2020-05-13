call plug#begin($HOME . '/.local/share/nvim/plugged')

"""" Code completion {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"""" }}}

"""" Design & appearance {{{
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
"""" }}}

"""" Formatting {{{
Plug 'psf/black', { 'tag': '19.10b0' }  " Python
"""" }}}

"""" Language specific {{{
Plug 'ap/vim-css-color'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'jmcantrell/vim-virtualenv'  " Python
Plug 'mattn/emmet-vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'tmhedberg/SimpylFold'  " Folds in Python
"""" }}}

"""" Moving/editing around {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
"""" }}}

"""" Note-taking {{{
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"""" }}}

"""" Useful features {{{
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'dir': $HOME . '/.fzf', 'do': './install --all' }
Plug 'machakann/vim-highlightedyank'
Plug 'preservim/nerdtree'
Plug 'romainl/vim-qf'
Plug 'yuki-ycino/fzf-preview.vim'
Plug 'junegunn/fzf.vim'
"""" }}}

"""" Git related {{{
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
" }}}

call plug#end()
" vim:fdm=marker
