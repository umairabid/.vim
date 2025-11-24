nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <leader>e :Fern . -drawer -toggle -reveal=% -width=45<CR>
for i in range(1,9)
  exec "nnoremap t" . i . " " . i . "gt"
endfor

vnoremap <leader>y "*y
nnoremap <leader>ss :SaveSession<CR>

