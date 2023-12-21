" ============================================
" ==== Lightline Config - Jordan Widdison ====
" ============================================
let g:lightline = {}

" Colorscheme
let g:lightline.colorscheme = 'embark'
" let g:lightline.colorscheme = 'onehalfdark'

nnoremap <silent> <UP> :cope<CR>
nnoremap <silent> <DOWN> :cclose<CR>
nnoremap <silent> <RIGHT> :cnext<CR>
nnoremap <silent> <LEFT> :cprev<CR>

let g:TESTING_STATUS = 'passing'

" Show message that tests have started
function! MyOnNeomakeJobStarted() abort
  let g:TESTING_STATUS = 'running'
endfunction

" Show message when all tests are passing
function! MyOnNeomakeJobFinished() abort
  let context = g:neomake_hook_context
  if context.jobinfo.exit_code == 0
    let g:TESTING_STATUS = 'passing'
  endif
  if context.jobinfo.exit_code == 1
    let g:TESTING_STATUS = 'failing'
  endif
endfunction

augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
  autocmd User NeomakeJobStarted call MyOnNeomakeJobStarted()
augroup END

"""""""""""""""""""""
" vim-test extensions
"""""""""""""""""""""
function! TestingStatus() abort
  if g:TESTING_STATUS == 'passing'
    return "  "
  elseif g:TESTING_STATUS == 'running'
    return " ﳘ "
  elseif g:TESTING_STATUS == 'failing'
    return "  "
  endif
endfunction

function! FileNameWithIcon() abort
  return winwidth(0) > 70  ?  WebDevIconsGetFileTypeSymbol() . ' ' . expand('%:t') : '' 
endfunction

function! FileNameWithParent(f) abort
  if expand('%:t') ==# ''
    return expand('%:p:h:t')
  else
    return expand('%:p:h:t') . "/" . expand("%:t")
  endif
endfunction

function! Git_branch() abort
  if FugitiveHead() !=# ''
    return  " " . FugitiveHead()
  else
    return "\uf468"
  endif
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0)
    return "\uf46f"
  endif
  if get(info, 'warning', 0)
    return info['warning'] . "\uf421"
  endif
  return "\uf42e " 
endfunction

let g:neomake_warning_sign = { 'text': '◉' }
let g:neomake_error_sign = { 'text': '◉' }

let g:lightline.active = { 
      \ 'left': [['mode', 'readonly'], ['filename_with_icon', 'modified']],
      \ 'right': [['lineinfo'], ['testing_status', 'status_diagnostic']]
      \ }

let g:lightline.separator = { 'left': " ", 'right': " " }
let g:lightline.subseparator = { 'left': '\\', 'right': '\\' }
let g:lightline.tabline_separator = { 'left': " ", 'right': "" }
let g:lightline.tabline_subseparator = { 'left': "/", 'right': "/" }

let g:lightline.tabline = {
            \ 'left': [['vim_logo'], ['tabs']],
            \ 'right': [['git_branch']]
            \ }

let g:lightline.tab = {
        \ 'active': ['filename_with_parent'],
        \ 'inactive': ['filename']
        \ }

let g:lightline.tab_component = {}

let g:lightline.tab_component_function = {
            \ 'artify_filename': 'lightline_tab_filename',
            \ 'filename': 'lightline#tab#filename',
            \ 'filename_with_parent': 'FileNameWithParent',
            \ 'modified': 'lightline#tab#modified',
            \ 'readonly': 'lightline#tab#readonly',
            \ 'tabnum': 'lightline#tab#tabnum'
            \ }

let g:lightline.component = {
        \ 'filename_with_icon': '%{FileNameWithIcon()}',
        \ 'filename_with_parent': '%t',
        \ 'git_branch': '%{Git_branch()}',
        \ 'status_diagnostic': '%{StatusDiagnostic()}',
        \ 'testing_status': '%{TestingStatus()}',
        \ 'vim_logo': "\ue7c5 "
        \ }

