call plug#begin('~/.vim/plugged')

Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'Konfekt/FastFold'
Plug 'Shougo/neocomplete.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-fnr'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'jszakmeister/vim-togglecursor'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'hdima/python-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'heavenshell/vim-pydocstring'
Plug 'davidhalter/jedi-vim'
Plug 'lambdalisue/vim-pyenv'
Plug 'w0ng/vim-hybrid'

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
if has("mac")
  set guifont=Fantasque\ Sans\ Mono:h15
else
  set guifont=Fantasque\ Sans\ Mono\ 13
end
set background=dark
colorscheme hybrid


" NERDTree
let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeIgnore = ['\.pyc$']

" python
let python_highlight_all = 1
autocmd FileType python syn keyword Identifier self cls

" vim-pyenv with jedi-vim
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

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_exclude_preview = 1

" navigate to specific buffers
nmap ,1 <Plug>AirlineSelectTab1
nmap ,2 <Plug>AirlineSelectTab2
nmap ,3 <Plug>AirlineSelectTab3
nmap ,4 <Plug>AirlineSelectTab4
nmap ,5 <Plug>AirlineSelectTab5
nmap ,6 <Plug>AirlineSelectTab6
nmap ,7 <Plug>AirlineSelectTab7
nmap ,8 <Plug>AirlineSelectTab8
nmap ,9 <Plug>AirlineSelectTab9

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8']

" gitgutter
let g:gitgutter_max_signs = 5000

" neocomplete
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

" ultisnips
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" unite
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

nnoremap ,o :Unite -toggle -start-insert outline<cr>
nnoremap ,s :Unite -toggle -start-insert file_rec/async<cr>
nnoremap ,g :Unite -toggle -start-insert file_rec/git<cr>
nnoremap ,m :Unite -toggle -start-insert neomru/file<cr>
nnoremap ,b :Unite -toggle -start-insert buffer_tab<cr>

call unite#custom#source( 'buffer', 'converters', ['converter_file_directory'])
call unite#custom#source('file_rec/async', 'required_pattern_length', 2)
call unite#custom#source('file_rec/git', 'required_pattern_length', 2)
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" Other mappings
nnoremap ,n :NERDTreeTabsToggle<cr>
nnoremap ,u :UndotreeToggle<cr>
nnoremap ,t :TagbarToggle<cr>
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

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
