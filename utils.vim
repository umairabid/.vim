function! StreamToOutput(shell_cmd)
  let l:source_winid = win_getid()
  let l:bufname = '__Output_' . l:source_winid . '__'
  let l:output_bufnr = bufnr(l:bufname)
  let l:output_winid = bufwinid(l:bufname)

  " Check if output window exists
  if l:output_winid != -1
    " Switch to existing output window
    call win_gotoid(l:output_winid)
    " Stop any running job in the terminal
    if &buftype == 'terminal'
      let l:job = term_getjob(bufnr('%'))
      if l:job != v:null && job_status(l:job) == 'run'
        call job_stop(l:job, 'kill')
        " Wait a bit for job to stop
        sleep 100m
      endif
    endif
    " Wipe the buffer and create a new one
    bwipeout!
    execute 'rightbelow split'
    setlocal winfixheight
  else
    " Create new split window
    execute 'rightbelow split'
    setlocal winfixheight
  endif

  " Set the window height
  execute 'resize 20'

  " Use terminal with better settings
  call term_start(a:shell_cmd, {
        \ 'curwin': 1,
        \ 'term_name': l:bufname,
        \ 'term_finish': 'open',
        \ 'term_rows': 20,
        \ 'term_cols': winwidth(0),
        \ 'env': {'TERM': 'xterm-256color'}
        \ })

  " Set buffer options for better display
  setlocal nonumber
  setlocal norelativenumber
  setlocal scrolloff=0
  setlocal sidescrolloff=0

  " Return to source window
  call win_gotoid(l:source_winid)
endfunction
