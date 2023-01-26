set nocompatible

syntax on

filetype plugin indent on

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start

" Filetype specific rules
" autocmd FileType go setlocal ts=4sw=4 sts=4 expand

set smartcase
set showcmd
set cursorline
set number

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
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
call plug#end()

" coc.vim
" --------
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Disable linting for the following files
let g:ale_pattern_options = {'\.md$': {'ale_enabled': 0}}

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
let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1

map <silent> <Leader>t :NERDTreeToggle<CR>
"map <silent> <Leader>t :TagbarToggle<CR>
"map <silent> <Leader>F :NERDTreeFind<CR>
"map <silent> <Leader>p :Files<CR>
inoremap <S-Tab> <Esc>
onoremap <S-Tab> <Esc>

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
