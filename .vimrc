let s:vim_plug_dir=expand($HOME.'/.vim/autoload')
if !filereadable(s:vim_plug_dir.'/plug.vim')
    execute '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P '.s:vim_plug_dir
    let s:install_plug=1
endif

packadd termdebug
let g:termdebug_wide = 1

call plug#begin('~/.vim/plugged')


"Plugin Group: LSP<<

"Plug 'natebosch/vim-lsc' 
"<<

"let g:lsc_server_commands = {
 "\ 'cpp': {
 "\    'command': 'ccls',
 "\    'message_hooks': {
 "\        'initialize': {
 "\            'initializationOptions': {'cacheDirectory': $HOME."/.vim/ccls_cache"},
 "\            'rootUri': {->getcwd()},
 "\        },
 "\    },
 "\    'suppress_stderr': v:true
 "\  },
 "\}

let g:lsc_server_commands = {
 \ 'cpp': {
 \    'command': 'clangd', 'suppress_stderr': v:true
 \    },
 \ 'c': {
 \    'command': 'clangd', 'suppress_stderr': v:true
 \    },
 \ 'python': {
 \    'command': 'pyls',
 \    },
 \ 'r': {
 \    'command': 'R --quiet --slave -e languageserver::run()',
 \    },
 \ 'sh': {
 \    'command': 'bash-language-server start',
 \    },
 \}

"highlight lscReference ctermbg=160
"nmap <silent> <Leader>d :LSClientGoToDefinition<CR>
"nmap <silent> <Leader>r :LSClientFindReferences<CR>

" >>

Plug 'prabirshrestha/vim-lsp'
"<<

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 0 " enable echo under cursor when in normal mode
let g:lsp_async_completion = 0


nmap <silent> <Leader>d :LspDefinition<CR>
nmap <silent> <Leader>r :LspReference<CR>

if executable('clangd')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

"if executable('ccls')
   "au User lsp_setup call lsp#register_server({
      "\ 'name': 'ccls',
      "\ 'cmd': {server_info->['ccls']},
      "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      "\ 'initialization_options': { 'cacheDirectory': $HOME."/.vim/ccls_cache" },
      "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      "\ })
"endif


"if executable('cquery')
   "au User lsp_setup call lsp#register_server({
      "\ 'name': 'cquery',
      "\ 'cmd': {server_info->['cquery']},
      "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      "\ 'initialization_options': { 'cacheDirectory': $HOME."/.vim/cquery_cache" },
      "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      "\ })
"endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('bash-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'bash',
        \ 'cmd': {server_info->['bash-language-server', 'start']},
        \ 'whitelist': ['sh'],
        \ })
endif

if executable('R')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'R',
        \ 'cmd': {server_info->['R', '--quiet', '--slave', '-e', 'languageserver::run()']},
        \ 'whitelist': ['r'],
        \ })
endif

">>

">>

"Plugin Group: Autocomplete<<

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
"Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"let g:asyncomplete_remove_duplicates = 1
"let g:asyncomplete_force_refresh_on_context_changed = 1

"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    "\ 'name': 'buffer',
    "\ 'whitelist': ['*'],
    "\ 'blacklist': [],
    "\ 'completor': function('asyncomplete#sources#buffer#completor'),
    "\ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Plug 'maralla/completor.vim'
"let g:completor_clang_binary = '/usr/local/bin/clang'

"Plugin: YouCompleteMe <<
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang'}
"Plug 'Valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf=0
let g:ycm_enable_diagnostic_signs = 1

let g:ycm_error_symbol = '⨉'
let g:ycm_warning_symbol = '⚠'
let g:ycm_style_error_symbol = '⚠'
let g:ycm_style_warning_symbol = '⚠'
let g:ycm_show_diagnostics_ui = 1

"nmap <silent> <Leader>d :YcmCompleter GoTo<CR>
">>

"Plugin: neocomplete <<
"Plug 'Shougo/neocomplete.vim'
"let g:neocomplete#enable_at_startup=1
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
">>

