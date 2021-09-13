let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch'], ['readonly', 'relativepath'], ['modified' ], [ 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'fileencoding', 'filetype'  ] ]
            \ },
            \ 'component_function': {
            \   'fileformat': 'LightlineFileformat',
            \   'fileencoding': 'LightlineFileencoding',
            \   'filename': 'LightlineFilename',
            \   'filetype': 'LightlineFiletype',
            \   'fugitive': 'LightlineFugitive',
            \   'readonly': 'LightlineReadonly',
            \ },
            \ 'component_expand': {
            \   'coc_error'        : 'LightlineCocErrors',
            \   'coc_warning'      : 'LightlineCocWarnings',
            \   'coc_info'         : 'LightlineCocInfos',
            \   'coc_hint'         : 'LightlineCocHints',
            \   'coc_fix'          : 'LightlineCocFixes',
            \ },
            \ 'mode_map': {
              \ 'n' : 'N',
              \ 'i' : 'I',
              \ 'R' : 'R',
              \ 'v' : 'V',
              \ 'V' : 'VL',
              \ "\<C-v>": 'VB',
              \ 'c' : 'C',
              \ 's' : 'S',
              \ 'S' : 'SL',
              \ "\<C-s>": 'SB',
              \ 't': 'T',
              \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
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

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : 'no fe') : ''
endfunction

function! LightlineFugitive()
    if exists('*FugitiveHead')
        return FugitiveHead()
    endif
    return ''
endfunction

function! LightlineReadonly()
    return &readonly && &filetype !~# '\v(help|fugitive)' ? 'RO' : ''
endfunction
