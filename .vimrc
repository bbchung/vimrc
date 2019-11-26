let s:vim_plug_dir=expand($HOME.'/.vim/autoload')
if !filereadable(s:vim_plug_dir.'/plug.vim')
    execute '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P '.s:vim_plug_dir
    let s:install_plug=1
endif

packadd termdebug
let g:termdebug_wide = 1

call plug#begin('~/.vim/plugged') "<<

"Plugin Group: LSP "<<
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} "<<
"Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> K :call <SID>show_documentation()<CR>
nmap <Leader>x <Plug>(coc-fix-current)
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>r :call CocAction("format") <CR>
set formatexpr=CocAction('formatSelected')
let g:coc_enable_locationlist = 0
autocmd User CocLocationsChange CocList --normal location
hi default link CocHighlightText PmenuSbar
autocmd CursorHold *.cpp,*.h,*.py,*.r silent! call CocActionAsync('highlight')
"autocmd CursorHold *.cpp,*.h,*.py,*.r silent call CocActionAsync('doHover')
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

"let g:lsc_server_commands = {
 "\ 'cpp': {
 "\    'command': 'clangd', 'suppress_stderr': v:true
 "\    },
 "\ 'c': {
 "\    'command': 'clangd', 'suppress_stderr': v:true
 "\    },
 "\ 'python': {
 "\    'command': 'pyls',
 "\    },
 "\ 'r': {
 "\    'command': 'R --quiet --slave -e languageserver::run()',
 "\    },
 "\ 'sh': {
 "\    'command': 'bash-language-server start',
 "\    },
 "\}

"highlight lscReference ctermbg=160
"nmap <silent> <Leader>d :LSClientGoToDefinition<CR>
"nmap <silent> <Leader>r :LSClientFindReferences<CR>
" >>

"Plug 'prabirshrestha/vim-lsp' "<<

"let g:lsp_signs_enabled=1

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
"let g:ycm_confirm_extra_conf=0
"let g:ycm_enable_diagnostic_signs = 1

"let g:ycm_error_symbol = '⨉'
"let g:ycm_warning_symbol = '⚠'
"let g:ycm_style_error_symbol = '⚠'
"let g:ycm_style_warning_symbol = '⚠'
"let g:ycm_show_diagnostics_ui = 1

"nmap <silent> <Leader>d :YcmCompleter GoTo<CR>
">>

">>

"Plugin Group: Theme "<<
"Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
let ayucolor="dark"
"Plug 'bbchung/ccolor'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'nanotech/jellybeans.vim' "<<
let g:jellybeans_use_term_italics = 0
">>
"Plug 'romainl/Apprentice'
"Plug 'dracula/vim'
"Plug 'dunstontc/vim-vscode-theme'
"Plug 'tomasiser/vim-code-dark'
"Plug 'twerth/ir_black'
Plug 'morhetz/gruvbox' "<<
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=0
let g:gruvbox_sign_column='bg0'
">>
">>

"Plugin Group: StatusBar "<<
"Plug 'liuchengxu/eleline.vim'
Plug 'itchyny/lightline.vim' "<<

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endfunction

let g:lightline = {
\ 'colorscheme': 'one',
\ 'active': {
\   'left': [['mode', 'paste', 'readonly'],
\            ['relativepath', 'gitbranch', 'modified']],
\   'right': [['lineinfo'],
\             ['percent'],
\             ['cocstatus', 'fileformat', 'fileencoding', 'filetype']],
\ },
\ 'inactive': {
\   'left': [['mode', 'paste', 'readonly'],
\            ['relativepath', 'gitbranch']],
\   'right': [['lineinfo'],
\             ['percent'],
\             ['fileformat', 'fileencoding', 'filetype']],
\ },
\ 'component_function': {
\   'gitbranch': 'LightlineFugitive',
\   'readonly': 'LightlineReadonly',
\   'cocstatus': 'coc#status',
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
              \ 'dir': ['.svn','.git','.hg','build','third_party','.clangd'],
              \ 'file': ['*o']
              \}
let g:Lf_RecurseSubmodules = 1
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_RootMarkers = ['.git', '.hg', '.svn', '.project']
let g:Lf_DefaultExternalTool = "rg"
let g:Lf_UseVersionControlTool = 1
let g:Lf_DefaultMode='NameOnly'
">>

">>

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

"Plugin Group: Misc "<<
Plug 'vim-scripts/a.vim' "<<
let g:alternateExtensions_h = "cpp,c"
let g:alternateSearchPath = 'reg:/include/src/g/,reg:/src/include/g/'
let g:alternateRelativeFiles = 1
">>
"Plug 'iandingx/leetcode.vim'
"Plug 'itchyny/calendar.vim' "<<
"let g:calendar_google_calendar = 1
"let g:calendar_google_task = 1
">>
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

">>

syntax on

set belloff=all
set completeopt=menuone,noselect
set termguicolors
set signcolumn=yes
set shortmess+=c
set nocompatible
set title
set ttyfast
set cursorline
set timeoutlen=500
set vb t_vb=
set t_ut=
"set ttyscroll=1
set mouse=a
set laststatus=2
set number
set expandtab
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
set grepprg=grep\ -nH\ $*
set encoding=utf-8
set fileencodings=utf-8,big5,gb2312,utf16le
set fileformat=unix
set updatetime=500
set backspace=2
set hidden
set nobackup
set nowritebackup
set undofile
let &undodir=$HOME.'/.vim/undo'
call mkdir(&undodir, 'p')

command! TrimWhiteSpace :%s/\s\+$//gI
command! W silent execute "w !sudo > /dev/null tee %"
vmap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vmap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

nmap <F4> :qa<CR>
nmap Q <Nop>
imap <C-c> <ESC>
nmap <C-c> <ESC>
imap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

augroup BB
    au FileType sh,c,cpp,objc,objcpp,python,vim setlocal tw=0 expandtab fdm=syntax
    au FileType gitcommit setlocal spell
augroup END

let g:Gtags_Auto_Update = 1
nmap <silent> <Leader>s :GtagsCursor<CR>
nmap <silent> <Leader>g :execute("Gtags -g ".expand('<cword>'))<CR>
command! -nargs=1 S execute "Gtags -g "<f-args>

if &diff
    syntax off
    set nocursorline
    let g:coc_start_at_startup=0
endif
set background=dark
colorscheme onedark

" vim:foldmarker=<<,>>:foldlevel=0:foldmethod=marker:
