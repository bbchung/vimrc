let s:home = $HOME.'/.vim/'
let &undodir=$HOME.'/.vim/undo'
call mkdir(&undodir, 'p')
let s:vim_plug_dir=expand(s:home.'/autoload')
if !filereadable(s:vim_plug_dir.'/plug.vim')
    exe '!wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P '.s:vim_plug_dir
    let s:install_plug=1
endif

packadd termdebug
let g:termdebug_wide = 1

call plug#begin(s:home.'/plugged') "<<

"Plugin Group: Language "<<

Plug 'bfrg/vim-cpp-modern' "<<
let g:cpp_no_function_highlight = 1
">>

Plug 'jackguo380/vim-lsp-cxx-highlight' "<<
let g:lsp_cxx_hl_use_nvim_text_props = 1
let g:lsp_cxx_hl_use_text_props = 1
">>

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} "<<
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr :cexpr[] <BAR> call CocAction('jumpReferences') <CR>
nmap <Leader>x <Plug>(coc-fix-current)
nmap <silent> <Leader>r <Plug>(coc-rename)
nmap <silent> <Leader>k :call CocAction("format") <CR>
nmap <silent> <Leader>a :CocAction<CR>
let g:coc_enable_locationlist = 0
au User CocLocationsChange CocList --normal location
au CursorHold * call CocActionAsync('highlight')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

imap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endf

imap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
imap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
imap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
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

"Plug 'jalvesaq/Nvim-R'
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
Plug 'ayu-theme/ayu-vim' "<<
let ayucolor='dark'
">>
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim' "<<
let g:jellybeans_use_term_italics = 0
let g:jellybeans_use_gui_italics = 0
">>
Plug 'romainl/Apprentice'
Plug 'dracula/vim'
"Plug 'dunstontc/vim-vscode-theme'
Plug 'tomasiser/vim-code-dark'
"let g:codedark_conservative = 0
"Plug 'twerth/ir_black'
Plug 'morhetz/gruvbox' "<<
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=0
let g:gruvbox_sign_column='bg0'
">>
Plug 'sainnhe/everforest' "<<
let g:everforest_background = 'hard'
let g:everforest_enable_italic = 0
let g:everforest_disable_italic_comment = 1
">>
Plug 'sainnhe/gruvbox-material' "<<
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
">>
Plug 'arcticicestudio/nord-vim' "<<
">>
">>
">>

"Plugin Group: StatusLine "<<
"Plug 'liuchengxu/eleline.vim'
Plug 'itchyny/lightline.vim' "<<

function! RelativePath()
    return expand('%:~:.')
endf
function! LightlineFugitive()
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endf

let g:lightline = {
\ 'colorscheme': 'nord',
\ 'active': {
\   'left': [['mode', 'paste', 'readonly'],
\            ['relativepath', 'gitbranch'], ['modified']],
\   'right': [['percent', 'lineinfo'],
\             ['fileformat', 'fileencoding', 'filetype'], ['cocstatus']]
\ },
\ 'inactive': {
\   'left': [['mode', 'paste', 'readonly'],
\            ['relativepath', 'gitbranch'], ['modified']],
\   'right': [['percent', 'lineinfo'],
\             ['fileformat', 'fileencoding', 'filetype']]
\ },
\ 'component': {
\   'paste': '%{&paste?"📋":""}',
\   'readonly': '%{&readonly?"🔒":""}',
\ },
\ 'component_function': {
\   'gitbranch': 'LightlineFugitive',
\   'cocstatus': 'coc#status',
\   'relativepath': 'RelativePath',
\ },
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' }
\ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

">>

"Plug 'vim-airline/vim-airline' "<<
let g:airline_powerline_fonts = 1
let g:airline#extensions#csv#column_display = 'Name'
let g:airline#extensions#whitespace#checks = ['trailing']
">>
"Plug 'vim-airline/vim-airline-themes'

">>

"Plugin Group: Search "<<

"Plug 'junegunn/fzf' "<<
"nmap <silent> <C-p> :FZF<CR>
">>

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } "<<
let g:Lf_PopupColorscheme='nord'
let g:Lf_WildIgnore = {
              \ 'dir': ['.svn','.git','.hg','build','third_party','.clangd'],
              \ 'file': ['*o']
              \}
let g:Lf_WindowHeight = 0.2
let g:Lf_RecurseSubmodules = 1
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsAutoUpdate = 0
let g:Lf_RootMarkers = ['compile_commands.json']
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_UseVersionControlTool = 1
let g:Lf_DefaultMode='NameOnly'
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_CursorBlink = 0
let g:Lf_PopupShowStatusline=0
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_ShowDevIcons = 0
let g:Lf_GtagsStoreInProject = 1
let g:Lf_WorkingDirectoryMode = 'a'
"nmap <silent> <Leader>s :silent! exe "Leaderf! gtags --stayOpen --bottom -r ".expand('<cword>')<CR>
"vmap <silent> <Leader>s :silent! <C-U> exe "Leaderf! gtags --stayOpen --bottom -r ".getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]]<CR>
"nmap <silent> <Leader>g :silent! exe "Leaderf! gtags --stayOpen --bottom -g ".expand('<cword>')<CR>
"vmap <silent> <Leader>g :silent! <C-U> exe "Leaderf! gtags --stayOpen --bottom -g ".getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]]<CR>
"command! -nargs=1 S silent! exe "Leaderf! gtags --stayOpen --bottom -g "<f-args>
">>

