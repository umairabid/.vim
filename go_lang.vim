augroup go-mappings
  autocmd!
  autocmd FileType go nnoremap <leader>lint :call GoLint()<CR>
  autocmd FileType go nnoremap <leader>run :call GoRunFile()<CR>
  autocmd FileType go nnoremap <leader>build :call GoBuild()<CR>
  autocmd FileType go nnoremap <leader>rp :call GoRunProject()<CR>
  autocmd FileType go nnoremap <leader>bp :call GoBuildProject()<CR>
  autocmd FileType go nnoremap <leader>tidy :call GoTidy()<CR>
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

function! GoTidy()
  let l:cmd = ['go', 'mod', 'tidy']
  call StreamToOutput(l:cmd)
endfunction

function! GoRunProject()
  let l:main_file = FindMainGo()
  if empty(l:main_file)
    echo "No main.go found in current or parent directories."
    return
  endif
  let l:cmd = ['go', 'run', l:main_file]
  call StreamToOutput(l:cmd)
endfunction

function! GoBuildProject()
  let l:main_file = FindMainGo()
  if empty(l:main_file)
    echo "No main.go found in current or parent directories."
    return
  endif
  let l:cmd = ['go', 'build', l:main_file]
  call StreamToOutput(l:cmd)
endfunction

function! FindMainGo()
  let l:root_dir = getcwd()
  let l:current_dir = expand('%:p:h')

  while 1
    let l:main_path = l:current_dir . '/main.go'

    if filereadable(l:main_path)
      let l:relative_path = fnamemodify(l:main_path, ':.')
      return l:relative_path
    endif

    if l:current_dir == l:root_dir
      break
    endif

    if stridx(l:current_dir, l:root_dir) != 0
      break
    endif

    let l:parent_dir = fnamemodify(l:current_dir, ':h')
    if l:parent_dir == l:current_dir
      break
    endif

    let l:current_dir = l:parent_dir
  endwhile
  return ''
endfunction
