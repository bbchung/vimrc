let s:vim_plug_dir=expand($HOME.'/.vim/autoload')
if !filereadable(s:vim_plug_dir.'/plug.vim')
    execute '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P '.s:vim_plug_dir
    let s:install_plug=1
endif

packadd termdebug
let g:termdebug_wide = 1
call plug#begin('~/.vim/plugged')

"Plugin Group: LSP "<<

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} "<<
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call CocActionAsync('doHover') <CR>
nmap <silent> <Leader>x <Plug>(coc-fix-current)
nmap <silent> <Leader>r <Plug>(coc-rename)
autocmd CursorHold *.cpp,*.h,*.py,*.r silent call CocActionAsync('highlight')
"autocmd CursorHold *.cpp,*.h,*.py,*.r silent call CocActionAsync('doHover')
set formatexpr=CocAction('formatSelected')
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)
hi default link CocHighlightText PmenuSbar
">>

"Plug 'natebosch/vim-lsc' "<<

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

"Plug 'prabirshrestha/vim-lsp' "<<

let g:lsp_signs_enabled=1

"if executable('clangd')
    "autocmd User lsp_setup call lsp#register_server({
        "\ 'name': 'clangd',
        "\ 'cmd': {server_info->['clangd']},
        "\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        "\ })
"endif

"if executable('ccls')
   "au User lsp_setup call lsp#register_server({
      "\ 'name': 'ccls',
      "\ 'cmd': {server_info->['ccls']},
      "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      "\ 'initialization_options': { 'cacheDirectory': $HOME."/.vim/ccls_cache", 'index' : {'threads' : 4} },
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

"if executable('pyls')
    "au User lsp_setup call lsp#register_server({
        "\ 'name': 'pyls',
        "\ 'cmd': {server_info->['pyls']},
        "\ 'whitelist': ['python'],
        "\ })
"endif

"if executable('bash-language-server')
    "au User lsp_setup call lsp#register_server({
        "\ 'name': 'bash',
        "\ 'cmd': {server_info->['bash-language-server', 'start']},
        "\ 'whitelist': ['sh'],
        "\ })
"endif

"if executable('R')
    "au User lsp_setup call lsp#register_server({
        "\ 'name': 'R',
        "\ 'cmd': {server_info->['R', '--quiet', '--slave', '-e', 'languageserver::run()']},
        "\ 'whitelist': ['r'],
        "\ })
"endif

">>

">>

"Plugin Group: Autocomplete "<<

"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-file.vim'
"Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
"Plug 'prabirshrestha/asyncomplete-buffer.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim' "<<

"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    "\ 'name': 'buffer',
    "\ 'whitelist': ['*'],
    "\ 'blacklist': [],
    "\ 'completor': function('asyncomplete#sources#buffer#completor'),
    "\ }))

"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    "\ 'name': 'file',
    "\ 'whitelist': ['*'],
    "\ 'priority': 10,
    "\ 'completor': function('asyncomplete#sources#file#completor')
    "\ }))

"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    "\ 'name': 'ultisnips',
    "\ 'whitelist': ['*'],
    "\ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    "\ }))
">>

"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang'} "<<
let g:ycm_confirm_extra_conf=0
let g:ycm_enable_diagnostic_signs = 1

let g:ycm_error_symbol = '⨉'
let g:ycm_warning_symbol = '⚠'
let g:ycm_style_error_symbol = '⚠'
let g:ycm_style_warning_symbol = '⚠'
let g:ycm_show_diagnostics_ui = 1

"nmap <silent> <Leader>d :YcmCompleter GoTo<CR>
">>

">>

"Plugin Group: Color Scheme "<<
Plug 'ayu-theme/ayu-vim'
let ayucolor="dark"
"Plug 'bbchung/ccolor'
Plug 'nanotech/jellybeans.vim' "<<
"let g:jellybeans_background_color = "000000"
let g:jellybeans_use_term_italics = 0
">>
"Plug 'romainl/Apprentice'
"Plug 'dracula/vim'
"Plug 'dunstontc/vim-vscode-theme'
"Plug 'tomasiser/vim-code-dark'
"Plug 'cocopon/iceberg.vim'
"Plug 'twerth/ir_black'
Plug 'NLKNguyen/papercolor-theme' "<<
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 0
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 0
  \     },
  \     'c': {
  \       'highlight_builtins' : 0
  \     }
  \   }
  \ }
">>
Plug 'morhetz/gruvbox' "<<
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=0
let g:gruvbox_sign_column='bg0'
">>
">>

"Plugin Group: Status Bar "<<
"Plug 'liuchengxu/eleline.vim'
Plug 'itchyny/lightline.vim' "<<

