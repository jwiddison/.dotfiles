" ==================================
" ==== .vimrc - Jordan Widdison ====
" ==================================

" use `mV` to set a global mark in this file if you want

" Plugins
source ~/.dotfiles/vim/plugins.vim

" Lightline Config
source ~/.dotfiles/vim/lightline.vim

" ==========================
" ==== Package Settings ====
" ==========================

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:ctrlp_custom_ignore = '\v\.(svg|jpeg|jpg|JPG|png|git|hg|svn|\.yardoc\|public\/images\|node_modules|public\/system\|data\|log\|tmp$|deps|build)$'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
let g:ctrlp_working_path_mode = 'ra'
let g:indentguides_spacechar = '│'
let g:indentguides_tabchar = '┆'
let g:neomake_open_list = 1
let g:rainbow_active = 1
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'
let g:ranger_map_keys = 0
let g:rehash256 = 1
let g:vitality_insert_cursor = 2
let test#strategy = "neomake"
let g:vim_json_conceal = 0

" =========================
" ====  User Settings  ====
" =========================

let g:sonokai_better_performance = 1
let g:sonokai_dim_inactive_windows = 1
let g:sonokai_enable_italic = 1
let g:sonokai_style = 'maia'
let g:sonokai_transparent_background = 1
colorscheme sonokai

set autoread                             " Read file from disk when vim gains focus
set autowrite                            " Auto write file to disc on certain commands
set background=dark                      " Dark themes by default
set backspace=indent,eol,start           " Let's backspace behave how you'd expect
set colorcolumn=120                      " Sets the line length indicator at column 120
set directory=~/.vim/backups             " Tell VIM where to put swp files
set expandtab                            " Insert 2 space chars when pressing tab
set hlsearch                             " When there is a previous search pattern, highlight all its matches. 
set ignorecase                           " Ignore case in search patterns
set lazyredraw                           " Screen will not be redrawn when executing macros
set mouse=a                              " A little bit of mouse support because I am a heathan
set nowrap                               " Dont' wrap lines
set number                               " Show line numbers
set shiftwidth=2                         " Move two spaces when changing indentation with < or >
set showmatch                            " When you insert a bracket, breifly jump to closing one
set showtabline=2                        " Always show the tabline at the top of the window
set smartcase                            " When searching in a buffer, be smart about the case of the search term
set softtabstop=2                        " Make tabs two spaces
set spelllang=en_us                      " Sets the language for spellcheck
set splitbelow                           " Horizontal splits open below
set splitright                           " Vertical splits open to right
set tabstop=2                            " Make tabs two spaces
set termguicolors                        " Make themes look nice
set ttyfast                              " Improves redrawing when you delete a line
set undodir=~/.vimundodir                " Where to save undo/swp files
set undofile                             " Turn on saving undo history
set undolevels=1000                      " Maximum number of changes that can be undone
set undoreload=1000                      " Maximum number lines to save for undo on a buffer reload
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Default set of files to ignore for CtrlP

" Match opening/closing parens, brackets, etc
runtime macros/matchit.vim

" Autosave a file when losing focus
au FocusLost * :wa

" Pick up changes when a file changes on disk
au FocusGained,BufEnter * :checktime

" Speed up update time for git gutter
set updatetime=100

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

" Fuzzy finder (CtrlP)
map <Leader>t <C-p>

" Source .vimrc 
map <Leader>a :source ~/.vimrc<CR>

" Git
map <Leader>b :Git blame<CR>
map <Leader>c :GitGutterNextHunk<CR>

" Override default gitgutter mappings that collide
nmap <Leader>;p <Plug>(GitGutterPreviewHunk)
nmap <Leader>;u <Plug>(GitGutterUndoHunk)
nmap <Leader>;s <Plug>(GitGutterStageHunk)
xmap <Leader>;s <Plug>(GitGutterStageHunk)

" Open nvim terminal
map <Leader>z :term<CR>

" Get out of nvim terminal back to normal mode
:tnoremap <Esc> <C-\><C-n>

" System Clipboards
map <Leader>y "*y
map <Leader>d "+d
map <Leader>p "+p
map <Leader>P "+P

" Run tests
nmap <leader>, :TestNearest<CR>
nmap <leader>. :TestFile<CR>

" Move lines up and down
" It might look weird, but those are option + j and option + k for down and up
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==

" Coc - language server stuff
nnoremap <leader>;o :CocList outline<CR>
nmap <leader>;d <Plug>(coc-definition)
nnoremap <leader>;h :call CocAction('doHover')<CR>
nnoremap <leader>;f :call CocAction('format')<CR>

" Ranger
map <leader>n :Ranger<CR>

" Toggles light and dark background on and off
function ToggleBg()
  if(&background == 'dark')
    set background=light
  else
    set background=dark
  endif
endfunction
map <Leader>o :call ToggleBg()<CR>

" Spellcheck
map <Leader>s :setlocal spell!<cr>

" Toggles relativenumber on and off.
map <Leader>r :set relativenumber!<CR>

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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
nnoremap \ :Ag<SPACE>
