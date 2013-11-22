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
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rvm'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'SirVer/ultisnips'
Bundle 'scrooloose/syntastic'

syntax on
filetype on
filetype indent on
filetype plugin on

" General settings
set autochdir " set working directory to the current file
set showmatch " show matching braces
set showcmd " show current command
set wildmenu " autocomplete commands on bottom
set wildmode=list:longest,full
set number " show line numbers
set incsearch " incremental search
set ignorecase " case insensetive search
set incsearch " sensetive when pattern have uppercase letter
autocmd FileType python setlocal ts=4 sts=4 sw=4 et ai " Python settings
autocmd FileType sh setlocal ts=2 sts=2 sw=2 et ai
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 et ai
set backspace=indent,eol,start

" Keymaps

" Buffer movements with ctrl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Style
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
set background=dark
colorscheme Tomorrow-Night
set laststatus=2

" NerdTree
nnoremap <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$']

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Tagbar
nnoremap <F6> :TagbarToggle<CR>

" Session autosave
set ssop+=resize,winpos,winsize,blank,buffers,curdir,folds,help,options,tabpages
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5

" Pymode
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_indent = 0
let g:pymode_lint = 0

"Airline
let g:airline_powerline_fonts = 1

"" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>']

"" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pylama']

"" Ultisnips
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
