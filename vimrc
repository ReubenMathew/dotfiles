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

" Utilities
Plug 'tpope/vim-fugitive'
Plug 'rhysd/conflict-marker.vim'

" Markdown
Plug 'vitalk/vim-simple-todo'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Theme
Plug 'rose-pine/vim'

call plug#end()

" ----------------------------------
" Colorscheme Settings
let g:disable_float_bg = 1
colorscheme rosepine
set background=dark
" ----------------------------------

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
  autocmd FileType markdown setlocal spell
  autocmd FileType markdown setlocal nonumber
  autocmd FileType markdown hi SpellBad cterm=underline
  " Set dockerfile syntax
  autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
augroup END

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>

" Vim Context
let g:context_enabled = 1

" ------------------------------------------------"
" Simple Todo
let g:simple_todo_list_symbol = '-'

" ------------------------------------------------"
" Markdown
" Enable folding.
let g:vim_markdown_folding_disabled = 1

" Fold heading in with the contents.
let g:vim_markdown_folding_style_pythonic = 1

" Don't use the shipped key bindings.
let g:vim_markdown_no_default_key_mappings = 1

" Autoshrink TOCs.
let g:vim_markdown_toc_autofit = 1

" Indentation for new lists. We don't insert bullets as it doesn't play
" nicely with `gq` formatting. It relies on a hack of treating bullets
" as comment characters.
" See https://github.com/plasticboy/vim-markdown/issues/232
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0

" Filetype names and aliases for fenced code blocks.
let g:vim_markdown_fenced_languages = ['php', 'py=python', 'js=javascript', 'bash=sh', 'viml=vim']

" Highlight front matter (useful for Hugo posts).
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_frontmatter = 1

" Format strike-through text (wrapped in `~~`).
let g:vim_markdown_strikethrough = 0

