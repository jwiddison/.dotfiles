" =========================
" ====     Vundle      ====
" =========================

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Vundle
Plugin 'VundleVim/Vundle.vim'

" Tab for auto completion 
Plugin 'ervandew/supertab'

" Multiple cursors
Plugin 'terryma/vim-multiple-cursors'

" Add indentation guidelines
Plugin 'Yggdroot/indentLine'

" Smooth scrolling
Plugin 'yuttie/comfortable-motion.vim'

" Resize windows
Plugin 'simeji/winresizer'

" Swap back and forth between single and multi-line blocks
Plugin 'AndrewRadev/splitjoin.vim'

" Re-add FocusLost and FocusGained events 
Plugin 'sjl/vitality.vim'

" Make brackets, parens, etc play nice 
Plugin 'Raimondi/delimitMate'
Plugin 'jiangmiao/auto-pairs'

" Commenting
Plugin 'tomtom/tcomment_vim'

" Fuzzy find files
Plugin 'ctrlpvim/ctrlp.vim'

" Project-wide search
Plugin 'rking/ag.vim'

" Change surrounding character to something else
Plugin 'tpope/vim-surround'

" Add 'end' to blocks
Plugin 'tpope/vim-endwise'

" Bracket Pair Colorizer
Plugin 'luochen1990/rainbow'

" File Explorer
Plugin 'francoiscabrol/ranger.vim'
Plugin 'tpope/vim-vinegar'

" File Icons
Plugin 'ryanoasis/vim-devicons'

" Lightline
Plugin 'itchyny/lightline.vim'

" " JavaScript
" Plugin 'elzr/vim-json'
" Plugin 'maxmellon/vim-jsx-pretty'
" Plugin 'mxw/vim-jsx'
" Plugin 'othree/yajs.vim'
" Plugin 'pangloss/vim-javascript'

" COC for language server stuff
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" Elixir
Plugin 'elixir-lang/vim-elixir'
Plugin 'slashmili/alchemist.vim'

" Testing
Plugin 'janko/vim-test'
Plugin 'neomake/neomake'

" Git 
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Color scheme
Plugin 'kaicataldo/material.vim'
Plugin 'ghifarit53/tokyonight.vim'
Plugin 'kyoz/purify', {'rtp': 'vim'}

call vundle#end()
filetype plugin indent on


