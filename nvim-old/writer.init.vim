"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------
set spell
set termguicolors

"--------------------------------------------------------------------------
" Key mappings
"--------------------------------------------------------------------------
" Use Ctrl-c for copy 
nmap <C-c> "+y
vmap <C-c> "+y
nmap <C-v> "+p
inoremap <C-v> <c-r>+
cnoremap <C-v> <c-r>+

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------
" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
Plug 'preservim/vim-pencil'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'sainnhe/sonokai'

call plug#end()
doautocmd User PlugLoaded

color sonokai

let g:mkdp_auto_start = 1

autocmd VimEnter * Goyo|SoftPencil

nnoremap <C-p> :Ranger<CR>
