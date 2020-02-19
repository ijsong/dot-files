if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" curl -fSL https://www.languagetool.org/download/LanguageTool-4.8.zip | \
" tar -xvf - -C ~/.vim && mv ~/.vim/LanguageTool-4.8 ~/.vim/languagetool

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
Plug 'ryanoasis/vim-devicons'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'dpelle/vim-LanguageTool'
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

" quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

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
  " Use <tab> for trigger completion and navigate to the next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  " Use <Tab> and <S-Tab> to navigate the completion list
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Use <cr> to confirm completion
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " To make <cr> select the first completion item and confirm the completion
  " when no item has been selected
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  let g:coc_global_extensions = [
    \ 'coc-ccls', 'coc-metals', 'coc-python', 'coc-java', 
    \ 'coc-json', 'coc-yaml', 'coc-emoji',
    \ 'coc-git']

  augroup coc-config
    autocmd!
    " Close the preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
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
  let g:airline_powerline_fonts = 1
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


" ryanoasis/vim-devicons
if has_key(g:plugs, 'vim-devicons')
  let g:WebDevIconsOS = 'Darwin'
endif


" fatih/vim-go
if has_key(g:plugs, 'vim-go')
  " disable code completion - use LSP
  let g:go_code_completion_enabled = 0

  " highlight
  let g:go_auto_sameids = 0
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_format_strings = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_generate_tags = 1
  let g:go_highlight_variable_assignments = 1

  " highlight on error
  let g:go_highlight_array_whitespace_error = 1
  let g:go_highlight_chan_whitespace_error = 1
  let g:go_highlight_space_tab_error = 1
  let g:go_highlight_trailing_whitespace_error = 1
  let g:go_highlight_string_spellcheck = 1
  let g:go_highlight_diagnostic_errors = 1
  let g:go_highlight_diagnostic_warnings = 1

  " fmt
  let g:go_fmt_autosave = 1
  let g:go_fmt_fail_silently = 1
  let g:go_fmt_command = 'goimports'

  " type info
  let g:go_auto_type_info = 1

  " use updatetime
  let g:go_updatetime = 0

  " metalinter
  let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
  let g:go_metalinter_autosave = 1
  let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  let g:go_metalinter_deadline = '5s'
  " let g:go_metalinter_command = "gopls"

  " extra
  let g:go_jump_to_error = 0
  let g:go_def_mode = 'gopls'
  let g:go_info_mode = 'gopls'
  let g:go_list_type = 'quickfix'
  let g:go_list_height = 5
  let g:go_gocode_propose_builtins = 1
  let g:go_gocode_propose_source = 1
  let g:go_gocode_unimported_packages = 1
  let g:go_test_timeout = '10s'

  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#cmd#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
    endif
  endfunction

  augroup vim-go-config
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
    autocmd FileType go set number fo+=croq tw=100
    autocmd FileType go set makeprg=go\ build\ .
    autocmd FileType go nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <Leader>r <Plug>(go-run)
    autocmd FileType go nmap <Leader>t <Plug>(go-test)
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

endif

" iamcco/markdown-preview.nvim
if has_key(g:plugs, 'markdown-preview.nvim')
endif

" dpelle/vim-LanguageTool 
if has_key(g:plugs, 'vim-LanguageTool')
  let g:languagetool_jar='$HOME/.vim/languagetool/languagetool-commandline.jar'
  let g:languagetool_lang='en-US'
endif
