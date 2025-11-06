nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
vnoremap <leader>y "*y

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-rails'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'github/copilot.vim', { 'tag': 'v1.39.0' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'NLKNguyen/papercolor-theme'
call plug#end()

syntax on
set nocompatible
set number
set encoding=utf-8
set wrap
set textwidth=150
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set autoindent
set splitright
set splitbelow
set foldmethod=indent
set autoread
set showmatch
set matchtime=2
set sessionoptions-=buffers

filetype plugin indent on

" Enable matchit plugin for Ruby do/end matching
runtime macros/matchit.vim

augroup ruby-js-init
  autocmd!
  autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby let g:rubycomplete_rails = 1
  autocmd FileType ruby compiler ruby
  autocmd FileType ruby setlocal foldmethod=syntax
  autocmd FileType ruby let ruby_fold = 1
  autocmd FileType ruby let ruby_minlines = 500
  autocmd FileType ruby let ruby_spellcheck_strings = 1
  autocmd FileType javascript,typescript setlocal foldmethod=marker
augroup END

augroup ruby-mappings
  autocmd!
  autocmd FileType ruby nnoremap <leader>lspec :execute '!bundle exec rspec ' . expand('%') . ':' . line('.')<CR>
  autocmd FileType ruby nnoremap <leader>fspec :!bundle exec rspec %<CR>
  autocmd FileType ruby nnoremap <leader>spec :call RunFileSpec()<CR>
  autocmd FileType ruby nnoremap <leader>e :Fern . -drawer -toggle -reveal=% -width=45<CR>
  autocmd FileType ruby nnoremap <leader>rubocop :!bundle exec rubocop --autocorrect %<CR>
augroup END


let mapleader = '\'

" Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0

set t_Co=256   " This is may or may not needed.
set background=dark
colorscheme PaperColor

" Fern configuration
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden = 1

let g:copilot_workspace_folders = ['~/dev']

function! PreSessionHook()
  " Iterate over all buffers
  for buf in getbufinfo()
    " Check if the buffer name contains 'fern://' or is a fern drawer
    " buffer
    if buf.name =~# 'fern://' || buf.name =~# '\[fern \w\+\]'
      " Use :bwipeout! to force-delete the buffer and remove it
      " completely from memory
      " Use silent! to prevent error messages if the buffer is
      " already closed or has issues
      silent! execute 'bwipeout!' buf.bufnr
    endif
  endfor
endfunction

function! RunFileSpec()
  let fp = expand('%')
  let fp = substitute(fp, '\v(apps/[^/]+/)', '\1spec/', '')
  let fp = substitute(fp, '\v\.rb$', '_spec.rb', '')
  execute '!bundle exec rspec ' . fp
endfunction

command! -nargs=? SaveSession call PreSessionHook() | execute 'mksession!' <q-args>
