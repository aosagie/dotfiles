if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'GEverding/vim-hocon'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'benjifisher/matchit.zip'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-css-color'
Plug 'thinca/vim-fontzoom'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

set nocompatible
set t_Co=256

filetype plugin indent on
syntax enable
" Use newer regex engine so that languages like TypeScript don't slow down Vim
set regexpengine=0

scriptencoding utf-8
set encoding=utf-8

set ttyfast
set ttymouse=xterm2

set nowrap

set showmode showcmd

set scrolloff=5 sidescrolloff=5

set splitbelow splitright

set autoindent smartindent

set history=100
set undolevels=100

set listchars=eol:↲,trail:·,tab:▸\ ,precedes:«,extends:»

"set showbreak=↪

" set to auto read when a file is changed from the outside
set autoread

set number relativenumber

set noerrorbells novisualbell

" ask for previous buffer to be saved or get rid of it
set hidden

" search is case insensitive if search is all lowercase
set ignorecase
set smartcase

" full backspace support
set backspace=indent,eol,start

" spaces instead of tabs
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" full mouse support
set mouse=a

" enhanced normal mode tab completion
set wildmenu
set wildmode=list:longest,full

" highlight matching parenthesis
set showmatch
set matchtime=3

" highlight position
set cursorline cursorcolumn colorcolumn=80

" enhanced status line
set laststatus=2

" " 256 color support for term
" if !has('gui_running')
"     set term=screen-256color
" endif

set lazyredraw

" inform us when anything is changed via :
set report=0

" if file's already open in a window or tab use that instead of a buffer
set switchbuf=useopen,usetab

" backup and swap directory
set backup
set undodir=~/.vim/tmp/undo
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap

set dictionary=/usr/share/dict/words

" remapping
inoremap jj <ESC>
nore ; :
"nore : ;
nore j gj
nore k gk
vnore j gj
vnore k gk
nnoremap Y y$
map <TAB> %
map Q <Nop>

" sudo to write
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=10 "equal to foldnestmax so initial fold calls don't fold everything

" omnicomplete progressive completion
set completeopt=longest,menuone ",preview

" use Linux's default clipboard
set clipboard^=unnamed,unnamedplus

function! StripTrailingWhite()
    %s/\s\+$//ge
endfunction
command! StripTrailingWhite call StripTrailingWhite()

" plugin config {{{
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

let g:grepper = { 'tools': ['rg', 'ack', 'grep'] }

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

nnoremap <silent> <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

let g:pymode_folding = 0
let g:pymode_lint_cwindow = 0

let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
nnoremap <C-P> :Files!<CR>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

function! VimuxSlime()
    call VimuxOpenRunner()
    call VimuxSendText(@v)
    call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <silent> <leader>v "vy :call VimuxSlime()<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" }}}

" show special characters when not in insert mode
autocmd VimEnter * set list
autocmd InsertLeave * set list hlsearch
autocmd InsertEnter * set nolist nohlsearch

" GUI default turns this on, so turn it back off
autocmd GUIEnter * set novisualbell

" UI config
colorscheme vividchalk
hi cursorline cterm=none
set guioptions=er

if has('gui_macvim')
    set guifont=Source\ Code\ Pro:h13
endif
