function! StreamToOutput(shell_cmd)
  let l:source_winid = win_getid()
  let l:bufname = '__Output_' . l:source_winid . '__'
  let l:output_winid = bufwinid(l:bufname)

  if l:output_winid != -1
    call win_gotoid(l:output_winid)
    silent %delete _
  else
    execute 'rightbelow split'
    setlocal winfixheight
  endif

  call term_start(a:shell_cmd, {
        \ 'curwin': 1,
        \ 'term_name': l:bufname,
        \ 'term_finish': 'open'
        \ })

  call win_gotoid(l:source_winid)
endfunction

