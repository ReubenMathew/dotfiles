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


" LSP Plugins
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

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
    let g:lightline.colorscheme = 'rosepine_dawn'
  else
    " switch to dark
    set background=dark
    colorscheme rosepine
    let g:lightline.colorscheme = 'rosepine'
  endif
  " Reload lightline
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()

  " transparent background
  hi Normal guibg=NONE ctermbg=NONE

endfunction
nnoremap <silent><leader>z :call UpdateBackground()<CR>
" ----------------------------------

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
let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" TODO: Replace
"nnoremap gfs :GoFillStruct<CR>

" NERDTree Open/Close
map <silent> <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " Show hidden files
" Remap escape key
inoremap <S-Tab> <Esc>
onoremap <S-Tab> <Esc>

" Autocommand
augroup vimrc_autocmd
  autocmd!
  " background color updater
  au BufEnter * call UpdateBackground()
  " Markdown tab settings
  autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
  " Set dockerfile syntax
  autocmd BufNewFile,BufRead Dockerfile* set syntax=dockerfile

  " ------ Go ------ "
  autocmd BufNewFile,BufRead,BufEnter *.go set filetype=go
  " Go Add Tags
  autocmd FileType go nnoremap gat :CocCommand go.tags.add json<cr>
  " Add missing imports on save
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.formatDocument')

  " Lightline update on coc status change
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Applying code actions to the selected code block
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

" Fzf Bindings
nnoremap <c-p> :GFiles<CR>
map <c-f> :Rg<CR>

" Move lines up/down
nnoremap <A-up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>

" Insert Timestamp (current)
autocmd FileType md nnoremap <c-T> :r! date "+\%m-\%d-\%Y \%H:\%M:\%S"<CR>
autocmd FileType md nnoremap <c-C> :r! ~/Developer/log/misc/checklist_template.md <CR>

" ------------------------------------------------"
" Copilot
let g:copilot_enabled = v:false

" ------------------------------------------------"
" Simple ToDo
let g:simple_todo_list_symbol = '-'
