""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bbchung vimrc
" Last modify at 2014-11-27
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let vundle manage plugins {
let s:vundle_path=expand('~/.vim/bundle')
if !isdirectory(s:vundle_path."/vundle/.git")
    echo "Installing Vundle.."
    echo ""
    call mkdir(s:vundle_path, 'p')
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let s:can_install_bundle=1
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Bundle 'gmarik/vundle'
Bundle 'bbchung/chaotic'
Bundle 'bbchung/clighter'
Bundle 'bbchung/gasynctags'
Bundle 'kien/ctrlp.vim'
Bundle 'rhysd/vim-clang-format'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'Lokaltog/vim-powerline'
"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'bling/vim-airline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets.git'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'majutsushi/tagbar'
Bundle 'nanotech/jellybeans.vim'
"Bundle 'Conque-GDB'
"Bundle 'CSApprox'
Bundle 'gtags.vim'
"Bundle 'taglist.vim'
Bundle 'a.vim'
if exists('s:can_install_bundle')
    echo "Installing Bundles"
    echo ""
    :BundleInstall
endif

call vundle#end()
filetype plugin indent on
" }

" General vim settings {

colorscheme chaotic
syntax on               " syntax highlighing
set term=xterm-256color
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
set tabstop=4           " numbers of spaces of tab character
set nowrap
set shiftwidth=4        " numbers of spaces to (auto)indent
set scrolloff=3         " keep 3 lines when scrolling
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
set wildmode=list:longest,full
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

" AutoSession {
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

augroup AutoSession
    au!
    au VimLeavePre * call s:save_session()
    au VimEnter * call s:source_session()
augroup END
" }

" FileTypeConfig {
augroup FileTypeConfig
    au!
    au FileType * call s:config_dev()
    au FileType python call s:config_python()
    au FileType tex,help set tw=78 cc=78
    au FileType asm set filetype=nasm
augroup END

fun! s:config_dev()
    if index(["c", "cpp", "objc", "objcpp", "python", "nasm", "vim"], &filetype) != -1
        set tw=0
        set expandtab
        set tabstop=4
        set shiftwidth=4
        set fdm=syntax
    else
        set noexpandtab
        set fdm=manual
    endif
endf

fun! s:config_python()
    if executable("autopep8")
        set formatprg=autopep8\ -aa\ -
    endif
endf

" }

" Plugin: Tagbar {
let g:tagbar_left = 1
let g:tagbar_width = 28
nmap <silent> <F2> :TagbarToggle<CR>
" }

" Plugin: vim-clang-format {
let g:clang_format#auto_formatexpr=1
let g:clang_format#command = "clang-format-3.5"
let g:clang_format#style_options = {
            \ "BasedOnStyle" : "LLVM",
            \ "Language" : "Cpp",
            \ "PointerBindsToType" : "false",
            \ "ColumnLimit" : 0,
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortLoopsOnASingleLine" : "false",
            \ "AllowShortFunctionsOnASingleLine" : "false",
            \ "MaxEmptyLinesToKeep" : 2,
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "Cpp03",
            \ "IndentWidth" : 4,
            \ "UseTab" : "Never",
            \ "BreakBeforeBraces" : "Allman",
            \ "IndentCaseLabels" : "true",
            \ "BreakConstructorInitializersBeforeComma" : "true",
            \ "AllowAllParametersOfDeclarationOnNextLine" : "false",
            \ "BinPackParameters" : "false",
            \}
" }

" Plugin: YouCompleteMe {
let g:ycm_confirm_extra_conf=0
nmap <silent> <C-]> :YcmCompleter GoTo<CR>
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
" }

" Plugin: syntastic {
let g:syntastic_enable_signs=0
let g:syntastic_loc_list_height=5
" }

" Plugin: UltiSnips {
let g:UltiSnipsExpandTrigger = '<Leader><tab>'
" }

" Plugin: NERDTree {
let g:NERDTreeWinPos = 'right'
nmap <silent> <F4> :NERDTreeToggle<CR>
" }

" Plugin: Clighter {
nmap <silent> <Leader>r :call clighter#Rename()<CR>
" }

" Plugin: gtags.vim {
silent! nmap <silent><C-\>s :GtagsCursor<CR>
silent! nmap <silent><C-\>r :execute("Gtags -r ".expand('<cword>'))<CR>
silent! nmap <silent><C-\>d :execute("Gtags ".expand('<cword>'))<CR>
" }

" Plugin: vim-aireline {
let g:airline_theme="powerlineish"
" }

" vim:foldmarker={,}:foldlevel=0:foldmethod=marker:
