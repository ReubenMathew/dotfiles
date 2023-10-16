set nocompatible

syntax enable
set synmaxcol=9999
syntax sync minlines=256

filetype plugin indent on

set laststatus=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set noerrorbells
set backspace=indent,eol,start
set wrap linebreak

" increase max memory to show syntax highlighting for large files
set maxmempattern=30000
set re=1
set incsearch
set hlsearch
set mouse=a
set noswapfile
set smartcase
set showcmd
set cursorline
set number
set clipboard=unnamed
set lazyredraw
set redrawtime=4000
set wildmenu
set autoindent 
set nocursorcolumn
set nocursorline
set norelativenumber
set updatetime=300
set ttyfast
set shell=/bin/zsh

" Enable omni completion and enable more characters to be available within
" autocomplete by appending to the 'iskeyword' variable.
set iskeyword+=-

" Persistent Undo
if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl  -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
" Kitty Interop
Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}

" Utilities
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'wellle/context.vim'
Plug 'tpope/vim-fugitive'
Plug 'vitalk/vim-simple-todo'
Plug 'rhysd/conflict-marker.vim'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'

" Colorscheme
Plug 'rose-pine/vim'
call plug#end()

" ----------------------------------
" Lightline Settings
" Register the components:
let g:lightline = {}
let g:lightline.component_expand = {
      \   'linter_warnings': 'lightline#coc#warnings',
      \   'linter_errors': 'lightline#coc#errors',
      \   'linter_info': 'lightline#coc#info',
      \   'linter_hints': 'lightline#coc#hints',
      \   'linter_ok': 'lightline#coc#ok',
      \   'status': 'lightline#coc#status',
      \ }

" Set color to the components:
let g:lightline.component_type = {
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_info': 'info',
      \   'linter_hints': 'hints',
      \   'linter_ok': 'left',
      \ }

" Add the components to the lightline:
let g:lightline.active = {
      \   'left': [ [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ],
      \             [ 'coc_status'  ],
      \             [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ }

" Git Fugitive - lightline integration
let g:lightline.component_function = {
      \   'component_function': {
      \     'gitbranch': 'FugitiveHead',
      \     'coc_status': 'coc#status',
      \   }
      \ }

" register compoments:
call lightline#coc#register()
" ----------------------------------

" ----------------------------------
" Colorscheme Settings

let g:disable_float_bg = 1
let g:lightline.colorscheme = 'rosepine'
colorscheme rosepine
set background=dark
" transparent background
hi Normal guibg=NONE ctermbg=NONE

" NERDTree Open/Close
map <silent> <Leader>t :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1 

" Remap escape key
inoremap <S-Tab> <Esc>
onoremap <S-Tab> <Esc>

" NOH on Escape
nnoremap <silent> <Esc> :noh<CR>

" ; same as :
nnoremap ; :

" Autocommand
augroup vimrc_autocmd
  autocmd!
  " Markdown tab settings
  autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
  " Set dockerfile syntax
  autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
augroup END

" JAVA CONFIG
au FileType java set colorcolumn=100

" RUST CONFIG
au FileType rust set colorcolumn=100

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>

" Vim Context
let g:context_enabled = 1

" Fzf Bindings
nnoremap <c-p> :GFiles<CR>
map <c-f> :Rg<CR>

" Move lines up/down
nnoremap <A-up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>

" ------------------------------------------------"
" Copilot
let g:copilot_enabled = v:false

" ------------------------------------------------"
" Simple Todo
let g:simple_todo_list_symbol = '-'
