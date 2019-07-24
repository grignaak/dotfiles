" We aren't using typewriters any more
set nocompatible nojoinspaces
set nobackup noswapfile
set visualbell
set backspace=indent,eol,start
set matchpairs+=<:>

set shiftwidth=4 tabstop=4 expandtab smarttab shiftround

" The following lines help force plugins to load correctly
set sessionoptions-=options
filetype off

packadd matchit

" vim on the NAS doesn't have signs
if has('signs')
    packadd 'vim-gitgutter'
endif

syntax on
filetype plugin indent on


" simple display
set laststatus=2 number ruler showmode showcmd
set relativenumber
set wildmenu lazyredraw

" a nice status line
" set statusline=%F%m%r%h%w\ [%Y]\ [ASCII=\%03.3b\ HEX=\%02.2B]\ [POS=%04l,%04v\ %p%%\ of\ %L]\ %{ObsessionStatus('[tracking\ session]','[no\ session]')}
" set statusline=%F%m%r%h%w\ [%Y]\ [ASCII=\%03.3b\ HEX=\%02.2B]\ [POS=%04l,%04v\ %p%%\ of\ %L]

set showmatch cursorline
nnoremap gV `[v`]

set list listchars=tab:»·,trail:·

" searching becomes very magic (perl-esque)
noremap / /\v
vnoremap / /\v

let mapleader = ","
let maplocalleader = "\\"

set hlsearch incsearch
set ignorecase smartcase


" I don't want to jump all the way to <Esc>
noremap! jk <esc>

" Don't require saves when switching buffers
set hidden

" uppercase an entire word, ending on the end of the word
nnoremap <leader>u bgUe
inoremap <leader>u <esc>bgUei

if has('autocmd')
    augroup file_types
        autocmd!
        autocmd BufRead,BufNewFile *.rb :set sw=2 ts=2
        autocmd BufRead,BufNewFile *.clj :set sw=2 ts=2 cindent autoindent
        autocmd BufRead,BufNewFile *.wiki :set foldlevel=2
        autocmd BufRead,BufNewFile *.java :set tw=120
    augroup END
endif


" Tweaks for tree-browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" quote a word, ending on the last quote
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" quote what is visually selected
vnoremap <leader>" <esc>`<i"<esc>`>a"
vnoremap <leader>' <esc>`<i'<esc>`>a'

inoremap <leader>o <esc>o
inoremap <leader>O <esc>O

"echom ">^.^<"
