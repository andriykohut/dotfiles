set nocompatible
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle' " Plugin management
Bundle 'tpope/vim-fugitive' " Git support
Bundle 'scrooloose/nerdtree' " File browser
Bundle 'mhinz/vim-signify' " Show git diffs in editor
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session' " These two for autosaving and restoring session
Bundle 'Raimondi/delimitMate' " Insert matching brackets
Bundle 'majutsushi/tagbar' " Show modulte structure with ctags
Bundle 'kien/ctrlp.vim' " Fast file navigation with ctrl-p
Bundle 'chriskempson/base16-vim' " Cool colorschemes
Bundle 'chriskempson/vim-tomorrow-theme' " That colorschemes too
Bundle 'hynek/vim-python-pep8-indent' " Nice automatic indentation for python
Bundle 'sjl/gundo.vim' " Undo tree
Bundle 'klen/python-mode' " That's big, all python ide features.
Bundle 'bling/vim-airline' " Cool statusline
Bundle 'Valloric/YouCompleteMe' " Code completion
Bundle 'vim-ruby/vim-ruby' " Better ruby support
Bundle 'tpope/vim-endwise' " Automatic end for ruby blocks
Bundle 'tpope/vim-rvm' " RVM support
Bundle 'jlanzarotta/bufexplorer' " Nice for buffer navigation
Bundle 'SirVer/ultisnips' " A lot of useful snippets (Works with YouCompleteMe)
Bundle 'scrooloose/syntastic' " Syntax check and linting

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

" Buffer movements with ctrl (between buffers)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Style
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
set background=dark
colorscheme Tomorrow-Night
set laststatus=2 " Always show statusline

" NerdTree (toggle with F2 and exclude pyc files)
nnoremap <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$']

" Gundo (Shiw undo tree with F5)
nnoremap <F5> :GundoToggle<CR>

" Tagbar (Show tags with F6). Requires exuberant-ctags
nnoremap <F6> :TagbarToggle<CR>

" Session autosave
set ssop+=resize,winpos,winsize,blank,buffers,curdir,folds,help,options,tabpages
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5

" Pymode
let g:pymode_rope = 0 " Disable rope autocompletion (YouCompleteMe is better)
let g:pymode_folding = 0 " Disable code folding
let g:pymode_indent = 0 " Disable indent plugin from pymode (pep-8 indent is better)
let g:pymode_lint = 0 " Disable linter (Syntastic is better)

"Airline
let g:airline_powerline_fonts = 1 " Use nice powerline fonts

"" YouCompleteMe
let g:ycm_key_list_previous_completion=['<Up>'] " Avoid vonflict with unisnips

"" Syntastic
let g:syntastic_always_populate_loc_list = 1 " Always update syntax check result
let g:syntastic_python_checkers = ['pylama'] " Use pylama for syntax check

"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-tab>" " Use Ctrl+tab for snip completion
let g:UltiSnipsListSnippets="<c-s-tab>"

" Remove menu, scrollbar and all gui stuff
if has('gui_running')
    set guioptions-=m
    set guioptions-=e
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=R
    set guioptions-=l
endif
