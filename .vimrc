set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'mhinz/vim-signify'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'Raimondi/delimitMate'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'chriskempson/base16-vim'
Plugin 'sjl/gundo.vim'
Plugin 'klen/python-mode'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'godlygeek/tabular'
Plugin 'farseer90718/vim-taskwarrior'

syntax on
filetype on
filetype plugin indent on

set autochdir
set showmatch
set showcmd
set wildmenu
set wildmode=list:longest,full
set number
set incsearch
set ignorecase
set incsearch
set nowrap
set backspace=indent,eol,start
set noswapfile

autocmd FileType python,sh,html,css,perl setlocal ts=4 sts=4 sw=4 et ai
autocmd FileType scss,ruby,eruby,yml setlocal ts=2 sts=2 sw=2 et ai

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12.5
set background=dark
colorscheme Tomorrow-Night
set laststatus=2

nnoremap <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$']

nnoremap <F5> :GundoToggle<CR>

nnoremap <F6> :TagbarToggle<CR>

set ssop+=resize,winpos,winsize,blank,buffers,curdir,folds,help,options,tabpages
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5

let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_doc = 0

let g:airline_powerline_fonts = 1

let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pylama']

if has('gui_running')
    set guioptions-=m
    set guioptions-=e
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=R
    set guioptions-=l
endif
