augroup go-mappings
  autocmd!
  autocmd FileType go nnoremap <leader>lint :call GoLint()<CR>
  autocmd FileType go nnoremap <leader>run :call GoRunFile()<CR>
  autocmd FileType go nnoremap <leader>build :call GoBuild()<CR>
augroup END

augroup go-init
  autocmd!
  autocmd FileType go setlocal tabstop=4
  autocmd FileType go setlocal shiftwidth=4  
  autocmd FileType go setlocal softtabstop=4
  autocmd FileType go setlocal noexpandtab
augroup END

function! GoLint()
  let l:cmd = ['go', 'fmt', expand('%')]
  call StreamToOutput(l:cmd)
endfunction

function! GoRunFile()
  let l:cmd = ['go', 'run', expand('%')]
  call StreamToOutput(l:cmd)
endfunction

function! GoBuild()
  let l:cmd = ['go', 'build', expand('%:p:h')]
  call StreamToOutput(l:cmd)
endfunction