"Plugin: clang_complete <<
"Plug 'Rip-Rip/clang_complete'
">>
">>

"Plugin Group: Color Scheme <<
"Plug 'bbchung/ccolor'
Plug 'nanotech/jellybeans.vim'
Plug 'dracula/vim'
"Plug 'morhetz/gruvbox'
"Plug 'twerth/ir_black'
">>

"Plugin Group: Status Bar <<
"Plugin: lightline.vim <<
"Plug 'itchyny/lightline.vim'

"let g:lightline = {
      "\ 'colorscheme': 'jellybeans',
      "\ 'component': {
      "\   'readonly': '%{&filetype=="help"?"":&readonly?"ro":""}',
      "\   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      "\ }
      "\ }

"let g:lightline.active = {
    "\ 'left': [ [ 'mode', 'paste' ],
    "\           [ 'readonly', 'absolutepath', 'modified' ] ],
    "\ 'right': [ [ 'lineinfo' ],
    "\            [ 'percent' ],
    "\            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
"let g:lightline.inactive = {
    "\ 'left': [ [ 'absolutepath' ] ],
    "\ 'right': [ [ 'lineinfo' ],
    "\            [ 'percent' ] ] }

">>

"Plugin: vim-airline <<
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='jellybeans'
">>
">>

"Plugin Group: Search <<
"Plugin: unite.vim <<
"Plug 'Shougo/unite.vim'
"silent! nmap <silent> <Leader>be :Unite -here buffer<CR>
"nmap <silent> <C-p> :Unite -start-insert -here file_rec<CR>
">>

"Plugin: ctrlp.vim <<
"Plug 'ctrlpvim/ctrlp.vim'
"silent! nmap <silent> <Leader>b :CtrlPBuffer<CR>
"if executable('ag')
  "set grepprg=ag\ --nogroup\ --nocolor
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  "let g:ctrlp_use_caching = 0
"endif
">>

"Plugin: fzf <<
"Plug 'junegunn/fzf'
"nmap <silent> <C-p> :FZF<CR>
">>

"Plugin: LeaderF <<
Plug 'Yggdroot/LeaderF'

"let g:Lf_ShortcutF = '<C-P>'
"let g:Lf_ShortcutB = '<Leader>be'
">>

"Plugin: Tagbar <<
Plug 'majutsushi/tagbar'
">>
">>

"Plugin Group: C++<<
"Plugin: vim-clang-format<<
"Plug 'rhysd/vim-clang-format'
"let g:clang_format#command = 'clang-format-3.9'
"let g:clang_format#auto_formatexpr=1
">>

"Plugin: ClangFormatHelper <<
Plug 'bbchung/ClangFormatHelper'
"let g:clang_format_path='clang-format'
">>

"Plugin: Clighter8 <<
"Plug 'bbchung/clighter8'
"nmap <silent> <Leader>R :ClRenameCursor<CR>

let g:clighter8_highlight_whitelist = ['clighter8EnumConstantDecl', 'clighter8MacroInstantiation']
let g:clighter8_libclang_path='/usr/local/lib/libclang.so'
let g:clighter8_syntax_highlight = 1
let g:clighter8_autostart = 0

">>

"Plugin: a.vim <<
Plug 'vim-scripts/a.vim'
let g:alternateExtensions_h = "cpp,c"

">>
" >>

"Plugin Group: Linter<<
"Plugin: validator.vim <<
"Plug 'maralla/validator.vim'
"let g:validator_auto_open_quickfix = 0
"let g:validator_ignore = ['cpp, c']
"let g:validator_error_symbol = 'E'
"let g:validator_warning_symbol = 'W'
"let g:validator_style_error_symbol = 'S'
"let g:validator_style_warning_symbol = 'S'
">>

"Plugin: ale.vim <<
"Plug 'w0rp/ale'
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '?'
let g:ale_sign_column_always = 0
hi ALEErrorSign guifg=RED guibg=bg
hi ALEWarningSign guifg=Yellow guibg=bg
let g:ale_linters = {
\   'cpp': ['clang'],
\   'c': ['clang'],
\   'asm': [],
\   'yaml': [],
\}

