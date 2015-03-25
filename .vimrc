""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bbchung vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let vundle manage plugins {
let s:vundle_root=expand($HOME.'/.vim/bundle')
if !isdirectory(s:vundle_root."/vundle/.git")
    echo "Installing Vundle.."
    echo ""
    call mkdir(s:vundle_root, 'p')
    silent execute '!git clone https://github.com/gmarik/vundle '.s:vundle_root.'/vundle'
    let s:can_install_bundle=1
endif

set nocompatible
filetype off

execute 'set rtp+='.s:vundle_root.'/vundle'
call vundle#begin()
Bundle 'gmarik/vundle'
Bundle 'nanotech/jellybeans.vim'
Bundle 'bbchung/chaotic'
Bundle 'itchyny/lightline.vim'
"Bundle 'bling/vim-airline'
"Bundle 'Shougo/unite.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'Valloric/YouCompleteMe'
Bundle 'rhysd/vim-clang-format'
Bundle 'bbchung/clighter'
Bundle 'bbchung/gtags.vim'
"Bundle 'klen/python-mode'
Bundle 'scrooloose/syntastic'
"Bundle 'kien/ctrlp.vim'
Bundle 'jlanzarotta/bufexplorer'
"Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'Raimondi/delimitMate'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'a.vim'
if exists('s:can_install_bundle')
    echo "Installing Bundles\n"
    :BundleInstall
endif

call vundle#end()
filetype plugin indent on
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
silent! nmap <silent><C-\>s :GtagsCursor<CR>
silent! nmap <silent><C-\>r :execute("Gtags -r ".expand('<cword>'))<CR>
silent! nmap <silent><C-\>d :execute("Gtags ".expand('<cword>'))<CR>

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
