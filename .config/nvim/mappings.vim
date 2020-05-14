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

"""" COC.VIM {{{
if ! exists(':CocEnable')
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
    nnoremap <silent> <space>A  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>E  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>CC  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>O  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>S  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>J  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>K  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>P  :<C-u>CocListResume<CR>
endif
"""" }}}

"""" DATE AND TIME {{{
" Insert the current date and time in the format 'YYYY-mm-dd HH:MM'
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
"""" }}}

"""" FORMATTING {{{

" Move selection up/down and reformat properly along the way
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Format an URL slug appropriately for blog posts
nnoremap <F9> :MakeSlug<CR>
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

""" PYTHON {{{
" Mappings: find previous/next function definition
nnoremap <F2> ?def <CR>
nnoremap <F3> /def <CR>
""" }}}

""" VIMWIKI {{{
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
""" }}}
" vim:fdm=marker
