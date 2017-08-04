" nvimrc
" Author: Theo Delrieu <delrieutheo@gmail.com>
" Source: https://github.com/delrieutheo/dotnvim/blob/master/nvimrc

" Plugins ------------------------------------------------------------------ {{{

filetype plugin indent on
syntax on

call plug#begin('~/.nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/gundo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'Konfekt/FastFold'
Plug 'derekwyatt/vim-fswitch'
Plug 'danro/rename.vim'

" Go
Plug 'fatih/vim-go'

" Javascript
Plug 'pangloss/vim-javascript'

" Snippets
Plug 'SirVer/ultisnips'

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" vim-scripts
Plug 'Conque-GDB'
Plug 'vim-stay'                 " Open a previously closed file where you left it

" Colors
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'luochen1990/rainbow'
Plug 'octol/vim-cpp-enhanced-highlight'

" Completion
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer'}
Plug 'Valloric/ListToggle'
Plug 'rdnetto/YCM-Generator', {'branch' : 'stable'}
Plug 'ervandew/supertab'

" JS lint
Plug 'vim-syntastic/syntastic'

" Cosmetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" }}}

call plug#end()

" Options ------------------------------------------------------------------ {{{

""" Basic ------------------------------------------------------------------ {{{

let mapleader = ","

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set clipboard=unnamed
set completeopt-=preview    " Hide scratch buffer on completion
set cursorline              " Highlight current line
set foldmethod=syntax
set notimeout               " No timeout on key codes
set number
set relativenumber
set scrolloff=999           " Keep the cursor centered
set showbreak=↪             " Show line wrapping character

set background=dark
set mps+=<:>
colorscheme jellybeans

""" }}}

""" Search ----------------------------------------------------------------- {{{

set backup
set undofile
set noswapfile

set undodir=~/.nvim/tmp/undo/
set backupdir=~/.nvim/tmp/backup/
set directory=~/.nvim/tmp/swap/

" Create those directories if needed


if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

""" Search ----------------------------------------------------------------- {{{

set ignorecase
set smartcase

""" }}}

""" Tabs ------------------------------------------------------------------- {{{

set shiftwidth=2            " Number of spaces for auto-indent
set smartindent
set tabstop=2
set expandtab               " Insert spaces instead of tabs

""" }}}

" }}}

" Functions ---------------------------------------------------------------- {{{

let s:highlight_flag = 0

" Toggle the 80+ columns highlight with <leader>w
function! ToggleWidthHighlight()
  if !s:highlight_flag
    let &colorcolumn="80,".join(range(120,999),",") " Highlight 80th column and 120th+
    let s:highlight_flag = 1
  else
    let &colorcolumn=""
    let s:highlight_flag = 0
  endif
endfunction


" Visual search. Stolen from @sjl.
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

" }}}

" Mappings ----------------------------------------------------------------- {{{

" Stop pressing that shift button (qwerty keyboards)
nnoremap ; :
vnoremap ; :

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Buffer switching
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>

" Calls ToggleWidthHighlight
nnoremap <leader>w :call ToggleWidthHighlight()<CR>

" Remove search highlight with //
nnoremap <silent> // :nohlsearch<CR>

" Switch to alternate file.
nnoremap <Leader><Leader> <C-^>

" Splits
nnoremap <silent> ss :split<CR><C-W>j
nnoremap <silent> vv :vsplit<CR><C-W>l

" Search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Tabs
nnoremap T :tabnew<cr>
nnoremap H :tabprev<cr>
nnoremap L :tabnext<cr>

" Convenience
command! W w
command! Q q

" Exit insert mode
inoremap jk <ESC>

" Folds
nnoremap <Space> za

" TComment
map <Leader>c <C-_><C-_>

" clang-format

noremap <leader>x :pyf ~/.config/nvim/clang-format.py<CR>

" Tanker stuff

command Tlogs :%!~/Tanker/build/Desktop/Tools/tlogs -

" }}}

" Plugin configuration ----------------------------------------------------- {{{

""" CamelCaseMotion -------------------------------------------------------- {{{

" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge

""" }}}

""" ConqueGdb -------------------------------------------------------------- {{{

" avoid conflict with mapleader
let g:ConqueGdb_Leader = '\'

""" }}}

""" Ctrl-P ----------------------------------------------------------------- {{{

let g:ctrlp_working_path_mode = 'ra'
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_clear_cache_on_exit = 0

""" }}}

""" FastFold --------------------------------------------------------------- {{{

let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes = []

""" }}}

""" Gundo ------------------------------------------------------------------ {{{

nnoremap <F5> :GundoToggle<CR>

""" }}}

""" Hybrid ------------------------------------------------------------------ {{{

let g:hybrid_custom_term_colors = 1

""" }}}


""" ListToggle ------------------------------------------------------------- {{{

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

""" }}}

""" rainbow ---------------------------------------------------------------- {{{

let g:rainbow_active = 1
let g:rainbow_conf = {
                      \'parentheses': 
                          \['start=/(/ end=/)/',
                           \'start=/\[/ end=/\]/',
                           \'start=/{/ end=/}/ fold'],
                    \}

""" }}}

""" SuperTab --------------------------------------------------------------- {{{

let g:SuperTabDefaultCompletionType = '<C-j>'
let g:SuperTabMappingForward = '<C-j>'
let g:SuperTabMappingBackward = '<C-k>'
let g:SuperTabClosePreviewOnPopupClose = 1

""" }}}


""" UltiSnips -------------------------------------------------------------- {{{

let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips/']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

""" }}}

""" vim-airline ------------------------------------------------------------ {{{

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_powerline_fonts = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

""" }}}

""" vim-cpp-enhanced-highlight --------------------------------------------- {{{

let g:cpp_class_scope_highlight = 1

""" }}}

""" vim-go --------------------------------------------- {{{

let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1

""" }}}

""" vim-fswitch --------------------------------------------- {{{

let g:fsnonewfiles = 1
augroup my_fswitch_au_group
    au!
    au BufEnter *.h   let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|../src|'
    au BufEnter *.hh  let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|../src|'
    au BufEnter *.hpp let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|../src|'
    au BufEnter *.hxx let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|../src|'
    au BufEnter *.H   let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|../src|'
augroup END
command A FSHere 

""" }}}

""" vim-javascript --------------------------------------------- {{{
let g:javascript_plugin_flow = 1
""" }}}

""" 

""" syntastic --------------------------------------------- {{{
let g:syntastic_javascript_checkers = ['eslint', 'flow']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
""" }}}

""" YouCompleteMe ---------------------------------------------------------- {{{

nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>f :YcmCompleter GoToDefinition<CR>
nnoremap <leader>e :YcmCompleter GoToInclude<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>i :YcmCompleter FixIt<CR>

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_always_populate_location_list = 1
let g:ycm_extra_conf_globlist = ['~/*']
" basic config
let g:ycm_global_ycm_extra_conf = '${HOME}/.config/nvim/.ycm_extra_conf.py'

""" }}}

" }}}
