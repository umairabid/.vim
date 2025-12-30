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
  autocmd FileType ruby nnoremap <leader>lint :call RunRubocop()<CR>
  autocmd FileType ruby nnoremap <leader>lrun :call RunLineSpec()<CR>
  autocmd FileType ruby nnoremap <leader>run :call RunFileSpec()<CR>
  autocmd FileType ruby nnoremap <leader>rspec :call RunFullSpec()<CR>
  autocmd FileType ruby nnoremap <leader>frun :call RunSpec()<CR>
  if g:workspace == 'work'
    autocmd FileType ruby nnoremap <leader>ospec :call OpenFileSpec()<CR>
    autocmd FileType ruby nnoremap <leader>typec :!bundle exec src typecheck -a %<CR>
  endif
augroup END

function! OpenFileSpec()
  let fp = expand('%')
  let fp = substitute(fp, '\v(apps/[^/]+/)', '\1spec/', '')
  let fp = substitute(fp, '\v\.rb$', '_spec.rb', '')
  execute 'vs ' . fp
endfunction

function! RunRubocop()
  let l:cmd = ['bundle', 'exec', 'rubocop', '-A', expand('%')]
  call StreamToOutput(l:cmd)
endfunction

function! RunFullSpenc()
  if g:workspace == 'work'
    let l:cmd = ['rx', 'task', 'rspec']
  else
    let l:cmd = ['rspec']
  endif
  call StreamToOutput(l:cmd)
endfunction

function! RunLineSpec()
  if g:workspace == 'work'
    let l:cmd = ['rx', 'task', 'rspec', expand('%') . ':' . line('.')]
  else
    let l:cmd = ['rspec', expand('%') . ':' . line('.')]
  endif
  call StreamToOutput(l:cmd)
endfunction

function! RunSpec()
  if g:workspace == 'work'
    let l:cmd = ['rx', 'task', 'rspec', expand('%')]
  else
    let l:cmd = ['rspec', expand('%')]
  endif
  call StreamToOutput(l:cmd)
endfunction

function! RunFileSpec()
  if g:workspace == 'work'
    let fp = expand('%')
    let fp = substitute(fp, '\v(apps/[^/]+/)', '\1spec/', '')
    let fp = substitute(fp, '\v\.rb$', '_spec.rb', '')
    let l:cmd = ['rx', 'task', 'rspec', fp]
  else
    let fp = expand('%')
    let fp = substitute(fp, '\v\.rb$', '_spec.rb', '')
    let l:cmd = ['rspec', fp]
  endif
  call StreamToOutput(l:cmd)
endfunction
