" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" expand tabs to spaces
set expandtab

" turn syntax highlighting on
syntax on

" turn line numbers on
set number

" highlight matching braces
set showmatch

" background
set background=dark

" makefile
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

map <C-K> :pyf /usr/local/Cellar/clang-format/2016-03-29/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/local/Cellar/clang-format/2016-03-29/share/clang/clang-format.py<cr>


" required for Vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'rip-rip/clang_complete'
let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:clang_close_preview = 1

Plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
