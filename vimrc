set nocompatible

syntax on

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
set re=0
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
set nocursorcolumn
set nocursorline
set norelativenumber
set updatetime=300
set synmaxcol=200
set ttyfast

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
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vitalk/vim-simple-todo'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/conflict-marker.vim'
Plug 'wellle/context.vim'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'rose-pine/vim'
"Plug 'rust-lang/rust.vim', { 'for': 'rust' }
call plug#end()


" Colorscheme Settings
let g:disable_float_bg = 1

" Get Kitty Background Color
" requires:
"   - rose pine background
"   - kitty remote control
function! UpdateBackground()
  let background_color = trim(system('kitty @ get-colors | grep -w "background" | awk "{print \$2}"'))

  if (background_color == "#faf4ed")
    " switch to light
    set background=light
    colorscheme rosepine_dawn
    let g:lightline = { 'colorscheme': 'rosepine_dawn' }
  else
    " switch to dark
    set background=dark
    colorscheme rosepine
    let g:lightline = { 'colorscheme': 'rosepine' }
  endif
endfunction
nnoremap <silent><leader>z :call UpdateBackground()<CR>


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

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"

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

" Global coc.vim extensions
"let g:coc_global_extensions = [
      "\'coc-html',
      "\'coc-json',
      "\'coc-sh',
      "\'coc-tsserver',
      "\]

" VIM-GO CONFIGS
" Syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_command="gopls"
" Enable auto formatting on saving
let g:go_fmt_autosave = 1

" Snippets
"let g:neosnippet#snippets_directory='~/.vim/plugged/vim-go/gosnippets/snippets'

" Go Add Tags
let g:go_addtags_transform = 'camelcase'
let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
      "\ 'vars':  'leftabove 35vnew',
      "\ 'stack': 'botright 10new',
      \ }

noremap gat :GoAddTags<CR>
nnoremap gfs :GoFillStruct<CR>

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

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1

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
    call go#test#Test(0, 0)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Autocommand
augroup vimrc_autocmd
  autocmd!
  "autocmd FileType go setlocal ts=4 sw=4 sts=4 expa
  " background color updater
  au BufEnter * call UpdateBackground()

  autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nnoremap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <Leader>s <Plug>(go-alternate-vertical)
augroup END

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a  <Plug>(coc-codeaction-selected)<CR>

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" JAVA CONFIG
au FileType java set colorcolumn=100
autocmd BufWritePre *.java call CocAction('format')

" RUST CONFIG
au FileType rust set colorcolumn=100
let g:rustfmt_autosave = 1

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>

" Vim Context
let g:context_enabled = 1

" Ctrl-P Bindings
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

" Fzf Bindings
nnoremap <c-p> :GFiles<CR>
map <c-f> :Rg<CR>

" Move lines up/down
nnoremap <A-up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>

" Insert Timestamp (current)
nnoremap <c-T> :r! date "+\%m-\%d-\%Y \%H:\%M:\%S"<CR>

" Performance
"set timeoutlen=1000
"set ttimeoutlen=0
"function! CloseHiddenBuffers()
  "let open_buffers = []

  "for i in range(tabpagenr('$'))
    "call extend(open_buffers, tabpagebuflist(i + 1))
  "endfor

  "for num in range(1, bufnr("$") + 1)
    "if buflisted(num) && index(open_buffers, num) == -1
      "exec "bdelete ".num
    "endif
  "endfor
"endfunction
"au BufEnter * call CloseHiddenBuffers()

" ------------------------------------------------"
" Copilot
let g:copilot_enabled = v:false
