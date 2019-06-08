syntax enable
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set wildmenu
colorscheme elflord

:nnoremap <C-n> :NERDTreeToggle<CR>
-
" https://stackoverflow.com/a/36882670/2544668
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

:nmap ; :

set relativenumber
set number
set laststatus=2
set clipboard=unnamedplus
set statusline=%F\ %l:%c\ %L
set mouse=a
set foldmethod=indent
set foldlevel=99

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Scroll
set scrolloff=5

" Timeout
set timeoutlen=1000 ttimeoutlen=0

" White Space
scriptencoding utf-8
set encoding=utf-8
set listchars=eol:¬,tab:»\ ,trail:.,nbsp:·,extends:→,precedes:←
highlight NonText ctermfg=8 guifg=#c5c8c0
highlight SpecialKey ctermfg=8 guifg=#c5c8c0
set list
setlocal conceallevel=2 concealcursor=inc

autocmd Syntax * syn match LeadingWS /\%(^\s*\)\@<= / containedin=ALLBUT,TrailingWS conceal cchar=.
autocmd Syntax * highlight Conceal ctermbg=NONE ctermfg=238 guifg=#c5c8c0

highlight MatchParen cterm=none ctermbg=NONE ctermfg=red

autocmd VimLeave * call system("xsel -ib", getreg('+'))
autocmd vimenter * silent! lcd %:p:h

" Nice cursor in the insert mode
autocmd VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
autocmd InsertEnter,InsertChange *
  \ if v:insertmode == 'i' |
  \   silent execute '!echo -ne "\e[5 q"' | redraw! |
  \ elseif v:insertmode == 'r' |
  \   silent execute '!echo -ne "\e[3 q"' | redraw! |
  \ endif
autocmd VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

nnoremap <silent> <c-p> :CtrlP<cr>
let g:ctrlp_custom_ignore = '\v[\/](node_modules|dist|build)|(\.(swp|ico|git))$'

" map q <Nop>
nnoremap <SPACE> <Nop>
let mapleader=" "

" paste
map <leader>v "ap
" replace
" https://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

let g:lightline = {
  \ 'active': {
  \   'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \     'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \   }
  \ }

call plug#begin('~/.vim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
