" NEOVIM CONFIGURATION FILE

""" PLUGINS {{{
call plug#begin($HOME . '/.local/share/nvim/plugged')

"""" Design & appearance {{{
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
"""" }}}

"""" Language specific {{{
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
"""" }}}

"""" Moving/editing around {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
"""" }}}

"""" Note-taking {{{
Plug 'vimwiki/vimwiki'
"""" }}}

"""" Useful features {{{
Plug 'junegunn/fzf', { 'dir': $HOME . '/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mbbill/undotree'
Plug 'vifm/vifm.vim'
"""" }}}

"""" Git related {{{
Plug 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] }
Plug 'tpope/vim-fugitive'
" }}}

call plug#end()
""" }}}

"""" APPEARANCE {{{
colorscheme gruvbox
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
set scrolloff=6  " Always leaves 6 lines above or below the current line
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
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Silence output from grep so we don't have any prompts to "press ENTER to continue"
" Append `!` to grep so it doesn't open the first match automatically
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep!'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep!' : 'lgrep'

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
" Automatically rebalance windows when resizing Vim (useful inside tmux)
autocmd VimResized * :wincmd =

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

" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
let s:default_path = escape(&path, '\ ') " store default value of 'path'
" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path

" Open the quickfix / location window when some action is happening there
augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost    l* lwindow
augroup END
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

""" KEYBINDINGS {{{
"""" GENERAL {{{
let mapleader = " "  " Set map leader as a space
let maplocalleader = " "

" Toggle display of line numbers
nnoremap <F4> :set number!<CR>:set relativenumber!<CR>

" Avoid entering 'Ex' mode
nmap Q <Nop>
"""" }}}

"""" BUFFERS {{{
" Make the current window the only one visible
nnoremap <leader>o :on<CR>

" Copy the content of the entire buffer
nnoremap <leader>y :%y<CR>

" Remove all buffers except the active one.
nnoremap <leader>B :%bd\|e#\|bd#<CR>

" Edit Neovim configuration file in a new tab
nnoremap <leader>C :tabedit ~/.config/nvim/init.vim<CR>

" Close active buffer if there are no pending changes to save
nnoremap <leader>x :bd<CR>
nnoremap <leader>X :bd!<CR>

" Close all buffers without saving
nnoremap <leader>Q :qall!<CR>

" Reset edits made in current buffer if file hasn't been saved
nnoremap <leader>e :e!<CR>

" In order: previous, next, alternate, first, last, list
nnoremap <M-1> :bp<CR>
nnoremap <M-2> :bn<CR>
nnoremap <M-3> :b#<CR>
nnoremap <M-4> :bf<CR>
nnoremap <M-5> :bl<CR>

" Change working directory to currently opened file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Redraw screen and clear highlighted search as well
nnoremap <silent> <C-c> :<C-u>nohlsearch<CR><C-l>
"""" }}}

"""" DATE AND TIME {{{
" Insert the current date and time in the format 'YYYY-mm-dd HH:MM'
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
"""" }}}

"""" FORMATTING {{{
" Move selection up/down and reformat properly along the way
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Remove all whitespace at the end of every line in the file.
noremap <F5> :%s/\s\+$//<CR>:echo 'all whitespace removed.'<CR>

" Reformat file
map <leader>f gg=G''

" Python: format current file with Black
nnoremap <F7> :!black -l 79 %<CR>
"""" }}}

"""" FUNCTIONS {{{
" Display text in red over column limit
let s:activatedh = 0
function! ToggleH()
    if s:activatedh == 0
        let s:activatedh = 1
        highlight OverLength ctermbg=red ctermfg=white guibg=#692929
        match OverLength /\%81v.\+/
    else
        let s:activatedh = 0
        match none
    endif
endfunction
" Mapping to character `¬`
nnoremap <Char-172> :call ToggleH()<CR>

" Redirect the output of a Vim or external command into a scratch buffer
" From: https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd)
    if a:cmd =~ '^!'
        execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
    else
        redir => output
        execute a:cmd
        redir END
    endif
    tabnew
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
    call setline(1, split(output, "\n"))
    put! = a:cmd
    put = '----'
endfunction
command! -nargs=1 Redir silent call Redir(<f-args>)
"""" }}}

"""" MOVEMENTS {{{
" Move between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Adjust size of current window vertically
map <M-k> <C-w>+
map <M-j> <C-w>-

