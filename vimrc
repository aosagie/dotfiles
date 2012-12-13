set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Lokaltog/vim-powerline'
Bundle 'matchit.zip'
Bundle 'klen/python-mode'
Bundle 'majutsushi/tagbar'
Bundle 'groenewege/vim-less'
Bundle 'skammer/vim-css-color'
"Begin snipmates and req libraries
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "snipmate-snippets"
Bundle "garbas/vim-snipmate"
"End snipmates and req libraries

filetype plugin indent on

syntax enable

scriptencoding utf-8
set encoding=utf-8

set ttyfast
set ttymouse=xterm2

set wrap

set showmode showcmd

set scrolloff=5 sidescrolloff=5

set splitbelow splitright

set autoindent smartindent

set history=100
set undolevels=100

set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ 

" set to auto read when a file is changed from the outside
set autoread

set number

set noerrorbells novisualbell

" ask for previous buffer to be saved or get rid of it
set nohidden

" search is case insensitive if search is all lowercase
set ignorecase
set smartcase

" makes backspace work over the following
set backspace=2

" spaces instead of tabs
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" full mouse support
set mouse=a

" enhanced normal mode tab completion
set wildmenu
set wildmode=list:longest,full

" incremental and highlighted searching
set incsearch hlsearch

" highlight matching parenthesis
set showmatch
set matchtime=3

" highlight position
set cursorline cursorcolumn colorcolumn=80

" enhanced status line
set laststatus=2

" 256 color support for term
set term=screen-256color

set lazyredraw

" inform us when anything is changed via :
set report=0

" shorter timeout length for multi-character commands
set timeoutlen=500

" if file's already open in a window or tab use that instead of a buffer
set switchbuf=useopen,usetab

" backup and swap directory
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp/

set dictionary=/usr/share/dict/words

" remapping
inoremap jj <ESC>:w<CR>
nore ; :
" nore : ;
nore j gj
nore k gk
vnore j gj
vnore k gk
nnoremap Y y$
" remap to use very magic (a.k.a. consistent) regex
nnoremap / /\v
cnoremap s/ s/\v

" alternate ways to scroll through the popup
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" use space bar to insert blank lines without leaving normal mode
noremap <silent> <space> :put =''<CR>

" clear search highlighting
map // :nohlsearch<CR>; echo 'Search highlight cleared'<CR>

" omnicomplete progressive completion
set completeopt=longest,menuone ",preview

" use Linux's default clipboard
set clipboard=unnamedplus

function! StripTrailingWhite()
    %s/\s\+$//ge
endfunction
command! StripTrailingWhite call StripTrailingWhite()

" utility functions {{{
function! s:HgBlame()
    let fn = expand('%:p')

    wincmd v
    wincmd h
    edit __hgblame__
    vertical resize 28

    setlocal scrollbind winfixwidth nolist nowrap nonumber nocursorline nocursorcolumn buftype=nofile ft=none

    normal ggdG
    execute 'silent r!hg blame -undq ' . fn
    normal ggdd
    execute ':%s/\v:.*$//'
    " setlocal nomodifiable

    wincmd l
    setlocal scrollbind
    syncbind
endf
command! -nargs=0 HgBlame call s:HgBlame()
nnoremap <leader>hb :HgBlame<cr>
" }}}

" plugin config {{{
nnoremap <leader>a :Ack! ''<LEFT>

nnoremap <silent> <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

let g:pymode_folding = 0
let g:pymode_lint_cwindow = 0

let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_max_height = 20
"let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|target$\|node_modules$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.obj$\|\.pyc$\|\.jar$\|\.o$\|\.class$\|\.swf$\|\.png$\|\.gif$'
    \ }
" doesn't work with ctrlp_custom_ignore
"let g:ctrlp_user_command = {
    "\ 'types': {
        "\ 1: ['.hg/', 'hg --cwd %s locate -I .'],
        "\ 2: ['.git/', 'cd %s && git ls-files'],
    "\ },
    "\ 'fallback': 'find %s -type f'
    "\ }

let g:syntastic_enable_signs = 1
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['java', 'scala'] }

nmap <leader>g :TlistToggle<CR>:setlocal nocursorcolumn nolist<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 1
let Tlist_GainFocus_On_ToggleOpen = 1
" }}}

if has('autocmd')
    " remove any trailing whitespace that is in the file
    " autocmd BufRead,BufWrite * if ! &bin | call StripTrailingWhite() | endif

    " restore last position in file if possible
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif

    " auto completion
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS shiftwidth=2 tabstop=2
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags shiftwidth=2 tabstop=2
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags shiftwidth=2 tabstop=2
    set ofu=syntaxcomplete#Complete

    " spell checking on text files
    "autocmd BufEnter,BufNew *.txt set spell spelllang=en_gb

    " show special characters when not in insert mode
    autocmd VimEnter * set list
    autocmd InsertLeave * set list hlsearch
    autocmd InsertEnter * set nolist nohlsearch

    " GUI default turns this on, so turn it back off
    autocmd GUIEnter * set novisualbell

    " compile LESS to CSS on save
    autocmd BufWritePost,FileWritePost *.less :silent !lessc <afile> <afile>:p:r.css
endif

set background="dark"

if has('gui_running')
    colorscheme vividchalk

    set guioptions=er
    if has('win32')
        set guifont=Consolas:h12
    elseif has('gui_gtk2')
        "let g:Powerline_symbols = 'fancy'
        "set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 11
        if hostname() == 'multivac'
            set guifont=Inconsolata\ 11
        else
            set guifont=Inconsolata\ 13
        endif
    endif
else
    colorscheme vividchalk

    " don't underline cursorline
    hi cursorline cterm=none
endif