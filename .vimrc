""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bbchung vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-Plug {
let s:vim_plug_dir=expand($HOME.'/.vim/autoload')
if !filereadable(s:vim_plug_dir.'/plug.vim')
    call mkdir(s:vim_plug_dir, 'p')
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let s:install_plug=1
endif

call plug#begin('~/.vim/plugged')
Plug 'gmarik/vundle'
Plug 'nanotech/jellybeans.vim'
Plug 'bbchung/chaotic'
Plug 'itchyny/lightline.vim'
"Plug 'bling/vim-airline'
"Plug 'Shougo/unite.vim'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe'
Plug 'rhysd/vim-clang-format'
Plug 'bbchung/clighter'
Plug 'bbchung/gtags.vim'
"Plug 'klen/python-mode'
Plug 'scrooloose/syntastic'
"Plug 'kien/ctrlp.vim'
Plug 'jlanzarotta/bufexplorer'
"Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-multiple-cursors'
Plug 'a.vim'
call plug#end()

if exists('s:install_plug')
    augroup PlugInstall
        au!
        au VimEnter * PlugInstall
    augroup END
endif

" }

" General vim settings {

colorscheme chaotic
syntax on

set term=xterm-256color
if has("termtruecolor")
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
    set guicolors
endif
"set lazyredraw
set nocompatible
set ttyfast             " smoother changes
set title               " show title in console title bar
set novisualbell        " turn off visual bell
set mouse=a
set ttymouse=xterm2
set t_ZH=[3m
set nocursorline
set conceallevel=0
set concealcursor=nc
set ls=2                " allways show status line
set ruler               " show the cursor position all the time
set number              " show line numbers
set showcmd             " display incomplete commands
set softtabstop=4       " numbers of spaces of tab character
set shiftwidth=4        " numbers of spaces to (auto)indent
set colorcolumn=0
set nowrap
set scrolloff=3         " keep 3 lines when scrolling
set sidescrolloff=1
set incsearch           " do incremental searching
set nobackup            " do not keep a backup file
set modeline            " document sets vim mode
set ignorecase
set smartcase
set pumheight=12
set previewheight=4
set nospell             " disable spell checking
set foldlevelstart=20
set tabpagemax=100
set wildmode=longest,full
set wildmenu
set cot=longest,menuone
set grepprg=grep\ -nH\ $*
set ssop=buffers,curdir,folds,winsize,options,globals
set tenc=utf8
set fencs=utf8,big5,gb2312,utf-16
set ff=unix
set updatetime=700
set hls
set undofile

let &undodir=$HOME."/.vim/undo"
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

command! W silent execute "w !sudo > /dev/null tee %"
" }

" AutoInit {
fun! s:save_session()
    if exists('s:mksession')
        silent! mksession! .session
    endif
endf

fun! s:source_session()
    if index(["c", "cpp", "objc", "objcpp", "python"], &filetype) != -1
        let s:mksession=1
    endif

    if argc() == 0 && filereadable(".session")
        echohl MoreMsg |
                    \ echomsg "Session Loaded" |
                    \ echohl None
        silent! source .session
        let s:mksession=1
    endif
endf

fun! s:build_gtags()
    if index(["c", "cpp"], &filetype) == -1
        return
    endif

    if executable('gtags') && !filereadable('GTAGS')
        echohl MoreMsg |
                    \ echomsg "building gtags" |
                    \ echohl None
        silent call system('gtags')
    endif
endf

augroup AutoInit
    au!
    au VimLeavePre * call s:save_session()
    au VimEnter * call s:source_session()

    au VimEnter * call s:build_gtags()
augroup END
" }

" FileTypeConfig {
augroup FileTypeConfig
    au!
    au FileType c,cpp,objc,objcpp,python,nasm,vim setlocal tw=0 expandtab fdm=syntax
    au FileType python setlocal ts=4 formatprg=autopep8\ -a\ -a\ --experimental\ -
    au FileType tex,help setlocal tw=78 cc=78 formatprg=
    au FileType asm setlocal filetype=nasm formatprg=
augroup END
" }

" Plugin: Tagbar {
let g:tagbar_left = 1
let g:tagbar_width = 28
nmap <silent> <F2> :TagbarToggle<CR>
" }

" Plugin: vim-clang-format {
let g:clang_format#command = "clang-format-3.5"
let g:clang_format#auto_formatexpr=1
let g:clang_format#style_options = {
            \ "BasedOnStyle" : "LLVM",
            \ "UseTab" : "Never",
            \ "IndentWidth" : 4,
            \ "BreakBeforeBraces" : "Allman",
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "IndentCaseLabels" : "false",
            \ "ColumnLimit" : 0,
            \ "PointerAlignment" : "Right",
            \ "AccessModifierOffset" : -4,
            \ "AllowShortLoopsOnASingleLine" : "false",
            \ "AllowShortFunctionsOnASingleLine" : "false",
            \ "MaxEmptyLinesToKeep" : 2,
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "Auto",
            \ "BreakConstructorInitializersBeforeComma" : "true",
            \ "AllowAllParametersOfDeclarationOnNextLine" : "false",
            \ "BinPackParameters" : "false",
            \}
" }

" Plugin: YouCompleteMe {
let g:ycm_confirm_extra_conf=0
nmap <silent> <C-]> :YcmCompleter GoTo<CR>
" }

" Plugin: syntastic {
let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 0
let g:syntastic_python_checkers = ['pylint', 'pyflakes', 'pep8']
" }

" Plugin: UltiSnips {
let g:UltiSnipsExpandTrigger = '<Leader><tab>'
" }

" Plugin: Clighter {
nmap <silent> <Leader>r :call clighter#Rename()<CR>
"let g:clighter_libclang_file = 'libclang-3.7.so.1'
" }

" Plugin: gtags.vim {
nmap <silent><C-\>s :GtagsCursor<CR>
nmap <silent><C-\>r :execute("Gtags -r ".expand('<cword>'))<CR>
nmap <silent><C-\>d :execute("Gtags ".expand('<cword>'))<CR>

let g:Gtags_Auto_Update = 1
" }

" Plugin: unite.vim {
"silent! nmap <silent> <Leader>be :Unite -here buffer<CR>
"nmap <silent> <C-p> :Unite -start-insert -here file_rec<CR>
" }

" Plugin: CtrlP.vim {
"silent! nmap <silent> <Leader>b :CtrlPBuffer<CR>
" }

" Plugin: lightline.vim {
let g:lightline = {
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'myreadonly', 'relativepath', 'modified' ] ],
			\ },
			\ 'inactive': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'myreadonly', 'relativepath', 'modified' ] ],
			\ }
            \}
" }

" vim:foldmarker={,}:foldlevel=0:foldmethod=marker:
