"set nocompatible

syntax on

filetype plugin indent on

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set noerrorbells
set backspace=indent,eol,start
" increase max memory to show syntax highlighting for large files
set maxmempattern=20000
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
set wildmenu
set autoindent 

"" Filetype specific rules
"" autocmd FileType go setlocal ts=4sw=4 sts=4 expand

" VimPlug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl  -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'fatih/molokai'
Plug 'vitalk/vim-simple-todo'
call plug#end()

" Colorscheme
colorscheme molokai

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
let g:ale_pattern_options = {
      \'\.md$': {'ale_enabled': 0},
      \'\.go$': {'ale_enabled': 0},
      \}

" Global coc.vim extensions
let g:coc_global_extensions = [
      \'coc-html',
      \'coc-json',
      \'coc-sh',
      \'coc-tsserver',
      \]

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
" VIM-GO CONFIGS
" Syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" Enable auto formatting on saving
let g:go_fmt_autosave = 1
" Run `goimports` on your current file on every save
let g:go_fmt_command = "goimports"
" Status line types/signatures
let g:go_fmt_command="gopls"

" Snippets
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-go/gosnippets/snippets'

" Go Add Tags
let g:go_addtags_transform = 'camelcase'
noremap gat :GoAddTags<cr>
let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
     "\ 'vars':  'leftabove 35vnew',
     "\ 'stack': 'botright 10new',
\ }

let g:go_test_show_name = 1
let g:go_list_type = "quickfix"

let g:go_autodetect_gopath = 1

let g:go_gopls_complete_unimported = 1
"let g:go_gopls_gofumpt = 1

" 2 is for errors and warnings
let g:go_diagnostics_level = 2
let g:go_doc_popup_window = 1
let g:go_doc_balloon = 1

let g:go_imports_mode="gopls"
let g:go_imports_autosave=1

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1

let g:go_fold_enable = []

let NERDTreeShowHidden=1 " Show hidden files

map <silent> <Leader>t :NERDTreeToggle<CR>
inoremap <S-Tab> <Esc>
onoremap <S-Tab> <Esc>

" vim-go debug
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

" vim-go quick binds
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

