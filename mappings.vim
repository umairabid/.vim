nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap wl <C-w>l<CR>
nnoremap wh <C-w>h<CR>
nnoremap wj <C-w>j<CR>
nnoremap wk <C-w>k<CR>
nnoremap <leader>e :Fern . -drawer -toggle -reveal=% -width=45<CR>
nnoremap <leader>ss :SaveSession<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>to :tabo<CR>
nnoremap <leader>r :!e %<CR>
nnoremap <leader>ost :call OpenSymbolInTab()<CR>
nnoremap <leader>tn gt
nnoremap <leader>tp gT
nnoremap <leader>tf :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>

vnoremap <leader>y "*y

for i in range(1,9)
  exec "nnoremap " . i . "t " . i . "gt"
endfor

function! OpenSymbolInTab()
  let l:current_pos = getpos('.')
  let l:current_buf = bufnr('%')
  let l:current_file = expand('%:p')
  
  " Store current position in jumplist
  execute "normal! m'"
  
  " Execute go to definition using COC
  call CocAction('jumpDefinition')
  
  " Wait for COC to complete
  sleep 100m
  
  " Check if we actually moved to a different location
  let l:new_pos = getpos('.')
  let l:new_buf = bufnr('%')
  let l:new_file = expand('%:p')
  
  " If we moved to a different position or file, symbol was found
  if l:new_pos != l:current_pos || l:new_buf != l:current_buf
    " Open current file in new tab
    execute "tabnew " . fnameescape(l:new_file)
    " Go to the same position in the new tab
    call setpos('.', l:new_pos)
    " Go back to previous tab
    execute "tabprev"
    " Return to previous position using jumplist
    execute "normal! \<C-o>"
  endif
endfunction
