set nocompatible

syntax on

filetype plugin indent on

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start

" Filetype specific rules
autocmd FileType go setlocal ts=4 sw=4 sts=4 expand 

set smartcase
set showcmd
set cursorline

" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl  -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'w0rp/ale'
" LaTeX support
Plug 'lervag/vimtex'
" git plugin
Plug 'tpope/vim-fugitive'
" status line
Plug 'vim-airline/vim-airline'
call plug#end()

" ALE
let g:ale_sign_column_always=0                             " Don't show the sign column even if there are no linter notes
let g:ale_lint_on_text_changed=1                           " Don't run the linter whenever the text of a file changes: fights with Deoplete
let g:ale_lint_on_enter=1                                  " Run the linter whenever a file is opened
let g:ale_lint_on_save=1                                   " Run the linter whenever a file is saved

" It may be nice to highlight the actual error here too - drop the 'sign' part
highlight ALEErrorSign        ctermfg=1
highlight ALEWarningSign      ctermfg=3
highlight ALEInfoSign         ctermfg=4
highlight ALEStyleErrorSign   ctermfg=3
highlight ALEStyleWarningSign ctermfg=3

highlight ALEError ctermbg=none cterm=underline ctermfg=1

let g:ale_fixers={
      \ 'go': ['gofmt'],
      \}

" vim-go
let g:go_doc_popup_window = 1

map <silent> <C-n> :NERDTreeToggle<CR>
map <silent> <Leader>t :TagbarToggle<CR>
map <silent> <Leader>F :NERDTreeFind<CR>
map <silent> <Leader>p :Files<CR>
