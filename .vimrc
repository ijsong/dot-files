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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/syntastic'
Plugin 'fatih/vim-go'
Plugin 'derekwyatt/vim-scala'
Plugin 'tpope/vim-markdown'
Plugin 'suan/vim-instant-markdown'

" all of your plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" reset vimrc augroup
augroup vimrc
  autocmd!
augroup END

" key mappings
" our <leader> will be the space key
let mapleader=" "
" our <localleader> will be the '-' key
let maplocalleader="-"

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
set noerrorbells visualbell t_vb=
set wildmenu
set lazyredraw

" quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
map <leader>a :cclose<CR>
" nnoremap <leader>a :cclose<CR>

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

" fold
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

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

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols_ascii = 1

" indent

" cscope - noplugins
if has('cscope')
  set cscopetag
  set csto=0

  if $CSCOPE_DB == '' && filereadable('cscope.out')
    let $CSCOPE_DB = 'cscope.out'
  endif
  if $CSCOPE_DB != ''
    cs add $CSCOPE_DB
  endif

  set cscopeverbose
  " The following maps all invoke one of the following cscope search types:
  "
  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml', '.gitignore', 'CMakeLists.txt']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|DS_Store)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|o|pyc)$',
  \ 'link': 'some_bad_symbolic_links'}
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" tagbar
let g:tagbar_sort = 0
nnoremap <F9> :TagbarToggle<CR>

" fugitive

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
nnoremap <leader>yf :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>yc :YcmCompleter GoToDeclaration<CR>

" vim-clang-format
let g:clang_format#code_style = 'google'
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 0
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_formatexpr = 0
nmap <Leader>cft :ClangFormatAutoToggle<CR>
augroup vimrc
  " autocmd FileType c,cpp ClangFormatAutoEnable
  autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
augroup END

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_quiet_messages = { "type": "style" }
" syntastic - c++
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_cpp_no_default_include_dirs = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_cpp_include_dirs = [ '.', 'include', 'includes', 'inc', 'headers' ]
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra -Wpedantic -Weffc++'
" syntastic - go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'passive_filetypes': ['go'] }
" syntastic - python
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--max-line-length=80 ' .
  \ '--max-complexity=10 --ignore=E111,E114,E121,E125,E126,E127,E128,E129,' .
  \ 'E131,E133,E201,E202,E203,E211,E221,E222,E241,E251,E261,E303,E402,W503'

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
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_def_mode = 'godef'
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
  autocmd BufNewFile,BufRead *.go setlocal tabstop=4 shiftwidth=4
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
  autocmd FileType go nmap <Leader>fc <Plug>(go-referrers)
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
augroup vimrc
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