">>

"Plugin Group: Explorer "<<
"Plug 'liuchengxu/vista.vim' "<<
"let g:vista#renderer#icons=0
">>
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


Plug 'cohama/lexima.vim' "<<
let g:lexima_accept_pum_with_enter = 0
au VimEnter * call lexima#add_rule({'char': '(', 'at': '\%#\S'})
au VimEnter * call lexima#add_rule({'char': '[', 'at': '\%#\S'})
au VimEnter * call lexima#add_rule({'char': '{', 'at': '\%#\S'})
au VimEnter * call lexima#add_rule({'char': '"', 'at': '\%#\S'})
au VimEnter * call lexima#add_rule({'char': '"', 'at': '\S\%#'})
au VimEnter * call lexima#add_rule({'char': '"', 'at': '"\%#"', 'leave': '"'})
au VimEnter * call lexima#add_rule({'char': "\'", 'at': '\%#\S'})
au VimEnter * call lexima#add_rule({'char': "\'", 'at': '\S\%#'})
au VimEnter * call lexima#add_rule({'char': "\'", 'at': "\'\%#\'", 'leave': "\'"})
" >>

"Plug 'Raimondi/delimitMate' "<<
"let g:delimitMate_expand_cr=1
" >>

"Plug 'jiangmiao/auto-pairs' "<<
"let g:AutoPairsFlyMode = 0
"let g:AutoPairsMultilineClose=0
">>
">>

"Plugin Group: Misc "<<
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-scripts/a.vim' "<<
let g:alternateExtensions_h = 'cpp,c'
let g:alternateSearchPath = 'reg:/include/src/g/,reg:/src/include/g/'
let g:alternateRelativeFiles = 1
">>
"Plug 'ianding1/leetcode.vim'
let g:leetcode_browser='firefox'
"Plug 'itchyny/calendar.vim' "<<
"let g:calendar_google_calendar = 1
"let g:calendar_google_task = 1
">>
Plug 'mhinz/vim-startify' "<<
let g:startify_session_persistence=1
let g:startify_change_to_dir=0
let g:startify_fortune_use_unicode = 1
autocmd User Startified setlocal cursorline
">>

Plug 'tpope/vim-fugitive'
"Plug 'roxma/vim-tmux-clipboard'
"Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'chrisbra/csv.vim' "<<
let g:no_csv_maps=1
">>
"Plug 'mechatroner/rainbow_csv'

Plug 'bbchung/gasynctags'
let g:gasynctags_auto_update = 1

">>

call plug#end()

if exists('s:install_plug')
    PlugInstall
endif

">>

syntax on

set vb t_vb=
set t_ut=
set t_Cs = "\e[4:3m"
set guicursor=
set signcolumn=number
set cst
set csprg=gtags-cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
set belloff=all
set completeopt=menuone,noselect
set diffopt+=vertical
set termguicolors
set shortmess+=c
set nocompatible
set title
set ttyfast
set cursorline
set timeoutlen=500
set nowrap
set mouse=a
set mousemodel=popup_setpos
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
set fileformats=unix,dos
set updatetime=200
set backspace=2
set hidden
set nobackup
set nowritebackup
set undofile

function! <SID>show_doc()
    if (index(['vim','help'], &filetype) >= 0)
        exe 'h '.expand('<cword>')
    elseif (index(['csv'], &filetype) >= 0)
        WhatColumn!
    else
        call CocAction('doHover')
    endif
endf

function! CsvFormat(start, end)
    execute a:start.','.a:end.'CSVArrangeColumn'
endf

command! W silent exe "w !sudo > /dev/null tee %"
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

"nmap <C-c> <Esc>
"imap <C-c> <Esc>
nmap <F4> :qa<CR>
nmap <F3> :bd<CR>
nmap Q <Nop>
tmap <Esc> <C-W>N
tmap <Esc><Esc> <C-W>N
nmap <silent> K :call <SID>show_doc()<CR>

au FileType c,cpp,sh,python,vim setlocal tw=0 expandtab fdm=syntax
au FileType gitcommit setlocal spell
au FileType markdown setlocal textwidth=80
au FileType c,cpp setlocal formatexpr=CocAction('formatSelected')
au FileType csv setlocal formatexpr=CsvFormat(v:lnum,v:lnum+v:count-1)
"au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"let g:terminal_ansi_colors = ['#282C34', '#E06C75', '#98C379', '#E5C07B', '#61AFEF', '#C678DD', '#56B6C2', '#ABB2BF', '#3E4452', '#BE5046', '#98C379', '#D19A66', '#61AFEF', '#C678DD', '#56B6C2', '#5C6370']
set background=dark
if &diff
    set noro
    syntax off
    set nocursorline
    let g:coc_start_at_startup=0
else
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! `\"" | endif " restore cursor position
endif
colorscheme nord

hi link CocHighlightText MatchParen
" vim:foldmarker=<<,>>:foldlevel=0:foldmethod=marker:
