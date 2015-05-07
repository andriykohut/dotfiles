" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
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
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'airblade/vim-gitgutter'
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
NeoBundle 'rstacruz/sparkup'
NeoBundle 'fatih/vim-go'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'fisadev/vim-isort'
NeoBundle 'rking/ag.vim'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'benmills/vimux'
NeoBundle 'farseer90718/vim-taskwarrior'
NeoBundle 'dag/vim2hs'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'jszakmeister/vim-togglecursor'
NeoBundle 'vim-perl/vim-perl', {
\ 'build' : {
\     'mac' : 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny',
\     'linux' : 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny',
\    },
\ }
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'c9s/perlomni.vim', {
\ 'build' : {
\     'mac' : 'make install',
\     'linux' : 'make install',
\    },
\ }
" Do not load vim-pyenv until *.py is opened and
" make sure that it is loaded after jedi-vim is loaded.
NeoBundleLazy 'lambdalisue/vim-pyenv', {
\ 'depends': ['davidhalter/jedi-vim'],
\ 'autoload': { 'filetypes': ['python', 'python3'], }
\ }

call neobundle#end()

syntax on
filetype on
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set showmatch
set showcmd
set wildmenu
set wildmode=list:longest,full
set number
set ignorecase
set incsearch
set nowrap
set backspace=indent,eol,start
set noswapfile
set lazyredraw

autocmd FileType python,sh,perl,c,sql,javascript setlocal ts=4 sts=4 sw=4 et ai
autocmd FileType scss,ruby,eruby,yaml,haml,haskell setlocal ts=2 sts=2 sw=2 et ai
autocmd FileType cpp,c setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType go setlocal ts=4 sts=4 sw=4
autocmd FileType css,html setlocal ts=2 sts=2 sw=2

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set guifont=Monaco\ for\ Powerline:h16
set background=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid
set laststatus=2

nnoremap <F2> :NERDTreeTabsToggle<CR>

nnoremap <F5> :GundoToggle<CR>

nnoremap <F6> :TagbarToggle<CR>

call unite#custom#source( 'buffer', 'converters', ['converter_file_directory'])
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap ;u :Unite -start-insert<CR>
nnoremap ;b :Unite buffer<CR>
nnoremap ;f :Unite -start-insert file_rec/async:!<CR>
nnoremap ;o :Unite -start-insert outline<CR>
nnoremap ;r :Unite -start-insert file_mru<CR>

let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeIgnore = ['\.pyc$']

let g:pyenv#auto_activate = 0

let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_doc = 0

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" navigate to specific buffers
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_python_pylama_args = "-o ~/.pylama"

let g:syntastic_perl_checers = ['perlcritic']

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
" Perlomni
let g:neocomplete#force_omni_input_patterns.perl = '\h\w*->\|\h\w*->\h\w*\|\h\w*::\|\h\w*::\h\w*'

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

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Snippet engine for golang
let g:go_snippet_engine = "neosnippet"

if has('gui_running')
    set guioptions-=m
    set guioptions-=e
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=R
    set guioptions-=l
    set cursorline
else
    set term=screen-256color
endif
