call plug#begin('~/.vim/plugged')

Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', { 'do' : 'make -f make_mac.mak' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neocomplete.vim'
Plug 'klen/python-mode'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'sjl/gundo.vim'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'eiginn/netrw'
Plug 'mattn/emmet-vim'
Plug 'fatih/vim-go'
Plug 'w0ng/vim-hybrid'
Plug 'rking/ag.vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'vim-perl/vim-perl', { 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'c9s/perlomni.vim', { 'do': 'make install' }
Plug 'haya14busa/incsearch.vim'
Plug 'szw/vim-ctrlspace'

call plug#end()

syntax on
filetype on
filetype plugin indent on

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
set hidden

autocmd FileType python setlocal ts=4 sts=4 sw=4 et ai
autocmd FileType go setlocal ts=4 sts=4 sw=4
autocmd FileType css,html,javascript setlocal ts=2 sts=2 sw=2 et ai
autocmd FileType perl setlocal ts=4 sts=4 sw=4 ai noexpandtab

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set guifont=Monofur\ for\ Powerline:h18
set background=dark
let g:hybrid_use_Xresources = 1
colorscheme hybrid
set laststatus=2

nnoremap ;f :NERDTreeTabsToggle<cr>
nnoremap ;u :GundoToggle<cr>
nnoremap ;t :TagbarToggle<cr>
nnoremap ;o :Unite -toggle -start-insert outline<cr>
nnoremap ;s :Unite -toggle -start-insert file_rec/async<cr>
nnoremap ;g :Unite -toggle -start-insert file_rec/git<cr>
nnoremap ;r :Unite -toggle -start-insert neomru/file<cr>
nnoremap ;b :Unite -toggle -start-insert buffer_tab<cr>

" Unite
call unite#custom#source( 'buffer', 'converters', ['converter_file_directory'])
call unite#custom#source('file_rec/async', 'required_pattern_length', 2)
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" CtrlSpace
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
let g:CtrlSpaceSearchTiming = 500

" NerdTree
let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeIgnore = ['\.pyc$']

" Pymode
let g:pymode_rope = 0
let g:pymode_lint = 0
let g:pymode_doc = 0

" Airine
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_exclude_preview = 1
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

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_python_pylama_args = "-o ~/.pylama"
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checers = ['perlcritic']

" Disable Jedi, we will use neocomplete
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
autocmd FileType python setlocal omnifunc=jedi#completions
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

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
