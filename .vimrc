""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BB's vim setting
" Last modify at 2013-2-19
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'tomtom/tcomment_vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'bbchung/chaotic'
Bundle 'kien/ctrlp.vim'
Bundle 'gmarik/vundle'
"Bundle 'vim-scripts/c.vim'
Bundle 'rhysd/vim-clang-format'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/MatchTagAlways'
Bundle 'SirVer/ultisnips'
Bundle 'jiangmiao/auto-pairs'

Bundle 'Conque-GDB'
Bundle 'taglist.vim'
Bundle 'CSApprox'
Bundle 'bufexplorer.zip'
Bundle 'a.vim'
filetype plugin indent on     " required!


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
set foldmethod=syntax
set switchbuf=usetab	"use opened buffer
set mouse=a
set ttymouse=xterm2
set tabpagemax=100
set wildmode=list:longest,full
set si					" syntax indent, like autoindent but consider some syntax
set cot=longest,menuone
set grepprg=grep\ -nH\ $*
set cscopeprg=gtags-cscope
set cst
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
" Functions definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! s:check_compiler()
"if executable("clang")
"	let g:C_CCompiler='clang'
"	if executable("gcc")
"		let g:C_CCompiler='gcc'
"	endif
"if executable("clang++")
"	let g:C_CplusCompiler='clang++'
"	if executable("g++")
"		let g:C_CplusCompiler='g++'
"	endif
"endfunction

"function! s:init_clang()
"	if &filetype == 'cpp'	
"		let g:clang_user_options=g:clang_user_options." -include-pch /home/bb/.vim/pch/cpp.pch"
"	endif
"	if !filereadable(".clang_complete")
"		call writefile([], ".clang_complete", "")
"	endif
"endfunction


function! s:ft_cpp()
	"	let g:pyclewn_args="-w bottom"
	"	nmap <C-F6> :silent! call EnterDebugMode() <CR>
	"	nmap <C-F8> :silent! call ExitDebugMode() <CR>
	"execute "set makeprg=make\\ -j3\\ CC=".g:C_CCompiler."\\ CXX=".g:C_CplusCompiler
	execute "set makeprg=make\\ -j3"
	set formatprg=astyle\ -A1TCSKfpHUk3W3ynq\ --delete-empty-lines
	set textwidth=0
	set noexpandtab
	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  
endfunction

function! s:ft_python()
	set textwidth=0
	set expandtab
endfunction

function! s:ft_tex()
	set textwidth=120
	set noexpandtab
endfunction

function! s:init_tag()
	if !cscope_connection()
		if !filereadable("GTAGS")	
			echo "init tags..."
			silent! execute "!gtags"
		endif
		cs add GTAGS
	else
		silent! execute "!killall -9 global > /dev/null 2>&1"
		silent! execute "!global -u &"
	endif
endfunction

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
" Plugin config	
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"cvim
"call s:check_compiler()

"CSApprox
"if !has("gui_running")
"	let g:CSApprox_loaded=0
"	let g:CSApprox_verbose_level=0
"endif

" taglist
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
let Tlist_WinWidth=24
"let Tlist_Auto_Open = 1
"let Tlist_Display_Prototype=1

" Latex
"let g:tex_flavor='latex'
"let g:Tex_DefaultTargetFormat='pdf'
"let Tex_CompileRule_pdf='xelatex -interaction=nonstopmode $*'

" clang-format
let g:clang_format#style_options = {
			\ "AccessModifierOffset" : -4,
			\ "AllowShortIfStatementsOnASingleLine" : "false", 
			\ "AlwaysBreakTemplateDeclarations" : "true", 
			\ "Standard" : "C++11", 
			\ "BreakBeforeBraces" : "Allman" } 

"powerline"
let g:Powerline_symbols = 'unicode'
"let g:Powerline_colorscheme = 'solarized256'

"ycm"
let g:ycm_confirm_extra_conf=0
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
nmap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>

"syntastic"
let g:syntastic_enable_signs=0
let g:syntastic_loc_list_height=5

"UltiSnips"
let g:UltiSnipsExpandTrigger = '<Leader><tab>'

"NERDTree"
let g:NERDTreeWinPos = 'right'

"Taglist"
"let Tlist_Use_Right_Window = 1
"
let g:EasyGrepMode=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom map / command
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"imap <TAB> <C-R>=AutoTab(0)<CR><C-R>=AutoSelect()<CR>
"imap <S-TAB> <C-R>=AutoTab(1)<CR><C-R>=AutoSelect()<CR>
nmap <F2> :Tlist<CR>
nmap <F4> :NERDTreeToggle<CR>
command W silent execute "w !sudo > /dev/null tee %"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autosave session
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup bb
	"	au BufWritePost *.[ch],*.[ch]pp call s:init_tag()
	"	au VimEnter *.[ch],*.[ch]pp call s:init_tag()
	"	au BufWritePost *.py,*.php,*sh silent !chmod +x %

	au FileType c,cpp call s:ft_cpp()
	au FileType python call s:ft_python()
	au FileType tex call s:ft_tex()

	au VimEnter * call s:load_session()
	au VimLeave *.[ch],*.[ch]pp call s:save_session()

	autocmd FileType c,cpp,objc nnoremap = :ClangFormat<CR>
	autocmd FileType c,cpp,objc vnoremap = :ClangFormat<CR>

	augroup end


