augroup ruby-init
  autocmd!
  autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby let g:rubycomplete_rails = 1
  autocmd FileType ruby compiler ruby
  autocmd FileType ruby setlocal foldmethod=syntax
  autocmd FileType ruby let ruby_fold = 1
  autocmd FileType ruby let ruby_minlines = 500
  autocmd FileType ruby let ruby_spellcheck_strings = 1
augroup END

augroup ruby-mappings
  autocmd!
  autocmd FileType ruby nnoremap <leader>rubocop :!bundle exec rubocop -A %<CR>
  if g:workspace == 'work'
    autocmd FileType ruby nnoremap <leader>lspec :execute '!rx task rspec ' . expand('%') . ':' . line('.')<CR>
    autocmd FileType ruby nnoremap <leader>spec :!rx task rspec %<CR>
    autocmd FileType ruby nnoremap <leader>run :call RunFileSpec()<CR>
    autocmd FileType ruby nnoremap <leader>srun :w <Bar> call RunFileSpec()<CR>
    autocmd FileType ruby nnoremap <leader>ospec :call OpenFileSpec()<CR>
    autocmd FileType ruby nnoremap <leader>typec :!bundle exec src typecheck -a %<CR>
  else
    autocmd FileType ruby nnoremap <leader>lspec :execute '!rspec ' . expand('%') . ':' . line('.')<CR>
    autocmd FileType ruby nnoremap <leader>spec :!rspec %<CR>
  endif
augroup END

function! RunFileSpec()
  let fp = expand('%')
  let fp = substitute(fp, '\v(apps/[^/]+/)', '\1spec/', '')
  let fp = substitute(fp, '\v\.rb$', '_spec.rb', '')
  execute '!rx task rspec ' . fp
endfunction

function! OpenFileSpec()
  let fp = expand('%')
  let fp = substitute(fp, '\v(apps/[^/]+/)', '\1spec/', '')
  let fp = substitute(fp, '\v\.rb$', '_spec.rb', '')
  execute 'vs ' . fp
endfunction
