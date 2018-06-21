" nvimrc
" Author: Theo Delrieu <delrieutheo@gmail.com>
" Source: https://github.com/delrieutheo/dotnvim/blob/master/nvimrc

" Plugins ------------------------------------------------------------------ {{{

filetype plugin indent on
syntax on

set packpath^=~/.nvim
packadd minpac

set runtimepath+=~/.fzf

call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('sjl/gundo.vim')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tomtom/tcomment_vim')
call minpac#add('Konfekt/FastFold')
call minpac#add('derekwyatt/vim-fswitch')
call minpac#add('danro/rename.vim')
call minpac#add('junegunn/fzf', {'dir': '~/.fzf', 'do': '!./install --all'})
call minpac#add('junegunn/fzf.vim')
call minpac#add('ctrlpvim/ctrlp.vim')

" Go
call minpac#add('fatih/vim-go')

" Javascript
call minpac#add('pangloss/vim-javascript')

" Kotlin
call minpac#add('udalov/kotlin-vim')

" Swift
call minpac#add('bumaociyuan/vim-swift')

" Snippets
call minpac#add('SirVer/ultisnips')

" tpope
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-surround')

" vim-scripts
call minpac#add('vim-scripts/vim-stay')                 " Open a previously closed file where you left it

" Colors
call minpac#add('nanotech/jellybeans.vim')
call minpac#add('w0ng/vim-hybrid')
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('luochen1990/rainbow')

" Syntax
call minpac#add('octol/vim-cpp-enhanced-highlight')
call minpac#add('pboettch/vim-cmake-syntax')

" Completion
call minpac#add('Valloric/YouCompleteMe', {'do': {-> system('./install.py --clang-completer')}})
call minpac#add('Valloric/ListToggle')
call minpac#add('ervandew/supertab')

" Cosmetics
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('ryanoasis/vim-devicons')

" }}}

packloadall

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

" ListToggle
nnoremap  <silent> <leader>q  :QToggle<CR>
nnoremap  <silent> <leader>l  :LToggle<CR>

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

" }}}

" Plugin configuration ----------------------------------------------------- {{{

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

""" rainbow ---------------------------------------------------------------- {{{

let g:rainbow_active = 1

" this plugin wrecks vim-cmake-syntax
let g:rainbow_conf = {
                      \'parentheses':
                          \['start=/(/ end=/)/',
                           \'start=/\[/ end=/\]/',
                           \'start=/{/ end=/}/ fold'],
                      \'separately': {
                      \  'cmake': 0
                      \ }
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
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1

""" }}}

""" vim-go --------------------------------------------- {{{

let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1

""" }}}

""" vim-fswitch --------------------------------------------- {{{

let g:fsnonewfiles = 1
augroup my_fswitch_au_group
    au!
    au BufEnter *.h   let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.hh  let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.hpp let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.hxx let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'
    au BufEnter *.H   let b:fswitchlocs = 'reg:|include/[^/]\+|src|,reg:/include/src/,ifrel:|/include/|../src|'

    au BufEnter *.c   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.cc  let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.cpp let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.cxx let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.C   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
    au BufEnter *.m   let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/*|,ifrel:|/src/|../include|'
augroup END
command A FSHere

""" }}}

""" vim-javascript --------------------------------------------- {{{
let g:javascript_plugin_flow = 1
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
