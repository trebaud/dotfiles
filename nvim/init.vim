" Based on Jess Archer vim personal config
"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------

set expandtab
set shiftwidth=4
set tabstop=4
set hidden
set signcolumn=yes:2
set relativenumber
set number
set termguicolors
set undofile
set spell
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set clipboard=unnamedplus
set confirm
set exrc
set backup
set backupdir=~/.local/share/nvim/backup//
set updatetime=300 " Reduce time for highlighting other references
set redrawtime=10000 " Allow more time for loading syntax on large files
set nospell
set noerrorbells
set noswapfile
set splitbelow

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

nmap gs :vs<CR>
nmap sg :sp<CR>

nmap <A-h> <C-w>h
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l

" Switch to left and right buffers
nnoremap sh :bprev<CR>
noremap sl :bnext<CR>

" Remap star search
nmap ss <kMultiply>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Make Y behave like the other capitals
nnoremap Y y$

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Use Ctrl-c for copy 
" nmap <c-c> "+y
vmap <A-c> "+y
nmap <A-v> "+p
inoremap <A-v> <c-r>+
cnoremap <A-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>

" Open the current file in the default program
nmap <leader>x :!xdg-open %<cr><cr>

cmap w!! %!sudo tee > /dev/null %

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

nnoremap <Leader>wd "ayiwoconsole.log('💩💩💩💩💩\n<C-R>a:', <C-R>a);<Esc>
nnoremap <Leader>we "ayiwoconsole.log(`💩💩💩💩💩\n<C-R>a:${JSON.stringify(<C-R>a, undefined, 2)}`);<Esc>

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/colorschemes.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/eunuch.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/goyo.vim
source ~/.config/nvim/plugins/heritage.vim
source ~/.config/nvim/plugins/lastplace.vim
source ~/.config/nvim/plugins/markdown-preview.vim
source ~/.config/nvim/plugins/pasta.vim
source ~/.config/nvim/plugins/peekaboo.vim
source ~/.config/nvim/plugins/polyglot.vim
source ~/.config/nvim/plugins/ranger.vim
source ~/.config/nvim/plugins/rooter.vim
source ~/.config/nvim/plugins/sayonara.vim
source ~/.config/nvim/plugins/splitjoin.vim
source ~/.config/nvim/plugins/startify.vim
source ~/.config/nvim/plugins/surround.vim
source ~/.config/nvim/plugins/tig-explorer.vim
source ~/.config/nvim/plugins/vim-test.vim
source ~/.config/nvim/plugins/which-key.vim
source ~/.config/nvim/plugins/neogit.vim
source ~/.config/nvim/plugins/diffview.vim

call plug#end()
doautocmd User PlugLoaded

"--------------------------------------------------------------------------
" LUA settings
"--------------------------------------------------------------------------

lua << EOF
require("neogit").setup {
 disable_commit_confirmation = true,
 integrations = {
  diffview = true
 }
}
EOF

"--------------------------------------------------------------------------
" General styling
"--------------------------------------------------------------------------

colorscheme gruvbox
highlight Cursor guifg=white guibg=magenta
highlight iCursor guifg=white guibg=cyan

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

"--------------------------------------------------------------------------
" Terminal settings
"--------------------------------------------------------------------------

tnoremap <A-w> <C-\><C-n>
command! -nargs=* T split | terminal <args>
autocmd TermOpen * startinsert
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

"--------------------------------------------------------------------------
" Neovide settings
"--------------------------------------------------------------------------
let g:neovide_cursor_vfx_mode = "railgun"
