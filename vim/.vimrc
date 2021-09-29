" # Modernize
" We aren't using typewriters any more

" Note: a lot of settings are coming from vim-sensible
" As an alternative, I can just include this trio of lines
"   source $VIMRUNTIME/defaults.vim
"   " The above auto-jumps to last-known position. Turn that off.
"   augroup vimStartup | autocmd! | augroup END

set nojoinspaces
set nobackup noswapfile
set visualbell
set matchpairs+=<:>

" reading and writing buffers
set autoread autowrite hidden

set shiftwidth=4 tabstop=4 expandtab shiftround

set modeline modelines=5

" # Display

set laststatus=2 number showmode
set relativenumber
set lazyredraw
set showmatch cursorline
"if has('gui_running')
  set list listchars=tab:»·,trail:·,nbsp:␣
"else
"  set list listchars=tab:<->,trail:.,nbsp:%
"endif

" a nice status line for my NAS
if !has('packages')
  set statusline=%F%m%r%h%w\ [%Y]\ [ASCII=\%03.3b\ HEX=\%02.2B]\ [POS=%04l,%04v\ %p%%\ of\ %L]
endif

" }}} end display

" Search {{{

" searching becomes very magic (perl-esque)
noremap / /\v
vnoremap / /\v

set hlsearch
set ignorecase smartcase

" }}} end search

" Custom mappings {{{

let mapleader = ","
let maplocalleader = "\\"


" I don't want to jump all the way to <Esc>
noremap! jk <esc>

" uppercase an entire word, ending on the end of the word
nnoremap <leader>u bgUe
inoremap <leader>u <esc>bgUei

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" quote a word, ending on the last quote
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" quote what is visually selected
vnoremap <leader>" <esc>`<i"<esc>`>a"
vnoremap <leader>' <esc>`<i'<esc>`>a'

" while in insert mode, append/prepend a new line (and go to that line)
" saves from <esc>O
inoremap <leader>o <esc>o
inoremap <leader>O <esc>O

" Visually highlight last pasted text
nnoremap <leader>V `[v`]

" # File-specific settings

augroup file_types
  autocmd!
  autocmd BufRead,BufNewFile *.rb :set shiftwidth=2 tabstop=2
  autocmd BufRead,BufNewFile *.clj :set shiftwidth=2 tabstop=2 cindent
  autocmd BufRead,BufNewFile *.wiki :set foldlevel=2
  autocmd BufRead,BufNewFile *.java :set textwidth=120
augroup END

" # Vimscript file settings

augroup vim_type
  autocmd!
  autocmd FileType vim :setlocal foldmethod=marker foldlevelstart=0
  autocmd FileType vim :setlocal shiftwidth=2 tabstop=2
augroup END

" # Tree browsing

let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" vim: filetype=vim
