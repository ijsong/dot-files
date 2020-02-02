if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'do': { -> coc#util#install() }}
Plug 'derekwyatt/vim-scala'
Plug 'rhysd/vim-clang-format'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'christoomey/vim-tmux-navigator'
Plug 'flazz/vim-colorschemes'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
call plug#end()

augroup vimrc
  autocmd!
augroup END

let mapleader=" "

" set utf-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" file format
set fileformat=unix
set fileformats=unix,dos,mac

" display
" set background=dark
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
set nostartofline
set shortmess=aT

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
augroup vimrc
  autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
  autocmd FileType c,cpp set tabstop=2
  autocmd FileType c,cpp set shiftwidth=2
  autocmd FileType c,cpp set softtabstop=2
augroup END



" editor
set hidden
set signcolumn=yes
set backspace=indent,eol,start
set nobackup
set nowritebackup
set laststatus=2
set history=1000
set autoread
set autowrite
if v:version >= 704
  set regexpengine=1
endif
set updatetime=200
set noerrorbells visualbell t_vb=
set wildmenu
set lazyredraw
syntax on
filetype plugin indent on

" split
set splitbelow
set splitright

" undo
set undolevels=1000
if has('persistent_undo')
  call system('mkdir -p $HOME/.vim/undo')
  set undodir=~/.vim/undo//
  set undofile
  set undoreload=10000
endif

" spell
set spelllang=en

" folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings for plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
if has_key(g:plugs, 'coc.nvim')
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  let g:coc_global_extensions = [
    \ 'coc-ccls', 'coc-metals', 'coc-python', 'coc-java', 
    \ 'coc-json', 'coc-yaml', 'coc-emoji',
    \ 'coc-git']

  augroup coc-config
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
augroup end
endif


" derekwyatt/vim-scala
if has_key(g:plugs, 'derekwyatt/vim-scala')
  augroup vim-scala-config
    autocmd BufRead,BufNewFile *.sbt set filetype=scala
  augroup END
endif

" vim-clang-format
if has_key(g:plugs, 'vim-clang-format')
  let g:clang_format#code_style = 'google'
  let g:clang_format#detect_style_file = 1
  let g:clang_format#auto_format = 0
  let g:clang_format#auto_format_on_insert_leave = 0
  let g:clang_format#auto_formatexpr = 0
  nmap <Leader>cft :ClangFormatAutoToggle<CR>
  augroup vim-clang-format-config
    autocmd!
    " autocmd FileType c,cpp ClangFormatAutoEnable
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
  augroup END
endif


" vim-colorschemes
if has_key(g:plugs, 'vim-colorschemes')
  colorscheme chroma
endif


" christoomey/vim-tmux-navigator
if has_key(g:plugs, 'vim-tmux-navigator')
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
endif


"majutsushi/tagbar
if has_key(g:plugs, 'tagbar')
  let g:tagbar_sort = 0
  nnoremap <F9> :TagbarToggle<CR>
endif


" Yggdroot/indentLine
if has_key(g:plugs, 'indentLine')
  let g:indentLine_char = '┊'
  let g:indentLine_fileType = ['c', 'cpp']
  let g:indentLine_showFirstIndentLevel = 1
endif


" ctrlpvim/ctrlp.vim
if has_key(g:plugs, 'ctrlp.vim')
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_root_markers = ['pom.xml', '.gitignore', 'CMakeLists.txt', 'build.sbt']
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|DS_Store)$',
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|o|pyc)$',
    \ 'link': 'some_bad_symbolic_links'}
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
endif


" vim-airline/vim-airline
if has_key(g:plugs, 'vim-airline')
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  if has_key(g:plugs, 'vim-airline-themes')
    let g:airline_theme='minimalist'
  endif
  if has_key(g:plugs, 'vim-fugitive')
    let g:airline#extensions#fugitiveline#enabled = 1
  endif
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'
endif


" preservim/nerdtree
if has_key(g:plugs, 'nerdtree')
  augroup nerdtree-config
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
      \  if isdirectory(expand('<amatch>'))
      \|   call plug#load('nerdtree')
      \|   execute 'autocmd! nerd_loader'
      \| endif
  augroup END
  nnoremap <leader>n :NERDTreeToggle<cr>
endif
