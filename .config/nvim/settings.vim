"""" APPEARANCE {{{
set background=dark
colorscheme gruvbox
"""" }}}

"""" VIM FEATURES {{{
" Set map leader as a space
let mapleader = " "
let maplocalleader = " "

filetype plugin on
let python_highlight_all=1
set autowrite  " Automatically :write before running commands
set cmdwinheight=100  " Open command list window in maximized state
set cursorline  " Highlight the screen line of the cursor
set dictionary+=/usr/share/dict/words  " Default dict to use
set diffopt+=vertical  " Always use vertical diffs
set encoding=utf-8  " Default file encoding to use
set expandtab  " Use spaces instead of tabs
set history=1000  " Command history (default: 10,000)
set lazyredraw  " Don't redraw screen when running macros
set list listchars=tab:>_,trail:-,nbsp:+
set nojoinspaces  " Use one space, not two, after punctuation
set noshowmode  " Don't display the mode being used (insert, normal, etc.)
set noswapfile  " Don't use a swapfile for the buffer
set nrformats=  " <C-a>/<C-x> with leading zeros → decimal instead of octal
set number  " Displays absolute number of current line
set relativenumber  " Displays relative number of the lines around current one
set scrolloff=3  " Always leaves 3 lines above or below the current line
set shiftwidth=4  " Number of spaces for indents
set shortmess+=c  " Don't pass messages to ins-completion-menu
set smartcase  " Match uppercase in search if used in pattern, else, no
set softtabstop=4  " Number of spaces to insert when TAB is pressed
set spell  " enable spell checking by default
set spellfile=~/.config/nvim/spell/en.utf-8.add
set spelllang=en,es,fr  " Set automatic spell checking for those languages
set splitbelow  " Put new window below current one when splitting
set splitright  " Put new window to the right of the current one when splitting
set tabstop=4  " Ideally, same value as 'shiftwidth'
set formatoptions-=tc
set termguicolors  " Make colors look better in terminal
set textwidth=0  " Number of characters in a line (0 = no limit)
set undodir=~/.vim/undo  " Where to save file with undo tree
set undofile  " Enable persistent undo tree
set updatetime=300  " Milliseconds till buffer is updated (specifically for vim-gitgutter)

" Use the system clipboard by default
set clipboard=unnamedplus

" Enable folding of blocks of code
set foldlevel=9
set foldmethod=indent

" Allows to switch to other buffers without raising error
" When the current buffer remains unsaved
set hidden

" Search regardless of case by default
set ignorecase

" Allows to search recursively for files with pattern matching (e.g. :find)
set path=$PWD/**

" Ignores certain files/directories in current path
set wildignore+=*.pyc,*.db,*__pycache__*,*.png,*.jpg,*.jpeg,*.pdf
set wildignore+=*.svg,*.xcf

" Multiple matches in command mode occupy more space, like in Bash
set wildmode=full

" Show interactive modifications with search & replace before applying changes
set inccommand=nosplit

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
endif
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"""" }}}

"""" NEOVIM FEATURES {{{
let g:python3_host_prog = $HOME . '/Programming/virtualenvs/nvim/bin/python'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}

""" AUTO EVENTS {{{
" Source: https://github.com/thoughtbot/dotfiles/blob/master/vimrc
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
            \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

" Full stack development options
autocmd BufRead *.html,*.js,*.htm,*.css,*.xml,*.xhtml,*.scss setlocal
            \ shiftwidth=2 tabstop=2 softtabstop=2

" Disables automatic commenting on newline (from https://lukesmith.xyz/)
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
""" }}}

""" CUSTOM COMMANDS {{{
" 'MakeTags' command to generate ctags in project
command! MakeTags !ctags -R .
" Clear all opening and closing tags in XML and HTML
command! RemoveHTMLTags %s/<\_.\{-1,\}>//g

" Format an URL slug appropriately by converting to lowercase, removing spaces
" and replacing them by hyphens
command! MakeSlug norm gg:t2cwSlugf:wv$gugv:s/\%V /-/g
nnoremap <F9> :MakeSlug<CR>

" Sort Vimwiki links in visual mode
command! SortVimwikiLinks norm :sort /^.*\|/<CR>
""" }}}

" vim:fdm=marker
