function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

nnoremap <leader>ndf :NERDTreeFind<CR>
nnoremap <leader>lspec :execute '!rspec ' . expand('%') . ':' . line('.')<CR>
nnoremap <leader>fspec :!rspec %<CR>
nnoremap <leader>rubocop :!rubocop % -A<CR>

inoremap <C-L> <Plug>(copilot-accept-line)

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'github/copilot.vim'
call plug#end()

syntax on
set nocompatible
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
set splitbelow
set foldmethod=indent

filetype plugin indent on

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby compiler ruby
autocmd FileType javascript setlocal foldmethod=marker

autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let mapleader = '\'

let g:NERDTreeFileLines = 1
let g:NERDTreeWinPos = 'left'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='simple'

let g:copilot_workspace_folders = ["~/Worspace"]

let g:lsp_settings = {
\   'ruby-lsp': {
\     'initializationOptions': {
\       'enabledFeatures': {
\         'codeActions': v:true,
\         'codeLens': v:true,
\         'completion': v:true,
\         'definition': v:true,
\         'diagnostics': v:true,
\         'documentHighlights': v:true,
\         'documentLink': v:true,
\         'documentSymbols': v:true,
\         'foldingRanges': v:true,
\         'formatting': v:true,
\         'hover': v:true,
\         'inlayHint': v:true,
\         'onTypeFormatting': v:true,
\         'selectionRanges': v:true,
\         'semanticHighlighting': v:true,
\         'signatureHelp': v:true,
\         'typeHierarchy': v:true,
\         'workspaceSymbol': v:true
\       },
\       'featuresConfiguration': {
\         'inlayHint': {
\           'implicitHashValue': v:true,
\           'implicitRescue': v:true
\         }
\       },
\       'indexing': {
\         'excludedPatterns': ['path/to/excluded/file.rb'],
\         'includedPatterns': ['path/to/included/file.rb'],
\         'excludedGems': ['gem1', 'gem2', 'etc.'],
\         'excludedMagicComments': ['compiled:true']
\       },
\       'formatter': 'auto',
\       'linters': [],
\       'experimentalFeaturesEnabled': v:false
\     }
\   }
\ }