" Adjust size of current window horizontally
map <M-l> <C-w>>
map <M-h> <C-w><

" Moves more easily with long lines that wrap without compromising default
" hjkl behavior
nmap <Down> gj
nmap <Up> gk

" Quickly navigate open tabs
nmap <Left> gT
nmap <Right> gt

" Make use of Left and Right arrow keys to move text (indents) in Visual mode
vmap <Left> <gv
vmap <Right> >gv

" Remaps Escape key to more accessible keys in Insert mode
inoremap kj <esc>

" Allows to expand directory without filename of current open buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"""" }}}

"""" PROGRAMMING WITH C FAMILY {{{
map <silent> <M-m> :make<CR>
map <silent> <M-n> :cnext<CR>
map <silent> <M-p> :cprevious<CR>
map <silent> <M-r> :!./run<CR>
"""" }}}

"""" SEARCH {{{
" Search with Ripgrep (custom command from after/plugin/config/fzf.vim)
nnoremap \ :RG<CR>
"""" }}}

"""" SPELLING {{{
function! s:fixLineSpellError()
    " Found on Stack Exchange: https://vi.stackexchange.com/a/19792
    " get current line number
    let lnum = line('.')
    " find last misspelled word before cursor
    normal! [s
    " do nothing if line changed
    if lnum != line('.') | return | endif
    " fix spell error if line doesn't change
    normal! 1z=
endfunction

inoremap <F10> <c-g>u<Esc>:call <sid>fixLineSpellError()<cr>`]a<c-g>u

" Set language for spelling
nnoremap <leader>Ls :set spelllang=es<CR>
nnoremap <leader>Le :set spelllang=en<CR>
nnoremap <leader>Lf :set spelllang=fr<CR>

" Toggle spelling option with character "º"
nnoremap <Char-186> :set spell!<CR>

" Go to previous/next spelling error
nnoremap <M-S-s> [s
nnoremap <M-s> ]s
"""" }}}

"""" TERMINAL SPECIFIC {{{
" Exit from terminal buffer (Neovim) more easily (remaps Esc key in terminal)
tnoremap <C-[> <C-\><C-n>

" Open terminal buffer (Neovim) in new tab in insert mode
nnoremap <M-t> :tabnew<CR>:te<CR>i

" Switch to terminal buffer automatically (when only one terminal is open)
nnoremap <M-0> :b term://<CR>

tnoremap <C-j><C-k> <C-\><C-N>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" Save file and regenerate ctags
nnoremap <leader>W :w<CR>:MakeTags<CR>:echo 'ctags have been updated.'<CR>
"""" }}}

"""" VIMWIKI {{{
" 'a' for 'All' (regenerate all HTML pages in wiki)
nnoremap <Leader>wa :VimwikiAll2HTML<CR>

" 'b' for 'reBuild' ('r' is for renaming wiki page)
nnoremap <Leader>wb :VimwikiRebuildTags<CR>

" 'c' for 'Content' (stands for "table of Content". 't' as in already Taken)
nnoremap <Leader>wc :VimwikiTOC<CR>

" 'f' for 'Find' ('s' is for selecting wiki)
nnoremap <Leader>wf :VimwikiSearchTags<space>

" 'g' for 'Generate'
nnoremap <Leader>wg :VimwikiGenerateTagLinks<CR>

" Registered Wikis
let wiki_1 = {}
let wiki_1.path = '~/Dropbox/notes/'
let wiki_1.path_html = '~/Dropbox/notes/html/'
let wiki_1.index = 'index'

let wiki_2 = {}
let wiki_2.path = '~/Dropbox/university/notes/'
let wiki_2.path_html = '~/Dropbox/university/notes/html/'

let wiki_3 = {}
let wiki_3.path = '~/Dropbox/career/datopian/wiki/'
let wiki_3.path_html = '~/Dropbox/career/datopian/wiki/html/'
let wiki_3.index = 'index'

let wiki_4 = {}
let wiki_4.path = '~/Dropbox/university/modules/level5/agile_software_projects/team/'
let wiki_4.path_html = '~/Dropbox/university/modules/level5/agile_software_projects/team/html/'
let wiki_4.index = 'index'

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3, wiki_4]
"""" }}}

"""" DIFF WINDOWS {{{
vnoremap <Leader>dg :diffget<CR>
vnoremap <Leader>dp :diffput<CR>
"""" }}}
""" }}}
" vim:fdm=marker
