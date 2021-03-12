" VIM
" Plug 'wfxr/minimap.vim'
call plug#begin('~/.config/nvim/plugged')
 " Core plugins
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'yuttie/comfortable-motion.vim'
 Plug 'b3nj5m1n/kommentary', {'branch': 'main'}
 Plug 'ojroques/nvim-hardline', {'branch': 'main'}
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'akinsho/nvim-bufferline.lua'
 Plug 'akinsho/nvim-toggleterm.lua'
 Plug 'nvim-lua/popup.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 " Git plugins
 Plug 'airblade/vim-gitgutter'
 Plug 'tpope/vim-fugitive'
 Plug 'f-person/git-blame.nvim'
 Plug 'rbong/vim-flog'

 " Extra
 Plug 'rbgrouleff/bclose.vim'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'Kraust/floater.nvim'
 Plug 'mattn/emmet-vim'
 Plug 'davidgranstrom/nvim-markdown-preview'
 Plug 'mvolkmann/vim-react'
 Plug 'junegunn/goyo.vim'
 Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
 Plug 'ap/vim-css-color'
 Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
 Plug 'kevinhwang91/rnvimr'
 Plug 'glepnir/dashboard-nvim'

 " Syntax highlighters
 Plug 'MaxMEllon/vim-jsx-pretty'
 Plug 'pangloss/vim-javascript'
 Plug 'HerringtonDarkholme/yats.vim'
 Plug 'leafgarland/typescript-vim'
 Plug 'peitalin/vim-jsx-typescript'
 Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
 Plug 'bluz71/vim-moonfly-colors'

 " colorschemes
 Plug 'Rigellute/rigel'
 Plug 'rakr/vim-one'
 Plug 'arzg/vim-colors-xcode'
 Plug 'flrnd/candid.vim'
 Plug 'rafi/awesome-vim-colorschemes'
 Plug 'morhetz/gruvbox'
 Plug 'kaicataldo/material.vim'
 Plug 'patstockwell/vim-monokai-tasty'
 Plug 'embark-theme/vim', { 'as': 'embark' }
 Plug 'jaredgorski/SpaceCamp'
call plug#end()


let &t_ut=''

" Theme
colorscheme one
syntax on

" Hide tildes for empty lines
"hi EndOfBuffer guibg=bg guifg=bg
"hi ExtraWhitespace guibg=#EC7063
"match ExtraWhitespace /\s\+$/

highlight Normal ctermbg=none
highlight NonText ctermbg=none


autocmd BufEnter * syntax sync fromstart

let mapleader = " "

set shell=fish
set noerrorbells
set noswapfile
set nobackup
set ttyfast
set smarttab
set smartindent
set number
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=
set hidden
set encoding=UTF-8
set inccommand=split
set nowrap
set autoread
set termguicolors
set laststatus=2
set splitright
set splitbelow
filetype plugin indent on

nnoremap tt :te<CR>
nnoremap sh :bprev<CR>
noremap sl :bnext<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap Q :q<CR>
map <Leader>d :noh<CR>
map <A-w> Esc
nmap gs :vs<CR>
nmap sg :sp<CR>
nmap <A-=> :vertical resize +5<CR>
nmap <A-\> :resize +5<CR>
nmap <A-h> <C-w>h
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l
nmap ss <kMultiply>

nnoremap <Leader>kl "ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>
nnoremap <Leader>jk "ayiwoconsole.log('<C-R>a:', <C-R>a.toJS());<Esc>
nnoremap <Leader>l; "ayiwoconsole.log(`----------------------\n${JSON.stringify(<C-R>a, undefined, 2)}`);<Esc>
vnoremap g/ y/<C-R>"<CR>
map <C-c> "+y

command! Vimrc :vs $MYVIMRC
command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a

nnoremap <Leader>x :Bclose<CR>

nnoremap <silent> <Leader>r :RnvimrToggle<CR>

let g:dashboard_default_executive ='telescope'
let g:buffet_tab_icon = ""
let g:buffet_modified_icon = "~"
let g:buffet_use_devicons = 1
let g:buffet_separator = ""
let g:minimap_auto_start = 1
let g:gitblame_message_template = '<summary> • <date> • <author>'
let g:moonflyCursorColor = 1
let g:gruvbox_contrast_dark = 'soft'

vmap gc <plug>NERDCommenterToggle
nmap gc <plug>NERDCommenterToggle

" COC
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-emoji',
  \ 'coc-git',
  \ ]

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

command! -nargs=0 GSHOW   :call     CocAction('runCommand', 'git.showCommit')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:coc_explorer_global_presets = {
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nmap <space>ed :CocCommand explorer<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" List all presets
nmap <space>el :CocList explPresets


" Terminal
tnoremap <A-w> <C-\><C-n>

augroup neovim_terminal
  autocmd!
  " Enter Terminal-mode (insert) automatically
  autocmd TermOpen * startinsert

  " Disables number lines on terminal buffers
  autocmd TermOpen * :set nonumber norelativenumber
augroup END

let g:terminal_color_4 = '#ff0000'
let g:terminal_color_5 = 'green'


" Telescope
nnoremap <A-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <A-o> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <A-b> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <A-g> <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <A-m> <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <A-n> <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <A-c> <cmd>lua require('telescope.builtin').colorscheme()<cr>

" Lua plugins setup
lua << EOF
  require('hardline').setup {}
  require'bufferline'.setup()
  require'nvim-web-devicons'.setup{
    default = true;
  }
  require'toggleterm'.setup{
    size = 20,
    open_mapping = [[<A-t>]],
    shade_filetypes = {},
    shade_terminals = true,
    persist_size = true,
  }
  require('telescope').setup{
   defaults = {
    prompt_prefix = "🤘 ",
   },
  }
EOF
