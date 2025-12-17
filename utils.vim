function! StreamToOutput(shell_cmd)
  let l:bufname = '__Output__'
  let l:winid = bufwinid(l:bufname)

  if l:winid != -1
    call win_gotoid(l:winid)
    let l:bufnr = winbufnr(l:winid)
  else
    execute 'horizontal botright new ' . l:bufname
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
    let l:winid = win_getid()
    let l:bufnr = bufnr('%')
  endif

  setlocal modifiable
  silent %delete _

  function! s:OnOutput(handle, msg) closure
    call appendbufline(l:bufnr, '$', a:msg)
    call win_execute(l:winid, 'normal! G')
  endfunction

  call job_start(a:shell_cmd, {
        \ 'out_cb': function('s:OnOutput'),
        \ 'err_cb': function('s:OnOutput'),
        \ 'exit_cb': { h, s -> execute('echo "run"') }
        \ })

endfunction

