  " => General
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  set nocompatible                " must be first line

  set encoding=utf-8							" marks the default encoding
  scriptencoding utf-8						" must be *after* the set encoding

  source $VIMRUNTIME/filetype.vim " Add filetype specific manipulations - highlighting/syntax/spacing/etc

  set history=400                 " Sets how many lines of history VIM has to remember
  let mapleader   = "\<Space>"    " Replace the default <leader> key from '\' to space 
  let g:mapleader = "\<Space>"    " Replace the default <leader> key from '\' to space 

  " Enable filetype plugin
  filetype plugin on
  filetype indent on

  call plug#begin('~/.local/share/nvim/plugged')
  
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'bling/vim-airline'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'fatih/vim-go', { 'for': 'golang', 'do': ':GoInstallBinaries' }
  Plug 'nvie/vim-flake8', { 'for': 'python' }
  Plug 'davidhalter/jedi-vim', { 'for': 'python' }

  " Initialize plugin system
  call plug#end()

  " Fast editing of the .vimrc (with auto reload)
  autocmd! bufwritepost vimrc source ~/.vimrc

  set shortmess+=I	" Remove the initial splash text
  set autoread			" Set to auto read when a file is changed from the outside
  set autowrite			" automatically write a file when leaving a modified buffer

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " => VIM user interface
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " a ruler on steroids
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
  "set so=7                        " Set 7 lines to the cursors - when moving vertical..
  set showmode                    " display the current mode
  set wildmenu                    " Turn on WiLd menu
  set wildchar=<Tab>							"
  set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
  set cursorline                  " highlight current line
  set ruler                       " Always show current position
  set showcmd                     " show partial commands in status line selected characters/lines in visual mode
  set cmdheight=2                 " The commandbar height
  set hidden                      " Change buffer - without saving
  set backspace=eol,start,indent  " Set backspace config
  set whichwrap+=<,>,h,l
  set ignorecase                  " Ignore case when searching
  set smartcase
  set hlsearch                    " Highlight search things
  set incsearch                   " Make search act like search in modern browsers
  set nolazyredraw                " Don't redraw while executing macros
  set magic                       " Set magic on, for regular expressions
  set showmatch                   " Show matching braces when text indicator is over them
  set mat=2                       " How many tenths of a second to blink
  set title

  set cpoptions+=$

  " No sound on errors
  set noerrorbells
  set novisualbell
  set t_vb=
  set tm=500

  " Use standard regex
  nnoremap / /\v
  vnoremap / /\v

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " => Colors and Fonts
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  syntax on          "Enable syntax hl
  set number         " show line numbers
  set fileencoding=utf-8
  set background=dark
  set ffs=unix,dos,mac     "Default file types

  colorscheme Tomorrow-Night-Bright

  if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
    set t_Co=256
  endif

  if has("gui_running")
    set guioptions-=T
    set guifont   =Hack:h14
    set columns   =150
    set lines     =50               " 50 lines of text instead of 24,
  endif

  set mousehide                   " Hide the mouse when typing text
  set laststatus=2
  hi Cursor guibg=green

  set listchars=trail:·,tab:▸\ ,precedes:«,extends:»,eol:¬
  "set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ 
  set list

  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " => Moving around, tabs and buffers
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " Ignore HELP when trying to push the ESC button!
  inoremap <F1> <ESC>
  nnoremap <F1> <ESC>
  vnoremap <F1> <ESC>

  nnoremap <tab> %			" Much easier to press tab to match
  vnoremap <tab> %

  nnoremap ; :
  nnoremap <leader><space> :noh<cr> " Remove any highlights
  nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>	" cd to update the pwd to dir of opened file

  " System clipboard interaction
  set clipboard=unnamed

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Make a simple "search" text object.
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
 
set guitablabel=%t
set directory=.,$TEMP

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mimic spacemacs bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>fed :e! ~/.vimrc<cr>
 
map <leader>wj <C-W>j
map <leader>wk <C-W>k
map <leader>wh <C-W>h
map <leader>wl <C-W>l
 
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
map <leader>bk :bd<cr>
 
nnoremap <Leader>fs :w<CR>
nnoremap <leader>w- <C-w>s<C-w>j                                                   " Create a split on the current buffer
nnoremap <leader>w/ <C-w>v<C-w>l                                                   " Create a vsplit on the current buffer
 

nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup            " backups are not so nice ...
set noswapfile          " swapfiles are not so nice ...
set nowritebackup
set undolevels=500     "maximum number of changes that can be undone

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab     " expand tabs with spaces
set tabstop=2 softtabstop=2 shiftwidth=2
set smarttab
set lbr
set tw=500
set ai                  "Auto indent
set copyindent
set si                  "Smart indet
set nowrap              "No Wrap lines
let g:netrw_preview = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Default FileTypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile  *.build         setfiletype xml
autocmd BufRead,BufNewFile  *.targets       setfiletype xml
autocmd BufRead,BufNewFile  *.config        setfiletype xml

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nospell                 " spell checking on
map <leader>ss :setlocal spell!<CR>		"Pressing ,ss will toggle and untoggle spell checking

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""
" => python
""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.py 
    \ setfiletype python
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

nnoremap <leader>r :!%:p<CR>

""""""""""""""""""""""""""""""
" => Xml
""""""""""""""""""""""""""""""
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType xml set nowrap
set foldlevelstart=9

""""""""""""""""""""""""""""""
" => Json
""""""""""""""""""""""""""""""
command -range JsonFmt <line1>,<line2>!python3 -m json.tool
vnoremap & :JsonFmt<CR>

" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 1		" set default view: 3 - tree mode 
let g:netrw_sort_options = 'i'		"
let g:netrw_browse_split = 4		" open file in previous buffer
let g:netrw_preview      = 1		" preview window in a vertical split
let g:netrw_altv         = 1		" open files on right
let g:netrw_winsize      = 20		" size of netrw window

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR> 



""""""""""""""""""""""""""""""
" => NVim Specific
""""""""""""""""""""""""""""""
if has('nvim')
  set clipboard+=unnamedplus
endif

""""""""""""""""""""""""""""""
" => Plugin configuration
""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
let g:airline_theme='dark'
let g:airline_left_sep=' '
let g:airline_left_alt_sep='|'
let g:airline_right_sep=' '
let g:airline_right_alt_sep='|'
let g:airline_section_z=''

let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll|pdb)$',
	\ }
