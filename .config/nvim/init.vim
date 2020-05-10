""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NEOVIM CONFIGURATION FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PLUGINS {{{
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
"""" }}}

"""" Git related {{{
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
" }}}

call plug#end()
" }}}

""" GENERAL SETTINGS {{{
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
set linebreak  " Wrap long lines
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

""" }}}

""" PLUGINS SETTINGS {{{
""""" BLACK {{{
let g:black_linelength = 79
""""" }}}

""""" COC.NVIM {{{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,python setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <S-TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
""""" }}}

""""" FZF {{{
" Allows FZF to ignore patterns in .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = "--bind ctrl-b:preview-up --bind ctrl-f:preview-down"

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
" (expand word completing window)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '20%'})

" Make use of FZF command instead of CtrlP - Git files
map <C-p> :FzfPreviewGitFiles<CR>

" Git files with modified status
map <C-M-p> :FzfPreviewGitStatus<CR>

" All files
map <M-S-p> :FzfPreviewDirectoryFiles<CR>

" All lines in loaded buffers
map <M-S-l> :FzfPreviewBufferLines<CR>

" All lines in current buffer
map <C-M-l> :FzfPreviewLines<CR>

" All tags in current buffer
nnoremap <leader>t :FzfPreviewBufferTags<CR>

" Grep project files from args word
map <M-S-k> :FzfPreviewProjectCommandGrep<space>

" Open list of buffers ready for fuzzy finder
nnoremap <leader>b :FzfPreviewBuffers<CR>

" Select mark
nnoremap <leader>m :FzfPreviewMarks<CR>

" Select jump list item
nnoremap <leader>j :FzfPreviewJumps<CR>

" Select change list item
nnoremap <leader>c :FzfPreviewChanges<CR>

" Select location list item
nnoremap <leader>l :FzfPreviewLocationList<CR>

" Select quickfix list item
nnoremap <leader>qq :FzfPreviewQuickFix<CR>
""""" }}}

""""" LIGHTLINE {{{
let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch'], ['readonly', 'relativepath'], ['modified' ], [ 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ]
            \ },
            \ 'component_function': {
            \   'fileformat': 'LightlineFileformat',
            \   'filename': 'LightlineFilename',
            \   'filetype': 'LightlineFiletype',
            \   'gitbranch': 'fugitive#head',
            \   'readonly': 'LightlineReadonly',
            \ },
            \ 'component_expand': {
            \   'coc_error'        : 'LightlineCocErrors',
            \   'coc_warning'      : 'LightlineCocWarnings',
            \   'coc_info'         : 'LightlineCocInfos',
            \   'coc_hint'         : 'LightlineCocHints',
            \   'coc_fix'          : 'LightlineCocFixes',
            \ },
            \ }

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  try
    let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
  catch
    let s = ''
  endtry
  return printf('%s %d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', 'hint')
endfunction
\ }

autocmd User CocDiagnosticChange call lightline#update()

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineReadonly()
    return &readonly && &filetype !~# '\v(help|fugitive)' ? 'RO' : ''
endfunction
""""" }}}

""""" NERDTREE {{{
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1  " show hidden (dot) files
""""" }}}

""""" MARKDOWN-PREVIEW.NVIM {{{
let g:mkdp_browser = 'brave-browser'
""""" }}}

""""" ULTISNIP {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"
""""" }}}

""""" VIM-GITGUTTER {{{
" Move to next/previous Git hunk (change)
nmap <M-}> <Plug>(GitGutterNextHunk)
nmap <M-{> <Plug>(GitGutterPrevHunk)

" Fold all unchanged lines, leaving just the hunks visible (toggle)
nmap <M-z> :GitGutterFold<CR>
""""" }}}

""""" VIM-HIGHLIGHTEDYANK {{{
let g:highlightedyank_highlight_duration = 500
""""" }}}

""""" VIMWIKI {{{
" 'a' for 'all' (regenerate all HTML pages in wiki)
nnoremap <Leader>wa :VimwikiAll2HTML<CR>

" 'b' for 'reBuild' ('r' is for renaming wiki page)
nnoremap <Leader>wb :VimwikiRebuildTags<CR>

" 'c' for 'content' (stands for "table of Content". 't' as in already Taken)
nnoremap <Leader>wc :VimwikiTOC<CR>

" 'f' for 'find' ('s' is for selecting wiki)
nnoremap <Leader>wf :VimwikiSearchTags<space>

" 'g' for 'generate'
nnoremap <Leader>wg :VimwikiGenerateTagLinks<CR>

" Sort Vimwiki links in visual mode
vnoremap <Leader>s :sort /^.*\|/<CR>

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

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]
""""" }}}

""""" YOUCOMPLETEME {{{
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
""""" }}}
""" }}}

""" AUTO EVENTS {{{
" Source: https://github.com/thoughtbot/dotfiles/blob/master/vimrc
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
            \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

" Proper PEP-8 indentation style
autocmd BufNewFile,BufRead *.py
    \ set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79
    \ expandtab autoindent fileformat=unix

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
""" }}}

""" GIT {{{
" Add git capability to the status line with vim-fugitive
set statusline+=%{fugitive#statusline()}

" Git status when appropriate
nnoremap <leader>s :Gstatus<CR>

" Git diff when appropriate
nnoremap <leader>dd :Gdiff<CR>

" Git diff split current buffer
nnoremap <leader>D :Gdiffsplit<CR>
""" }}}

""" PYTHON {{{
" Mappings: find previous/next function definition
nnoremap <F2> ?def <CR>
nnoremap <F3> /def <CR>
""" }}}

""" MAPPINGS {{{
"""" BUFFERS {{{
" Make the current window the only one visible
nnoremap <leader>o :on<CR>

" Save the current buffer
nnoremap <leader>w :write<CR>

" Copy the content of the entire buffer
nnoremap <leader>y :%y<CR>

" Remove all buffers except the active one.
nnoremap <leader>B :%bd\|e#\|bd#<CR>

" Edit Neovim configuration file in a new tab
nnoremap <leader>C :tabedit ~/.config/nvim/init.vim<CR>

" Close active buffer if there are no pending changes to save
nnoremap <leader>x :bd<CR>
nnoremap <M-q> :bd<CR>

" Close active buffer even if there are pending changes to save
nnoremap <leader>X :bd!<CR>
nnoremap <M-Q> :bd!<CR>

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

" Redraw screen and clear highlighted search as well
nnoremap <silent> <C-c> :<C-u>nohlsearch<CR><C-l>
"""" }}}

"""" COLORS {{{
command! Colors :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })
"""" }}}

"""" DATE AND TIME {{{
" Insert the current date and time in the format 'YYYY-mm-dd HH:MM'
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
"""" }}}

"""" FORMATTING {{{
" Black
nnoremap <F7> :Black<CR>

" Move selection up/down and reformat properly along the way
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
"""" }}}

"""" FUNCTIONS {{{
" Remove all whitespace at the end of every line in the file.
noremap <F5> :%s/\s\+$//<CR>:echo 'all whitespace removed.'<CR>

" Toggle display of line numbers
nnoremap <F4> :set number!<CR>:set relativenumber!<CR>

" Display text in red over column limit
let s:activatedh = 0
function! ToggleH()
    if s:activatedh == 0
        let s:activatedh = 1
        highlight OverLength ctermbg=red ctermfg=white guibg=#592929
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
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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

"""" PROGRAMMING {{{
map <silent> <M-m> :make<CR>
map <silent> <M-n> :cnext<CR>
map <silent> <M-p> :cprevious<CR>
map <leader>f gg=G''
"""" }}}

"""" SEARCH {{{
" Search with The Silver Search
nnoremap \ :Ag<SPACE>
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

" Toggle spelling option with character "°"
nnoremap <Char-176> :set spell!<CR>

" Go to previous/next spelling error
nnoremap <M-S-s> [s
nnoremap <M-s> ]s

" Add/remove word under cursor to user dictionary
nnoremap <M-g> zg
nnoremap <M-w> zw
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

" Display help in new tab
nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>

" Save file and regenerate ctags
nnoremap <leader>W :w<CR>:MakeTags<CR>:echo 'ctags have been updated.'<CR>
"""" }}}
""" }}}

" vim:fdm=marker
