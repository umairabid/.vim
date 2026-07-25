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
nnoremap <leader>ost :call OpenSymbolInTabAndFocus()<CR>
nnoremap <leader>tn gt
nnoremap <leader>tp gT
nnoremap <leader>tf :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>
nnoremap <leader>cf :let @+ = expand('%:p')<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>a :call AgWithInput()<CR>

vnoremap <leader>y "*y

for i in range(1,9)
  exec "nnoremap " . i . "t " . i . "gt"
endfor

function! OpenSymbolInTabAndFocus()
  let l:origin = tabpagenr()
  let l:count = tabpagenr('$')
  call CocAction('jumpDefinition', 'tabe')
  sleep 100m
  if tabpagenr('$') > l:count
    execute "tabnext " . (l:origin + 1)
  endif
endfunction

function! AgWithInput()
  let l:query = input('Search: ')
  if !empty(l:query)
    execute 'Ag ' . l:query
  endif
endfunction