let g:lightline = {
\ 'colorscheme': 'jellybeans',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'absolutepath', 'modified', 'gitbranch' ] ],
\   'right': [ [ 'lineinfo' ],
\            [ 'fileformat', 'fileencoding', 'filetype', 'percent' ],
\            [ 'cocstatus' ] ],
\ },
\ 'inactive': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'absolutepath', 'modified', 'gitbranch' ] ],
\   'right': [ [ 'lineinfo' ],
\            [ 'fileformat', 'fileencoding', 'filetype', 'percent' ],
\            [ 'cocstatus' ] ],
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head',
\   'cocstatus': 'coc#status'
\ },
\ }



">>

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"let g:airline_theme = 'codedark'
">>

"Plugin Group: Search "<<

"Plug 'junegunn/fzf' "<<
"nmap <silent> <C-p> :FZF<CR>
">>

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } "<<
let g:Lf_StlColorscheme='one'
let g:Lf_WildIgnore = {
              \ 'dir': ['.svn','.git','.hg','build'],
              \ 'file': ['*o']
              \}
let g:Lf_RecurseSubmodules = 1
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.project']
let g:Lf_UseVersionControlTool = 0
">>

">>

"Plugin Group: Language "<<

"Plug 'bbchung/clighter8' "<<
"nmap <silent> <Leader>R :ClRenameCursor<CR>

let g:clighter8_highlight_whitelist = ['clighter8EnumConstantDecl', 'clighter8MacroInstantiation']
let g:clighter8_libclang_path='/usr/local/lib/libclang.so'
let g:clighter8_syntax_highlight = 1
let g:clighter8_autostart = 0

">>

Plug 'vim-scripts/a.vim' "<<
let g:alternateExtensions_h = "cpp,c"
">>

" >>

"Plugin Group: Explorer "<<
"Plug 'majutsushi/tagbar' "<<
"let g:tagbar_left = 1
"let g:tagbar_width = 28
"nmap <silent> <F2> :TagbarToggle<CR>
">>

"Plug 'jlanzarotta/bufexplorer'
"Plug 'scrooloose/nerdtree'
">>

"Plugin Group: Edit "<<
Plug 'scrooloose/nerdcommenter'

"Plug 'SirVer/ultisnips' "<<
"let g:UltiSnipsExpandTrigger = '<Leader><tab>'
">>

Plug 'honza/vim-snippets'

Plug 'Raimondi/delimitMate' "<<
let g:delimitMate_expand_cr=1
" >>

"Plug 'jiangmiao/auto-pairs' "<<
"let g:AutoPairsFlyMode = 0
"let g:AutoPairsMultilineClose=0
">>
">>

"Plugin Group: Others "<<
"Plug 'iandingx/leetcode.vim'
"Plug 'itchyny/calendar.vim'
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
Plug 'mhinz/vim-startify' "<<
let g:startify_session_persistence=1
let g:startify_change_to_dir=0
">>

Plug 'tpope/vim-fugitive'
"Plug 'roxma/vim-tmux-clipboard'
"Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'chrisbra/csv.vim'
"Plug 'mechatroner/rainbow_csv'

">>
call plug#end()

if exists('s:install_plug')
    PlugInstall
endif

syntax on

set tf
set cursorline
set title
set timeoutlen=300
set belloff=all
set vb t_vb=
"set t_ut=
"set ttyscroll=1
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
set fileencodings=utf-8,big5,gb2312
set fileformat=unix
set updatetime=300
set backspace=2
set termguicolors
set nosol
set expandtab
set signcolumn=yes
"set clipboard=unnamedplus
set hidden
set shortmess+=c
set nobackup
set nowritebackup
set undofile
let &undodir=$HOME.'/.vim/undo'
call mkdir(&undodir, 'p')

command! TrimWhiteSpace :%s/\s\+$//gI
command! W silent execute "w !sudo > /dev/null tee %"
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


nmap <F4> :qa<CR>
nmap Q <Nop>
vmap <C-c> <ESC>
imap <C-c> <ESC>
nmap <C-c> <ESC>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

au FileType sh,c,cpp,objc,objcpp,python,vim setlocal tw=0 expandtab fdm=syntax
au FileType gitcommit setlocal spell

let g:Gtags_Auto_Update = 1
nmap <Leader>s :GtagsCursor<CR>
nmap <Leader>g :execute("Gtags -g ".expand('<cword>'))<CR>
command! -nargs=1 T execute "Gtags -g "<f-args>

if &diff
    set nocursorline
endif
set background=dark
colorscheme gruvbox

" vim:foldmarker=<<,>>:foldlevel=0:foldmethod=marker:
