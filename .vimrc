autocmd! bufwritepost .vimrc source %
filetype plugin on
filetype indent on
set encoding=utf-8
syntax on			"show syntax

set autoread        "auto update when modified outside"
set so=10
set mat=2
set clipboard=unnamedplus

"fuck off annoying backup shit im not stupid
set noswapfile
set nowb
set nobackup

set relativenumber		"show numbers as relative
set number
set tabstop=4			"4 spaces as tab
set shiftwidth=4		"4 spaces on <<>>
set softtabstop=4		"actual tab press
set expandtab			"make tabs spaces
set splitright          "split right then below 
set splitbelow          " ^ ^ 
set lazyredraw          " fix screen tearing 
set backspace=indent,eol,start "Made backspace nice
set nocompatible        "remove vi compatibability
set autoindent          " auto indent
set smarttab
"List chars for nice marking

"set list
"set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set laststatus=2 "always show status bar
"Omnicomplete
"set omnifunc=syntaxcomplete#Complete
"set completeopt=longest,menuone,preview
"searching
set ignorecase			"ignore word case when searching
set incsearch			"incremenet search
set showmatch			"show matches
set hlsearch			"hl search
set wrap			"wrap text

set tags+=/home/maki/.vim/tags/cpp
"remap ; to :
nnoremap ; :
nnoremap : ;

" " Switch tabs with ctrl + h/l
nnoremap <silent><S-n> :tabnew<CR>
nnoremap <silent><S-h> :tabp<CR>
nnoremap <silent><S-l> :tabn<CR>

"colorscheme zenburn

let g:neocomplete#enable_at_startup = 1                 " Use neocomplete ate startup
let g:neocomplete#enable_smart_case = 1                 " use smart case
let python_highlight_all=1

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal autoindent syntax=html omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType python setlocal completeopt=preview   " No docstring

"autocmd FileType php setlocal autoindent syntax=php syntax=html
" Enable heavy omni completion.
"
set updatetime=250


" set statusline+=%#warningmsg#                           " Syntastic status settings
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

 let g:syntastic_error_symbol = '✘'                      " warning symbols
 let g:syntastic_warning_symbol = "▲"

 let g:syntastic_always_populate_loc_list = 1            " always errors
 let g:syntastic_auto_loc_list = 1
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0

 let g:syntastic_html_tidy_exec = 'tidy'                 " html checker
 let g:syntastic_python_checkers = ['flake8']            " python checker
 let g:syntastic_php_checkers = ['phpmd']                " php checker

"custom keymappings
"
"quick save & quit
nnoremap <leader>w :<esc>:w<cr>
nnoremap <leader>wq :<esc>:wq<cr>

map <F5> :make<CR>
map <F6> :make clean all<CR>


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

"Enable folding
set foldmethod=indent
set foldlevel=99


nnoremap <space> za

"python settings

au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
