let mapleader = '\'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden = 1
let g:copilot_workspace_folders = ['~/Workspace']
let g:workspace = readfile('.workspace')
if empty(g:workspace)
  let g:workspace = 'personal'
else
  let g:workspace = g:workspace[0]
endif

if g:workspace == 'work'
  let g:copilot_workspace_folders = ['~/dev']
else
  let g:copilot_workspace_folders = ['~/Workspace']
endif
