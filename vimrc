set nocompatible
set t_Co=256

" Vundle {{{
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'matchit.zip'
Plugin 'davidhalter/jedi-vim'
Plugin 'majutsushi/tagbar'
Plugin 'groenewege/vim-less'
Plugin 'ap/vim-css-color'
Plugin 'thinca/vim-fontzoom'
Plugin 'benmills/vimux'
Plugin 'ervandew/supertab'
Plugin 'saltstack/salt-vim'
Plugin 'derekwyatt/vim-scala'

call vundle#end()
filetype plugin indent on
" }}}

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

set listchars=eol:↲,trail:·,tab:▸\ ,precedes:«,extends:»

"set showbreak=↪

" set to auto read when a file is changed from the outside
set autoread

set number relativenumber

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
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

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

" remap to use very magic (a.k.a. consistent) regex
"nnoremap / /\v
"cnoremap s/ s/\v

" alternate ways to scroll through the popup
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" sudo to write
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" use space bar to insert blank lines without leaving normal mode
"noremap <silent> <space> :put =''<CR>

" folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable

" omnicomplete progressive completion
set completeopt=longest,menuone ",preview

" use Linux's default clipboard
set clipboard=unnamedplus

function! StripTrailingWhite()
    %s/\s\+$//ge
endfunction
command! StripTrailingWhite call StripTrailingWhite()

" plugin config {{{
nnoremap <leader><leader>a :Ack! ''<LEFT>

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

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
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': [],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
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

let g:SuperTabDefaultCompletionType = "context"

"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
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

    " pig filetype detection
    autocmd BufNewFile,BufRead *.pig set filetype=pig syntax=pig
endif

" UI config
colorscheme vividchalk
set guioptions=er
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
hi cursorline cterm=none

" Ack motions {{{
nnoremap <silent> <leader>a :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> <leader>a :<C-U>call <SID>AckMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AckMotion(type) abort
    let reg_save = @@

    call s:CopyMotionForType(a:type)

    execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"

    let @@ = reg_save
endfunction
" }}}

" Vimux {{{
function! VimuxSlime()
    call VimuxOpenRunner()
    call VimuxSendText(@v)
    call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <silent><leader>v "vy :call VimuxSlime()<CR>
" }}}
