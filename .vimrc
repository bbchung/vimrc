""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bbchung vimrc
" Last modify at 2014-05-09
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let vundle manage plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vundle_path=expand('~/.vim/bundle/vundle')
if !isdirectory (s:vundle_path)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
	let s:can_install_bundle
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'nanotech/jellybeans.vim'
Bundle 'bbchung/chaotic'
Bundle 'kien/ctrlp.vim'
Bundle 'rhysd/vim-clang-format'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
"Bundle 'tomtom/tcomment_vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/MatchTagAlways'
Bundle 'Raimondi/delimitMate'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets.git'
Bundle 'jlanzarotta/bufexplorer'

Bundle 'Conque-GDB'
Bundle 'taglist.vim'
Bundle 'CSApprox'
Bundle 'a.vim'
if exists('s:can_install_bundle') 
	echo "Installing Bundles"
	echo ""
	:BundleInstall
endif

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
	set guifont=Inconsolata\ 15		
else
	set t_Co=256
endif

colorscheme chaotic
syntax on				" syntax highlighing
set conceallevel=0
set concealcursor=nc
set ls=2				" allways show status line
set hlsearch			" highlight searches
set ruler				" show the cursor position all the time
set number				" show line numbers
set showcmd				" display incomplete commands
set title				" show title in console title bar
set ttyfast				" smoother changes
set previewheight=4
set novisualbell		" turn off visual bell
set tabstop=4			" numbers of spaces of tab character
set shiftwidth=4		" numbers of spaces to (auto)indent
set scrolloff=3			" keep 3 lines when scrolling
set incsearch			" do incremental searching
set nobackup			" do not keep a backup file
set modeline			" last lines in document sets vim mode
set ignorecase
set smartcase
set pumheight=12
set nospell				" disable spell checking 
set foldmethod=manual
set switchbuf=usetab	"use opened buffer
set mouse=a
set ttymouse=xterm2
set tabpagemax=100
set wildmode=list:longest,full
set si					" syntax indent, like autoindent but consider some syntax
set cot=longest,menuone
set grepprg=grep\ -nH\ $*
set ssop=buffers,curdir,folds,winsize,options,globals
set tenc=utf8
set fencs=utf8,big5,gb2312,utf-16
set ff=unix
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
set undofile
let s:dir=$HOME."/.vimundodir"
if !isdirectory(s:dir)
	call mkdir(s:dir, "p")
endif
execute "set undodir=".s:dir

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoTags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cst
set csto=1
set nocsverb

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  
nmap <silent> <C-\>u :call AutoTagUpdate()<CR>

if !cscope_connection()
	if filereadable("GTAGS")	
		set cscopeprg=gtags-cscope
		cs add GTAGS
	endif
endif

if !cscope_connection()
	if filereadable("cscope.out")
		set cscopeprg=cscope
		cs add cscope.out  
	endif
endif

function! AutoTagUpdate()
	if cscope_connection(1, 'GTAGS')
		execute "!global -u"
	endif
	if cscope_connection(1, 'cscope.out')
		execute "!cscope -Rbkq"
		cs reset
	endif
endfunction

"function! s:init_tag()
"	if !cscope_connection()
"		if !filereadable("GTAGS")	
"			echo "init tags..."
"			silent! execute "!gtags"
"		endif
"		cs add GTAGS
"	else
"		silent! execute "!killall -9 global > /dev/null 2>&1"
"		silent! execute "!global -u &"
"	endif
"endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoTypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType c,cpp call s:ft_cpp()
au FileType python call s:ft_python()
au FileType tex call s:ft_tex()
au FileType c,cpp,objc vmap = :ClangFormat<CR>

function! s:ft_cpp()
	"execute "set makeprg=make\\ -j3"
	"set formatprg=astyle\ -A1TCSKfpHUk3W3ynq\ --delete-empty-lines
	set textwidth=0
	set expandtab
endfunction

function! s:ft_python()
	set textwidth=0
	set expandtab
endfunction

