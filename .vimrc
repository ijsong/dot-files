" disable vi compatibility (emulation of old bugs)
set nocompatible

" required for Vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
Plugin 'flazz/vim-colorschemes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'shougo/neocomplete.vim'
Plugin 'rhysd/vim-clang-format'
Plugin 'fatih/vim-go'
Plugin 'derekwyatt/vim-scala'

" all of your plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" reset vimrc augroup
augroup vimrc
  autocmd!
augroup END

" set utf-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" display
set background=dark
set number
set ruler
set title
set undofile
set cursorline
set showmode
set showcmd
set showmatch
set matchtime=2
set scrolloff=2
set cmdheight=2
set textwidth=80
set colorcolumn=+1

" editor
set ignorecase
set smartcase
set nohlsearch
set incsearch
set gdefault
set autoindent
set copyindent
set cindent
set cino=b1,g0,N-s,t0,(0,W4
set smarttab
set magic
set backspace=indent,eol,start
set nobackup
set expandtab
set laststatus=2
set fileformat=unix
set fileformats=unix,dos,mac
set hidden
set history=1000
set undolevels=1000
set autoread
set autowrite
if v:version >= 704
  set regexpengine=1
endif
set updatetime=200
set foldmethod=indent
set foldlevelstart=99
set noerrorbells visualbell t_vb=

" quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" tags
set tags+=./tags;/

" filetype-specific
let g:is_posix = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

autocmd vimrc BufEnter *.conf setf conf
augroup vimrc
  " Automatically delete trailing DOS-returns and whitespace on file open and
  " write.
  autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END
autocmd vimrc FileType text,markdown,gitcommit set nocindent
autocmd vimrc FileType make set noexpandtab shiftwidth=8 softtabstop=0

" turn syntax highlighting on
syntax on

" key mappings
" our <leader> will be the space key
let mapleader=" "
" our <localleader> will be the '-' key
let maplocalleader="-"
" With this map, we can select some text in visual mode and by invoking the map,
" have the selection automatically filled in as the search text and the cursor
" placed in the position for typing the replacement text. Also, this will ask
" for confirmation before it replaces any instance of the search text in the
" file.
" NOTE: We're using %S here instead of %s; the capital S version comes from the
" eregex.vim plugin and uses Perl-style regular expressions.
vnoremap <C-r> "hy:%S/<C-r>h//c<left><left>
" Fast saving
nnoremap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings for plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-colorschemes
colorscheme chroma

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml', '.gitignore', 'CMakeLists.txt']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|DS_Store)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|o|pyc)$',
  \ 'link': 'some_bad_symbolic_links'}
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
  \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']

" tagbar
let g:tagbar_sort = 0
nnoremap <F9> :TagbarToggle<CR>

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'}
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
        return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
augroup virmc
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" vim-clang-format
let g:clang_format#code_style = 'google'
let g:clang_format#command = '$HOME/bin/clang/bin/clang-format'
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 0
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_formatexpr = 0
nmap <Leader>cft :ClangFormatAutoToggle<CR>
augroup vimrc
  autocmd FileType c,cpp ClangFormatAutoEnable
  autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
augroup END

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1
let g:go_play_open_browser = 0
let g:go_auto_type_info = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_def_mode = 'godef'
let g:go_auto_sameids = 1
let g:go_list_type = 'quickfix'
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
augroup vimrc
  autocmd FileType go set number fo+=croq tw=100
  autocmd FileType go set makeprg=go\ build\ .
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  autocmd FileType go nmap <Leader>s <Plug>(go-implements)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>e <Plug>(go-rename)
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
