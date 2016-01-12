set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/neocomplete.vim'
Plug 'szw/vim-ctrlspace'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-fnr'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'eiginn/netrw'
Plug 'mattn/emmet-vim'
Plug 'rking/ag.vim'
Plug 'jszakmeister/vim-togglecursor'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Python
Plug 'hdima/python-syntax'
Plug 'tmhedberg/SimpylFold'
Plug 'heavenshell/vim-pydocstring'
Plug 'davidhalter/jedi-vim'
Plug 'lambdalisue/vim-pyenv'
" Go
Plug 'fatih/vim-go'
" Perl
Plug 'vim-perl/vim-perl', { 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'c9s/perlomni.vim', { 'do': 'make install' }
" Colorschemes
Plug 'w0ng/vim-hybrid'
" C
Plug 'osyo-manga/vim-marching'

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
set hidden
set noautochdir
set autoindent
set smarttab
set formatoptions+=j
set autoread
set laststatus=2

let g:hybrid_custom_term_colors = 1
set guifont=Fantasque\ Sans\ Mono:h15
set background=dark
colorscheme hybrid

autocmd FileType python,c setlocal ts=4 sts=4 sw=4 et ai
autocmd FileType go setlocal ts=4 sts=4 sw=4
autocmd FileType css,html,javascript setlocal ts=2 sts=2 sw=2 et ai
autocmd FileType perl setlocal ts=4 sts=4 sw=4 ai noexpandtab
autocmd FileType make setlocal ts=4
autocmd BufRead,BufNewFile *.tt set filetype=tt2html

" SimplyFold stuff
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

let mapleader = ' '
let maplocalleader = ' '

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffer movement
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

nnoremap <Leader>f :NERDTreeTabsToggle<cr>
nnoremap <Leader>u :UndotreeToggle<cr>
nnoremap <Leader>t :TagbarToggle<cr>

if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

" Unite
nnoremap <Leader>o :Unite -toggle -start-insert outline<cr>
nnoremap <Leader>s :Unite -toggle -start-insert file_rec/async<cr>
nnoremap <Leader>g :Unite -toggle -start-insert file_rec/git<cr>
nnoremap <Leader>m :Unite -toggle -start-insert neomru/file<cr>
nnoremap <Leader>b :Unite -toggle -start-insert buffer_tab<cr>
nnoremap <Leader>t :Unite -toggle grep:. -buffer-name=search-buffer<CR>

" Unite
call unite#custom#source( 'buffer', 'converters', ['converter_file_directory'])
call unite#custom#source('file_rec/async', 'required_pattern_length', 2)
call unite#custom#source('file_rec/git', 'required_pattern_length', 2)
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" NerdTree
let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeIgnore = ['\.pyc$']

" Python syntax
let python_highlight_all = 1
autocmd FileType python syn keyword Identifier self cls

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
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checers = ['perlcritic']

" GitGutter
let g:gitgutter_max_signs = 5000

" Neocomplete
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
inoremap <expr><C-g> neocomplete#undo_completion()
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
autocmd FileType python setlocal omnifunc=jedi#completions
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Marching
let g:marching_clang_command = "clang"
let g:marching_include_paths = filter(
  \ split(glob('/usr/include/c++/*'), '\n') +
  \ split(glob('/usr/include/*/c++/*'), '\n') +
  \ split(glob('/usr/include/*/'), '\n'),
  \ 'isdirectory(v:val)')
let g:marching_enable_neocomplete = 1

" UltiSnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" automatically call jedi#force_py_version every after user change a python version of pyenv
if jedi#init_python()
  function! s:jedi_auto_force_py_version() abort
    let major_version = pyenv#python#get_internal_major_version()
    call jedi#force_py_version(major_version)
  endfunction
  augroup vim-pyenv-custom-augroup
    autocmd! *
    autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
    autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
  augroup END
endif

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
