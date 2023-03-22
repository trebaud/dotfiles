Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" disable default mappings
" conflicts with fzf plugin
let g:ranger_map_keys = 0

nnoremap <c-p> :Ranger<cr>
