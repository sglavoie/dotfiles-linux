" NEOVIM CONFIGURATION FILE

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/keybindings.vim

"""" APPEARANCE {{{
colorscheme moonfly
set background=dark
"""" }}}

"""" VIM FEATURES {{{
filetype plugin on
let python_highlight_all=1
set autowrite  " Automatically :write before running commands
set clipboard=unnamedplus  " Use the system clipboard by default
set cmdwinheight=100  " Open command list window in maximized state
set cursorline  " Highlight the screen line of the cursor
set dictionary+=/usr/share/dict/words  " Default dict to use
set diffopt+=vertical  " Always use vertical diffs
set encoding=utf-8  " Default file encoding to use
set expandtab  " Use spaces instead of tabs
set foldlevel=9  " Enable folding of blocks of code
set foldmethod=indent  " Fold based on whitespace
set formatoptions-=crot  " See ':h fo-table' for details
set hidden  " Allows to switch to other buffers without raising error when the current buffer remains unsaved
set history=1000  " Command history (default: 10,000)
set ignorecase  " Search regardless of case by default
set inccommand=nosplit  " Show interactive modifications with search & replace before applying changes
set lazyredraw  " Don't redraw screen when running macros
set linebreak  " break long lines by words
set list listchars=tab:>_,trail:-,nbsp:+
set nojoinspaces  " Use one space, not two, after punctuation
set noswapfile  " Don't use a swapfile for the buffer
set nrformats=  " <C-a>/<C-x> with leading zeros → decimal instead of octal
set number  " Displays absolute number of current line
set path=$PWD/**  " Allows to search recursively for files with pattern matching (e.g. :find)
set relativenumber  " Displays relative number of the lines around current one
set scrolloff=3  " Always leaves 3 lines above or below the current line
set shiftwidth=4  " Number of spaces for indents
set shortmess+=c  " Don't pass messages to ins-completion-menu
set shortmess+=I  " Disable default startup message
set smartcase  " Match uppercase in search if used in pattern, else, no
set softtabstop=4  " Number of spaces to insert when TAB is pressed
set spell  " enable spell checking by default
set spellfile=~/.config/nvim/spell/en.utf-8.add
set spelllang=en,es,fr  " Set automatic spell checking for those languages
set splitbelow  " Put new window below current one when splitting
set splitright  " Put new window to the right of the current one when splitting
set tabstop=4  " Ideally, same value as 'shiftwidth'
set termguicolors  " Make colors look better in terminal
set textwidth=0  " Number of characters in a line (0 = no limit)
set undodir=~/.vim/undo  " Where to save file with undo tree
set undofile  " Enable persistent undo tree
set wildignore+=*.pyc,*.db,*__pycache__*,*.png,*.jpg,*.jpeg,*.pdf
set wildignore+=*.svg,*.xcf  " Ignores certain files/directories in current path
set wildmode=full  " Multiple matches in command mode occupy more space, like in Bash

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" The Silver Searcher
" if executable('ag')
"     " Use ag over grep
"     set grepprg=ag\ --nogroup\ --nocolor
" endif
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

if has("autocmd")
    " If the filetype is Makefile then we need to use tabs
    " So do not expand tabs into space.
    autocmd FileType make   set noexpandtab
endif
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
""" }}}

""" CUSTOM COMMANDS {{{
" 'MakeTags' command to generate ctags in project
command! MakeTags !ctags -R .
" Clear all opening and closing tags in XML and HTML
command! RemoveHTMLTags %s/<\_.\{-1,\}>//g

" Format an URL slug appropriately by converting to lowercase, removing spaces
" and replacing them by hyphens
command! MakeSlug norm gg:t2cwSlugf:wv$gugv:s/\%V /-/g

" Sort Vimwiki links in visual mode
command! SortVimwikiLinks norm :sort /^.*\|/<CR>
""" }}}
" vim:fdm=marker