">>
">>

"Plugin Group: Explorer<<
"Plugin: tagbar <<
"Plug 'majutsushi/tagbar'
"let g:tagbar_left = 1
"let g:tagbar_width = 28
"nmap <silent> <F2> :TagbarToggle<CR>
">>

"Plugin: bufexplorer <<
"Plug 'jlanzarotta/bufexplorer'
">>

"Plugin: nerdtree <<
"Plug 'scrooloose/nerdtree'
">>
">>

"Plugin Group: Edit<<
"Plugin: nerdcommenter <<
Plug 'scrooloose/nerdcommenter'
">>

"Plugin: vim_current_word <<
Plug 'lygaret/autohighlight.vim'
"hi default link CursorAutoHighlight IncSearch
fun! s:filetype_autohighlight()
    if index(['c', 'cpp'], &filetype) == -1 || &diff
        let b:autohighlight_enabled=0
    endif
endf
au BufEnter * call s:filetype_autohighlight()
">>

"Plugin: ultisnips <<
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = '<Leader><tab>'
">>

"Plugin: vim-snippets <<
Plug 'honza/vim-snippets'
">>

"Plugin: delimitMate <<
Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr=1
">>

"Plugin: auto-pairs <<
"Plug 'jiangmiao/auto-pairs'
"let g:AutoPairsFlyMode = 0
"let g:AutoPairsMultilineClose=0
">>
">>

"Plugin Group: Others << 
Plug 'mhinz/vim-startify'
let g:startify_session_persistence=1

"Plugin: vim-fugitive <<
Plug 'tpope/vim-fugitive'
">>

"Plugin: asyncrun.vim <<
"Plug 'skywind3000/asyncrun.vim'
">>

"Plugin: AutoGtag <<
Plug 'bbchung/autogtag'

let g:Gtags_Auto_Update = 0
nmap <Leader>s :GtagsCursor<CR>
nmap <Leader>g :execute("Gtags -g ".expand('<cword>'))<CR>
command! -nargs=1 G execute "Gtags -g "<f-args>
">>
">>

call plug#end()

if exists('s:install_plug')
    PlugInstall
endif

"My Settings <<
set background=dark
colorscheme jellybeans
syntax on

set tf
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
set cursorline
if &diff
    set nocursorline
endif
set title
set timeoutlen=300
set noerrorbells
"set vb t_vb=
"set t_ut=
set mouse=a
set laststatus=2
set number
set softtabstop=4
set tabstop=4
set shiftwidth=4
set scrolloff=8
set sidescrolloff=1
set incsearch
set hlsearch
set ignorecase
set smartcase
set pumheight=12
set previewheight=4
set foldlevelstart=20
set tabpagemax=100
set wildmode=longest,full
set wildmenu
set completeopt=menuone,noselect
set grepprg=grep\ -nH\ $*
"set sessionoptions=buffers,curdir,folds,winsize,options
set encoding=utf-8
set fileencodings=utf-8,big5,gb2312,utf16le
set fileformat=unix
set updatetime=700
set undofile
set backspace=2
set termguicolors
set nosol
set expandtab
set signcolumn=yes

let &undodir=$HOME.'/.vim/undo'
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif

command! TrimWhiteSpace execute ":%s/\s\+$//e"      
command! W silent execute "w !sudo > /dev/null tee %"
vmap * y/<C-r>"<CR>
vmap # y?<C-r>"<CR>
nmap <F4> :qa<CR>
nmap Q <Nop>
vmap <C-c> <ESC>
imap <C-c> <ESC>
nmap <C-c> <ESC>

au FileType sh,c,cpp,objc,objcpp,python,vim setlocal tw=0 expandtab fdm=syntax
au FileType python setlocal ts=4 formatexpr= formatprg=autopep8\ -aa\ -
au FileType tex,help,markdown setlocal tw=78 cc=78 formatprg=
">>

" vim:foldmarker=<<,>>:foldlevel=0:foldmethod=marker:
