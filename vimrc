execute pathogen#infect()

set nocompatible

syntax on

set number

set encoding=utf-8

set wrap
set textwidth=79

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

set autoindent

set splitright

filetype plugin indent on

set splitbelow

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

autocmd FileType ruby compiler ruby

let g:NERDTreeFileLines = 1
let NERDTreeShowLineNumbers=1
autocmd VimEnter * NERDTree

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

set foldmethod=indent
autocmd FileType javascript setlocal foldmethod=marker
