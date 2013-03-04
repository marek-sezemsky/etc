"
" Global settings
"
set nocompatible
set nobackup
set modeline

" backspace over indent
set backspace=indent,eol,start
set nojoinspaces

set fileformats=unix,dos

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

set background=dark

set incsearch
set hlsearch
set showmatch

" wrap 
map <F3> gq

" taglist on F4
let Tlist_Exit_OnlyWindow = 1 " close when taglist is last
let Tlist_File_Fold_Auto_Close = 1  "close fold for inactive buffers
let Tlist_GainFocus_On_ToggleOpen = 1 " switch automatically to taglist
map <F4> :TlistToggle<ENTER>

" %file %help %modified %readonly %= separate ...
" .... %b/%B (char/hexa), %line,%column(%VirtualColumn) %Percentage
" "1 file[+][RO]  Ln 36, Col  2 chr(0d012,0x0C) 80%"
set statusline =%n:\ %f%h%m%r%<%=
set statusline+=%(Ln\ %l/%L,\ Col\ %2c%)
set statusline+=\ %{&ff}%Y\ ord(0d%03b,0x%02B)\ %P
set laststatus=2

au BufRead,BufNewFile *.tt2 set filetype=tt2html
au BufRead,BufNewFile ~/public_html/*/templates/* set filetype=tt2html
au BufRead,BufNewFile ~/public_html/*/templates/*html set filetype=html
autocmd FileType tt2html set tabstop=1 shiftwidth=1 expandtab softtabstop=1 foldmethod=syntax
autocmd FileType perl set foldmethod=marker ts=4 sw=4 st=4 expandtab tw=78
