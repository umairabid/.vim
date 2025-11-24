command! SaveSession call PreSessionHook() | execute 'mksession!' fnameescape(FindOrCreateRootVimSession())

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


function! FindOrCreateRootVimSession()
  let l:root = getcwd()
  let l:sessions = globpath(l:root, '*.vimsession', 0, 1)

  if !empty(l:sessions)
    return l:sessions[0]
  endif

  let l:dirname = fnamemodify(l:root, ':t')
  let l:new_session = l:root . '/' . l:dirname . '.vimsession'
  call writefile([], l:new_session)
  return l:new_session
endfunction
