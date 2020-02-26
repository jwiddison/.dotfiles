" Plugins
source ~/.dotfiles/vim/.vimrc-plugins

" ==========================
" ==== Package Settings ====
" ==========================

let g:ctrlp_custom_ignore = '\v\.(svg|jpeg|jpg|JPG|png|git|hg|svn|\.yardoc\|public\/images\|node_modules|public\/system\|data\|log\|tmp$|deps|build)$'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
let g:ctrlp_working_path_mode = 'ra'
let g:indentLine_char = '|'
let g:lightline = {}
let g:lightline.colorscheme = "onehalfdark"
let g:neomake_open_list = 1
let g:rainbow_active = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
let g:ranger_map_keys = 0
let g:rehash256 = 1
let g:vitality_insert_cursor = 2
let test#strategy = "neomake"

" =========================
" ====  User Settings  ====
" =========================

" Theme
colorscheme onehalfdark
command! Light :colorscheme onehalflight
command! Dark :colorscheme onehalfdark

" Match opening/closing parens, brackets, etc
runtime macros/matchit.vim

set autoread
set autowrite
set encoding=utf-8
set hlsearch
set ignorecase
set mouse=a
set nowrap
set number
set showmatch
set smartcase
set lazyredraw
set showtabline=2
set termguicolors
set ttyfast
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Turn backups and swaps off
set nobackup
set nowritebackup
set noswapfile
set backspace=indent,eol,start

" Turns on persistant history
set undodir=~/.vimundodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=1000 "maximum number lines to save for undo on a buffer reload"

" New split panes open to the right if vertical and below if horizontal
set splitright
set splitbelow 

" Autosave a file when losing focus
au FocusLost * :wa

" Pick up changes when a file changes on disk
au FocusGained,BufEnter * :checktime

" Speed up update time for git gutter
set updatetime=100

" TODO: Stephen's Lightline stuff: 

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
    return "  "
  elseif g:TESTING_STATUS == 'running'
    return " ﳘ "
  elseif g:TESTING_STATUS == 'failing'
    return "  "
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
  if fugitive#head() !=# ''
    return  " " . fugitive#head() 
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
      \ 'left': [ ['mode', 'readonly'], ['filename_with_icon', 'modified']],
      \ 'right': [['lineinfo'], ['testing_status', 'status_diagnostic']]
      \ }

" let g:lightline.separator = { 'left': "", 'right': "" }
" let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline.tabline_separator = { 'left': " ", 'right': "" }
let g:lightline.tabline_subseparator = { 'left': "/", 'right': "/" }

" let g:lightline.tabline_separator = { 'left': "", 'right': "" }
" let g:lightline.tabline_subseparator = { 'left': "", 'right': "" }

let g:lightline.separator = { 'left': " ", 'right': " " }
let g:lightline.subseparator = { 'left': '\\', 'right': '\\' }

let g:lightline.tabline = {
            \ 'left': [ [ 'vim_logo'], [ 'tabs' ] ],
            \ 'right': [ [ 'git_branch' ]]
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

" =========================
" ==== Custom Bindings ====
" =========================
let mapleader = "\<space>"

" Writing and quitting
map <Leader>w :w<CR>
map <Leader>x :x<CR>
map <Leader>q :q<CR>
map <Leader>Q :q!<CR>

" Redo
map <Leader>u <C-r>

" Fuzzy finder (ctrlp)
map <Leader>t <C-p>

" Source your vimrc if you want
map <Leader>a :source ~/.vimrc<CR>

" Git
map <Leader>b :Gblame<CR>
map <Leader>c :GitGutterNextHunk<CR>
" Override default gitgutter mappings that collide
nmap <Leader>;p <Plug>(GitGutterPreviewHunk)
nmap <Leader>;u <Plug>(GitGutterUndoHunk)
nmap <Leader>;s <Plug>(GitGutterStageHunk)
xmap <Leader>;s <Plug>(GitGutterStageHunk)

" Get out of nvim terminal
:tnoremap <Esc> <C-\><C-n>

" system clipboards
map <Leader>y "*y
map <Leader>d "+d
map <Leader>p "+p
map <Leader>P "+P

" Run tests
nmap <leader>, :TestNearest<CR>
nmap <leader>. :TestFile<CR>
" TODO: come back to this mapping
nmap <leader>.. :TestLast<CR>

" Move lines up and down
" It might look weird, but those are option + j and option + k for down and up
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==

" Duplicate a line down
nnoremap <A-Down> :t.<CR>

" Coc - language server stuff
nnoremap <leader>;o :CocList outline<CR>
nmap <leader>;d <Plug>(coc-definition)
nnoremap <leader>;h :call CocAction('doHover')<CR>
nnoremap <leader>;f :call CocAction('format')<CR>

" Ranger
map <leader>n :Ranger<CR>

" Toggles relativenumber on and off.
function! RelativeNumberToggle()
    if(&relativenumber == 1)
        set number
        set norelativenumber
    else
        set relativenumber
    endif
endfunction
map <Leader>r :call RelativeNumberToggle()<CR>

" Toggles line numbers on and off.
function! NumberToggle()
    if(&number == 1)
        set nonumber
    else
        set number
    endif
endfunction
map <Leader>R :call NumberToggle()<CR>

" Split panes
map <Leader>vs :vs<CR>
map <Leader>sp :sp<CR>

" Split pane movement
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>h <C-w>h
map <Leader>l <C-w>l
map <Leader>J <C-w>J
map <Leader>K <C-w>K
map <Leader>H <C-w>H
map <Leader>L <C-w>L

" Make all your panes the same size
map <Leader>= <C-w>=

" Tabs
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>
nnoremap <C-l> :tabnew<CR>
nnoremap <C-h> :tabclose<CR>

" Navigating Buffers 
nnoremap <C-o> :bp<CR>
nnoremap <C-i> :bn<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  " set grepprg=ag\ --nogroup\ --nocolor
  set grepprg=ag\ --nogroup
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Ag
" bind K to grep word under cursor
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap \ :Ag<SPACE>

