nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <leader>wl <C-w>l<CR>
nnoremap <leader>wh <C-w>h<CR>
nnoremap <leader>wj <C-w>j<CR>
nnoremap <leader>wk <C-w>k<CR>
nnoremap <leader>e :Fern . -drawer -toggle -reveal=% -width=45<CR>
nnoremap <leader>ss :SaveSession<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>to :tabo<CR>
nnoremap <leader>r :!e %<CR>
nnoremap <leader>ostc :call OpenSymbolInTabAndComeBack()<CR>
nnoremap <leader>ost :call OpenSymbolInTab()<CR>
nnoremap <leader>tn gt
nnoremap <leader>tp gT
nnoremap <leader>tf :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>

vnoremap <leader>y "*y

for i in range(1,9)
  exec "nnoremap " . i . "t " . i . "gt"
endfor

function! OpenSymbolInTabAndComeBack()
  let l:current_pos = getpos('.')
  let l:current_buf = bufnr('%')
  let l:current_file = expand('%:p')
  
  execute "normal! m'"
  call CocAction('jumpDefinition')
  sleep 100m
  
  let l:new_pos = getpos('.')
  let l:new_buf = bufnr('%')
  let l:new_file = expand('%:p')
  
  if l:new_pos != l:current_pos || l:new_buf != l:current_buf
    execute "tabnew " . fnameescape(l:new_file)
    call setpos('.', l:new_pos)
    execute "tabprev"
    execute "normal! \<C-o>"
  endif
endfunction

function! OpenSymbolInTab()
  let l:current_pos = getpos('.')
  let l:current_buf = bufnr('%')
  let l:current_file = expand('%:p')
  
  execute "normal! m'"
  call CocAction('jumpDefinition')
  sleep 100m
  
  let l:new_pos = getpos('.')
  let l:new_buf = bufnr('%')
  let l:new_file = expand('%:p')
  
  if l:new_pos != l:current_pos || l:new_buf != l:current_buf
    execute "tabnew " . fnameescape(l:new_file)
    call setpos('.', l:new_pos)
  endif
endfunction
