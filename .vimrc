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

"Plugin Group: LSP "<<
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} "<<
let g:coc_global_extensions = [
            \'coc-clang-format-style-options',
            \'coc-clangd',
            \'coc-cmake',
            \'coc-json',
            \'coc-lists',
            \'coc-pyright',
            \'coc-r-lsp',
            \'coc-sh',
            \'coc-tabnine',
            \'coc-vimlsp',
            \'coc-yaml',
            \'coc-snippets'
            \]
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr :cexpr[] <CR> <Plug>(coc-references)
nmap <Leader>x <Plug>(coc-fix-current)
nmap <silent> <Leader>r <Plug>(coc-rename)
nmap <silent> <Leader>k <Plug>(coc-format)
vmap <silent> <leader>k <Plug>(coc-format-selected)
map <silent> <Leader>a :CocAction<CR>
let g:coc_enable_locationlist = 0
au User CocLocationsChange CocList --normal location
au CursorHold * call CocActionAsync('highlight')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! A CocCommand clangd.switchSourceHeader

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

nmap <silent> <C-s> <Plug>(coc-range-select)
nmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
imap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
imap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
au User TermdebugStartPre silent CocDisable
au User TermdebugStopPost silent CocEnable
"au User CocStatusChange,CocDiagnosticChange call lightline#update()
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
let g:everforest_sign_column_background = 'none'
let g:everforest_diagnostic_text_highlight = 1
let g:everforest_better_performance = 1

">>
Plug 'sainnhe/gruvbox-material' "<<
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_sign_column_background = 'none'
">>
Plug 'arcticicestudio/nord-vim' "<<
">>
">>

"Plugin Group: StatusLine "<<
Plug 'itchyny/vim-gitbranch' "<<
" >>
"Plug 'itchyny/lightline.vim' "<<

function! RelativePath()
    return expand('%:~:.')
endf
function! LightlineFugitive()
        let branch = gitbranch#name()
        return branch !=# '' ? ''.branch : ''
endf

let g:lightline =
\ {
\    "colorscheme":"everforest",
\    "active":{
\       "left":[
\          ["mode", "paste"],
\          ["readonly", "relativepath", "modified"],
\          ["gitbranch"]
\       ],
\       "right":[
\          ["lineinfo"],
\          ["percent"],
\          ["cocstatus", "fileformat", "fileencoding", "filetype"]
\       ]
\    },
\    "inactive":{
\       "left":[
\          ["mode", "paste"],
\          ["readonly", "relativepath", "modified"],
\          ["gitbranch"]
\       ],
\       "right":[
\          ["lineinfo"],
\          ["percent"],
\          ["cocstatus", "fileformat", "fileencoding", "filetype"]
\       ]
\    },
\    "component":{
\       "paste":"%{&paste?\"📋\":\"\"}",
\       "readonly":"%{&readonly?\"🔒\":\"\"}"
\    },
\    "component_function":{
\       "gitbranch":"LightlineFugitive",
\       "cocstatus":"coc#status",
\       "relativepath":"RelativePath"
\    },
\    "separator":{
\       "left":"",
\       "right":""
\    },
\    "subseparator":{
\       "left":"",
\       "right":""
\    }
\ }

">>
Plug 'vim-airline/vim-airline' "<<
let g:airline_experimental = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#csv#column_display = 'Name'
let g:airline#extensions#scrollbar#enabled = 0
">>
Plug 'vim-airline/vim-airline-themes'
">>

"Plugin Group: Search "<<
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } "<<
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

"Plugin Group: Edit "<<
Plug 'scrooloose/nerdcommenter'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate' "<<
let g:delimitMate_expand_cr=1
let g:delimitMate_smart_matchpairs = '^\%(\w\|\!\)'
" >>
"Plug 'cohama/lexima.vim' "<<
"au VimEnter * call lexima#add_rule({'char': '(', 'at': '\%#\S'})
"au VimEnter * call lexima#add_rule({'char': '[', 'at': '\%#\S'})
"au VimEnter * call lexima#add_rule({'char': '{', 'at': '\%#\S'})
"au VimEnter * call lexima#add_rule({'char': '"', 'at': '\%#\S'})
"au VimEnter * call lexima#add_rule({'char': '"', 'at': '\S\%#'})
"au VimEnter * call lexima#add_rule({'char': '"', 'at': '"\%#"', 'leave': '"'})
"au VimEnter * call lexima#add_rule({'char': "'", 'at': '\%#\S'})
"au VimEnter * call lexima#add_rule({'char': "'", 'at': '\S\%#'})
"au VimEnter * call lexima#add_rule({'char': "'", 'at': '''\%#''', 'leave': "'"})

" >>
">>

"Plugin Group: Misc "<<
"Plug 'Yggdroot/indentLine' "<<
let g:indentLine_setColors=0
let g:indentLine_fileType=['c', 'cpp', 'python', 'r']
let g:indentLine_char = '⸽'
">>
Plug 'skywind3000/asyncrun.vim'
">>
"Plug 'ianding1/leetcode.vim' "<<
let g:leetcode_browser='firefox'
">>
Plug 'mhinz/vim-startify' "<<
let g:startify_session_persistence=1
let g:startify_change_to_dir=0
let g:startify_fortune_use_unicode = 1
let g:startify_relative_path = 1
autocmd User Startified setlocal cursorline
">>
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/csv.vim' "<<
let g:no_csv_maps=1
">>
"Plug 'mechatroner/rainbow_csv'
Plug 'bbchung/gasynctags' "<<
let g:gasynctags_auto_update = 1
">>

">>

call plug#end()

if exists('s:install_plug')
    PlugInstall
endif

">>

syntax on

set nomore
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
set shortmess-=S
set shortmess+=c
set title
set cursorline
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
set sidescrolloff=8
set incsearch
set hlsearch
set ignorecase
set smartcase
set pumheight=12
set previewheight=4
set foldlevelstart=99
set wildmode=longest,full
set wildmenu
set wildoptions=pum,fuzzy
set grepprg=grep\ -nH\ $*
set encoding=utf-8
set fileencodings=utf-8,big5,gb2312,utf16le
set fileformats=unix,dos
set updatetime=200
set hidden
set nobackup
set nowritebackup
set undofile
set backspace=indent,eol,start

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

"map <C-c> <Esc>
"imap <C-c> <Esc>
nmap <F3> :bd!<CR>
map <F4> :qa!<CR>
tmap <F4> <C-W>N:qa!<CR>
nmap <F5> :bp<CR>
nmap <F6> :bn<CR>
nmap Q <Nop>
tmap <Esc><Esc> <C-W>N
nmap <silent> K :call <SID>show_doc()<CR>

au BufRead * cd .
au FileType c,cpp,sh,python,vim setlocal tw=0 expandtab fdm=syntax
au FileType gitcommit setlocal spell
au FileType markdown setlocal textwidth=80
au FileType c,cpp,python setlocal formatexpr=CocAction('formatSelected')
au FileType csv setlocal formatexpr=CsvFormat(v:lnum,v:lnum+v:count-1)
"au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

set background=dark
if &diff
    set noro
    syntax off
    set nocursorline
    let g:coc_start_at_startup=0
else
    au BufWinEnter * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif " restore cursor position
endif
colorscheme everforest
"hi link CocHighlightText MatchParen

" vim:foldmarker=<<,>>:foldlevel=0:foldmethod=marker:
