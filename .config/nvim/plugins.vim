call plug#begin($HOME . '/.config/nvim/plugged')

"""" Code completion {{{
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['python', 'javascript']}
"""" }}}

"""" Design & appearance {{{
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
"""" }}}

"""" Formatting {{{
Plug 'psf/black', { 'tag': '19.10b0', 'for': 'python' }
"""" }}}

"""" Language specific {{{
Plug 'ap/vim-css-color', { 'for': 'css' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
"""" }}}

"""" Moving/editing around {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
"""" }}}

"""" Note-taking {{{
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
"""" }}}

"""" Useful features {{{
Plug 'SirVer/ultisnips', { 'for': 'python' }
Plug 'junegunn/fzf', { 'dir': $HOME . '/.fzf', 'do': './install --all' }
Plug 'machakann/vim-highlightedyank'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'romainl/vim-qf', { 'on': ['Keep', 'Reject'] }
Plug 'yuki-ycino/fzf-preview.vim'
Plug 'junegunn/fzf.vim'
"""" }}}

"""" Git related {{{
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] }
Plug 'tpope/vim-fugitive'
" }}}

call plug#end()
" vim:fdm=marker
