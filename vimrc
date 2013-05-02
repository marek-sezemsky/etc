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
set hlsearch      " hightlight search
set nojoinspaces  " don't join multiple spaces on Shift-J

" direct Snipmate to my snippets
let g:template_dir="$HOME/.vim/templates"
let g:snippets_dir="$HOME/.vim/snippets"

" Load pathogen for vim 7.x+
if version >= 700
	runtime bundle/vim-pathogen/autoload/pathogen.vim
	execute pathogen#infect()
	execute pathogen#helptags()
endif

" use syntax hightlight and filetype plugins
syntax on
filetype plugin indent on

set background=dark
colorscheme default
set noerrorbells visualbell t_vb=        " no a/v bells...
autocmd GUIEnter * set visualbell t_vb=  " ...especially in GUI

" perldoc of current file on F2
map <F2> :!perldoc %:p<CR>

" re-wrap on F3
map <F3> gq

" taglist on F4
let Tlist_Exit_OnlyWindow = 1 " close when taglist is last
let Tlist_File_Fold_Auto_Close = 1  "close fold for inactive buffers
let Tlist_GainFocus_On_ToggleOpen = 1 " switch automatically to taglist
map <F4> :TlistToggle<ENTER>

" Status line:
" [1 file[+][RO]  Ln 36, Col  2 chr(0d012,0x0C) 80%]
set statusline =%n:\ %f%h%m%r%<%=
set statusline+=%(Ln\ %l/%L,\ Col\ %2c%)
set statusline+=\ %{&ff}%Y\ ord(0d%03b,0x%02B)\ %P
set laststatus=2

" Filetypes:
"au BufRead,BufNewFile ~/public_html/*/templates/* set filetype=tt2html
autocmd BufRead,BufNewFile *.tt2 set filetype=tt2html
autocmd BufRead,BufNewFile *git/COMMIT_EDITMSG set filetype=diff
autocmd FileType tt2html setlocal tabstop=1 shiftwidth=1 expandtab softtabstop=1 foldmethod=syntax
autocmd FileType perl,sh,markdown,python setlocal foldmethod=marker ts=4 sw=4 st=4 expandtab tw=78

" Update diff on file write
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
