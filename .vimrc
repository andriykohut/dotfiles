if !1 | finish | endif

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'godlygeek/tabular'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'eiginn/netrw'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'dag/vim2hs'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'fisadev/vim-isort'

call neobundle#end()

syntax on
filetype on
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" set autochdir
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

autocmd FileType python,sh,perl,c setlocal ts=4 sts=4 sw=4 et ai
autocmd FileType scss,ruby,eruby,yaml,haml,haskell setlocal ts=2 sts=2 sw=2 et ai
autocmd FileType cpp,c setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType go setlocal ts=4 sts=4 sw=4
autocmd FileType css,html setlocal ts=2 sts=2 sw=2

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set guifont=Input\ Mono\ 12
set background=dark
colorscheme hybrid
set laststatus=2

nnoremap <F2> :NERDTreeToggle<CR>

nnoremap <F5> :GundoToggle<CR>

nnoremap <F6> :TagbarToggle<CR>

noremap <C-P> :<C-u>Unite<cr>

noremap <script> <silent> <unique> <Leader>be :Unite buffer<CR>

set ssop+=resize,winpos,winsize,blank,buffers,curdir,folds,help,options,tabpages
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 5

let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_doc = 0

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_python_pylama_args = "-o ~/.pylama"

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" NeoSnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Unite
let g:unite_enable_start_insert = 1

if has('gui_running')
    set guioptions-=m
    set guioptions-=e
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=R
    set guioptions-=l
else
    set term=screen-256color
endif
