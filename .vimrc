" disable vi compatibility (emulation of old bugs)
set nocompatible

" required for Vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'rhysd/vim-clang-format'
Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plugin 'Valloric/YouCompleteMe'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

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

" dev mode
let sap_path = $HOME . '/dotfiles/vim/sap_settings.vim'
let at_sap = filereadable( sap_path )

" set utf-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" file format
set fileformat=unix
set fileformats=unix,dos,mac

" display
set background=dark
set number
set ruler
set title
set cursorline
set showmode
set showcmd
set showmatch
set matchtime=2
set scrolloff=2
set cmdheight=2
set wrap
set colorcolumn=+1

" search
set hlsearch
set ignorecase
set smartcase
set incsearch
set magic

" indent, tab and space
" http://vimdoc.sourceforge.net/htmldoc/indent.html#cinoptions-values
set cino=b1,g0,N-s,t0,(0,W4
set autoindent
set copyindent
set cindent
set expandtab
set smarttab
set textwidth=80
autocmd vimrc FileType make set noexpandtab shiftwidth=8 softtabstop=0
if at_sap
  autocmd vimrc FileType c,cpp set tabstop=4
  autocmd vimrc FileType c,cpp set shiftwidth=4
  autocmd vimrc FileType c,cpp set softtabstop=4
else
  autocmd vimrc FileType c,cpp set tabstop=2
  autocmd vimrc FileType c,cpp set shiftwidth=2
  autocmd vimrc FileType c,cpp set softtabstop=2
endif

" editor
set backspace=indent,eol,start
set nobackup
set laststatus=2
set history=1000
set autoread
set autowrite
if v:version >= 704
  set regexpengine=1
endif
set updatetime=100
set noerrorbells visualbell t_vb=
set wildmenu
set lazyredraw
syntax on

" split
set splitbelow
set splitright

" undo
set hidden
set undolevels=1000
if has('persistent_undo')
  call system('mkdir -p $HOME/.vim/undo')
  set undodir=~/.vim/undo//
  set undofile
  set undoreload=10000
endif

" spell
set spelllang=en
" set spellfile=$HOME/dotfiles/vim/spell/en.latin1.add


" quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
map <leader>a :cclose<CR>
" nnoremap <leader>a :cclose<CR>

" tags
set tags+=./tags;/

" specific filetypes
let g:is_posix = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
autocmd vimrc BufEnter *.conf setf conf
autocmd vimrc BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
autocmd vimrc BufNewFile,BufReadPost *.md set filetype=markdown
autocmd vimrc FileType text,markdown,gitcommit set nocindent
autocmd vimrc FileType markdown setlocal spell! spelllang=en
autocmd vimrc FileType gitcommit setlocal spell

" folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" keymaps
nnoremap <leader>w :w!<cr> " fast saving


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings for plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-colorschemes
colorscheme chroma

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols_ascii = 1

" indentline
let g:indentLine_char = '┊'
let g:indentLine_fileType = ['c', 'cpp']
let g:indentLine_showFirstIndentLevel = 1

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
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
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

" youcompleteme
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
nnoremap <leader>yj :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yi :YcmCompleter GoToImplementationElseDeclaration<CR>
nnoremap <leader>yt :YcmCompleter GetTypeImprecise<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <leader>ys :YcmDiags<CR>
nnoremap <leader>yD ::YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>yR :YcmRestartServer<CR>

" tmux navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j>  :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