function! s:ft_tex()
	set textwidth=120
	set noexpandtab
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoTab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"imap <TAB> <C-R>=AutoTab(0)<CR><C-R>=AutoSelect()<CR>
"imap <S-TAB> <C-R>=AutoTab(1)<CR><C-R>=AutoSelect()<CR>
"
"function! AutoTab(force)
"	if match(getline('.')[col('.')-2], '\t\|\s\|\b') == 0 || col('.') == 1 || &omnifunc == ""
"		return "\<TAB>"
"	else
"		if pumvisible() && a:force == 0
"			return ""
"		else
"			return "\<c-x>\<c-o>\<c-p>"
"		endif
"	endif
"endfunction

"function! AutoSelect()
"	if pumvisible()
"		return "\<Down>"
"	else
"		return ""
"	endif
"endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SudoWrite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command W silent execute "w !sudo > /dev/null tee %"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoSession
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au VimEnter * call s:load_session()
au VimLeave *.[ch],*.[ch]pp call s:save_session()
fun! s:load_session()
	if argc() > 0
		return
	endif
	silent! source .session
	silent! rviminfo .viminfo	
endf

function! s:save_session()
	mksession! .session
	wviminfo! .viminfo
endfunction

"let s:session_loaded = 0
"un! s:confirm_load_session()
"if argc() > 0
"	return
"endif
"if filereadable('.session')
"	let choice = confirm("session file exists.", "&Load\n&Ignore", 1)
"	if choice == 1
"		silent! source .session
"		silent! rviminfo .viminfo	
"		let s:session_loaded = 1
"	endif
"	endif
"endf

"function! s:confirm_save_session()
"	if s:session_loaded == 1
"		mksession! .session
"		wviminfo! .viminfo
"		return
"	endif
"
"	let choice = 0
"	if !filereadable('.session')
"		let choice = confirm("create new session?", "&Yes\n&No", 2)
"	else
"		let choice = confirm("overwrite session?", "&Yes\n&No", 2)
"	endif
"	if choice == 1
"		mksession! .session
"		wviminfo! .viminfo
"		return
"	endif
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: Pyclewn
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! EnterDebugMode()
"	Pyclewn
"	Cmapkeys
"	nmap <C-P> :exe "Cprint " . expand("<cword>") <CR> 
"	"nmap <C-D> :silent! exe "Cdbgvar " . expand("<cword>") <CR> 
"	nmap <C-F7> :Cshell setsid xterm -e inferior_tty.py &<CR>
"	set nomodifiable
"	1,$foldopen!
"endfunction

"function! ExitDebugMode()
"	Cquit
"	nbclose
"	set modifiable
"	nunmap <C-F7>
"	nunmap <C-P>
"	Cunmapkeys
"	"silent! nunmap <C-D>
"	if (bufexists("(clewn)_console") > 0)
"		bd (clewn)_console
"	endif
"	if (bufexists("(clewn)_dbgvar") > 0)
"		bd (clewn)_dbgvar
"	endif
"endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: CSApprox	
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if !has("gui_running")
"	let g:CSApprox_loaded=0
"	let g:CSApprox_verbose_level=0
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: TagList	
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
let Tlist_WinWidth=24
"let Tlist_Auto_Open = 1
"let Tlist_Display_Prototype=1
nmap <silent> <F2> :Tlist<CR>
"let Tlist_Use_Right_Window = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: VIM-LaTeX	
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:tex_flavor='latex'
"let g:Tex_DefaultTargetFormat='pdf'
"let Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-clang-format	
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format#style_options = {
			\ "BasedOnStyle" : "LLVM",
			\ "PointerBindsToType" : "true",
			\ "ColumnLimit" : 0,
			\ "AccessModifierOffset" : -4,
			\ "AllowShortIfStatementsOnASingleLine" : "false", 
			\ "AlwaysBreakTemplateDeclarations" : "true", 
			\ "Standard" : "C++11", 
			\ "IndentWidth" : 4, 
			\ "UseTab" : "Never", 
			\ "BreakBeforeBraces" : "Allman" } 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-powerline 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Powerline_symbols = 'compatible'
"let g:Powerline_colorscheme = 'solarized256'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: YouCompleteMe  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_confirm_extra_conf=0
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
nmap <silent> <C-]> :YcmCompleter GoTo<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: syntastic  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_enable_signs=0
let g:syntastic_loc_list_height=5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: UltiSnips  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = '<Leader><tab>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: NERDTree  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = 'right'
nmap <silent> <F4> :NERDTreeToggle<CR>
