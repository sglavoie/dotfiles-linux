""""" BLACK {{{
let g:black_linelength = 79
" Black
nnoremap <F7> :Black<CR>
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

command! Colors :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })
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

""""" VIM-FUGITIVE {{{
" Git status when appropriate
nnoremap <leader>s :Gstatus<CR>

" Git diff when appropriate
nnoremap <leader>dd :Gdiff<CR>

" Git diff split current buffer
nnoremap <leader>D :Gdiffsplit<CR>

" Add git capability to the status line with vim-fugitive
set statusline+=%{fugitive#statusline()}
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

" vim:fdm=marker
