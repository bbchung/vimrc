""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bbchung vimrc
" Last modify at 2014-09-22
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
Bundle 'Lokaltog/vim-powerline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/MatchTagAlways'
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets.git'
Bundle 'jlanzarotta/bufexplorer'
"Bundle 'Conque-GDB'
"Bundle 'CSApprox'
Bundle 'gtags.vim'
Bundle 'taglist.vim'
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
if has("gui_running")
	set guifont=Inconsolata\ 15
else
	set t_Co=256
endif

colorscheme chaotic
syntax on				" syntax highlighing
set term=xterm-256color
set ttyfast				" smoother changes
set title				" show title in console title bar
set novisualbell		" turn off visual bell
set mouse=a
set ttymouse=xterm2
set t_ZH=[3m
set nocursorline
set conceallevel=0
set concealcursor=nc
set ls=2				" allways show status line
set ruler				" show the cursor position all the time
set number				" show line numbers
set showcmd				" display incomplete commands
set tabstop=4			" numbers of spaces of tab character
set nowrap
set shiftwidth=4		" numbers of spaces to (auto)indent
set scrolloff=3			" keep 3 lines when scrolling
set incsearch			" do incremental searching
set nobackup			" do not keep a backup file
set modeline			" document sets vim mode
set ignorecase
set smartcase
set pumheight=12
set previewheight=4
set nospell				" disable spell checking
set foldlevelstart=20
set tabpagemax=100
set wildmode=list:longest,full
set cot=longest,menuone
set grepprg=grep\ -nH\ $*
set ssop=buffers,curdir,folds,winsize,options,globals
set tenc=utf8
set fencs=utf8,big5,gb2312,utf-16
set ff=unix
set updatetime=1200
set hls
let s:dir=$HOME."/.vim/undo"
if !isdirectory(s:dir)
    call mkdir(s:dir, "p")
endif
set undofile
execute "set undodir=".s:dir
command! W silent execute "w !sudo > /dev/null tee %"
" }

" Project {
fun! s:load_project()
	silent! source .session
	silent! rviminfo .viminfo
endf

fun! s:save_project()
	silent! mksession! .session
	silent! wviminfo! .viminfo
endf

augroup Project
	au!
	au Filetype c,cpp,objc set tw=0 et fdm=syntax |
				\ vmap <silent>= :ClangFormat<CR> |
				\ let s:in_project=1
				"set formatprg=astyle\ -A1TCSKfpHUk3W3ynq\ --delete-empty-lines

	au FileType python set tw=0 et
	au FileType vim set tw=0 et
	au FileType tex set tw=120 noet
	au FileType help set tw=78 noet

	au VimLeavePre * if exists('s:in_project') | call s:save_project() | endif
	au VimEnter * if argc()== 0 | call s:load_project() | endif
augroup END
" }

" Plugin: TagList {
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
let Tlist_WinWidth=24
nmap <silent> <F2> :Tlist<CR>
"let Tlist_Auto_Open = 1
"let Tlist_Display_Prototype=1
"let Tlist_Use_Right_Window = 1
" }

" Plugin: vim-clang-format {
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

" Plugin: vim-powerline {
let g:Powerline_colorscheme = 'solarized256'
"let g:Powerline_symbols = 'compatible'
"let g:Powerline_theme = 'solarized256'
" }

" Plugin: YouCompleteMe {
let g:ycm_confirm_extra_conf=0
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
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

" vim:tw=78:ts=8:noet:foldmarker={,}:foldlevel=0:foldmethod=marker:
