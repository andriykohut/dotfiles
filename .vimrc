set nocompatible
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'mhinz/vim-signify'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'Raimondi/delimitMate'
Bundle 'majutsushi/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'chriskempson/base16-vim'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'sjl/gundo.vim'
Bundle 'klen/python-mode'
Bundle 'bling/vim-airline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rvm'
Bundle 'SirVer/ultisnips'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/ruby-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'godlygeek/tabular'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'gorodinskiy/vim-coloresque'
Bundle 'mattn/emmet-vim'

syntax on
filetype on
filetype indent on
filetype plugin on

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
autocmd FileType python setlocal ts=4 sts=4 sw=4 et ai
autocmd FileType sh setlocal ts=2 sts=2 sw=2 et ai
autocmd FileType scss,ruby,eruby,css,html,yml setlocal ts=2 sts=2 sw=2 et ai
set backspace=indent,eol,start

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
let g:pymode_folding = 0
let g:pymode_indent = 0
let g:pymode_lint = 0
let g:pymode_doc = 0

let g:airline_powerline_fonts = 1

let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pylama']

let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>"

if has('gui_running')
    set guioptions-=m
    set guioptions-=e
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=R
    set guioptions-=l
endif
