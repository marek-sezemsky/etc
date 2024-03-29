""
"" Marek's vimrc
""

" Basics
set nocompatible
set nobackup
set modeline
set backspace=indent,eol,start " backspace over indent
set fileformats=unix,dos
set showmatch     " show matching parenthesis
set incsearch     " incremental search
set smartcase     " ignore case when lc(pattern)
set smartindent   " smart indenting on new line
set hlsearch      " hightlight search
set nojoinspaces  " don't join multiple spaces on Shift-J
set formatoptions+=jro  " better comment handling on inserts,join,etc.
set expandtab     " expand tabs with 4 spaces
set scrolloff=3   " scrolloffset 3 lines
set number
set nowrap

" open files unfolded
set foldlevelstart=99

" enable mouse
set mouse=a

" direct Snipmate to my snippets
let g:templates_directory="$HOME/.vim/templates"
let g:snippets_dir="$HOME/.vim/snippets"

" let's not be sensible
let g:polyglot_disabled = ['sensible']

" Load pathogen for vim 7.x+
if version >= 700
	runtime bundle/vim-pathogen/autoload/pathogen.vim
	execute pathogen#infect()
	execute pathogen#helptags()
endif

" use syntax hightlight and filetype plugins
syntax on
filetype plugin indent on

colorscheme default
set background=dark
set noerrorbells visualbell t_vb=        " no a/v bells...
autocmd GUIEnter * set visualbell t_vb=  " ...especially in GUI

" re-wrap on F3
map <F3> gq

" taglist on F4
let Tlist_Exit_OnlyWindow = 1 " close when taglist is last
let Tlist_File_Fold_Auto_Close = 1  "close fold for inactive buffers
let Tlist_GainFocus_On_ToggleOpen = 1 " switch automatically to taglist
map <F4> :TlistToggle<ENTER>

" nerdtree on F5
map <F5> :NERDTreeToggle<ENTER>

set wildmode=longest,list,full
set wildmenu

" Status line:
" [1 file[+][RO]  Ln 36, Col  2 chr(0d012,0x0C) 80%]
set statusline =%n:\ %f%h%m%r%<%=
set statusline+=%(Ln\ %l/%L,\ Col\ %2c%)
set statusline+=\ %{&ff}%Y\ ord(0d%03b,0x%02B)\ %P
set laststatus=2

" Filetypes
"au BufRead,BufNewFile */www/templates/* set filetype=tt2html
autocmd BufRead,BufNewFile *.tt2 set filetype=tt2html
autocmd BufRead,BufNewFile *git/COMMIT_EDITMSG set filetype=diff
autocmd BufRead,BufNewFile *.t set filetype=perl
autocmd BufRead,BufNewFile *.groovy set filetype=groovy
autocmd BufRead,BufNewFile Containerfile* set filetype=dockerfile

autocmd FileType mediawiki setlocal wrap linebreak nolist expandtab wrapmargin=40
autocmd FileType mediawiki setlocal textwidth=0 wrapmargin=0
autocmd FileType perl,sh,markdown,python,mediawiki,javascript,groovy
	\ setlocal foldmethod=indent ts=4 sw=4 st=4 expandtab tw=0
autocmd FileType css,html,htmldjango
	\ setlocal foldmethod=indent ts=2 sw=2 st=2 expandtab tw=0

" Update diff on file write
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

