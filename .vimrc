""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bbchung vimrc
" Last modify at 2014-05-09
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let vundle manage plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'bbchung/chaotic'
Bundle 'bbchung/vim-clang-highlighting'
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
"Bundle 'xolox/vim-easytags'
"Bundle 'xolox/vim-misc'



"Bundle 'Conque-GDB'
"Bundle 'CSApprox'
Bundle 'taglist.vim'
"Bundle 'TagHighlight'
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
set cursorline
set conceallevel=0
set concealcursor=nc
set ls=2				" allways show status line
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
set foldlevelstart=20
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
set updatetime=1200
set hls
set nocursorline


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UndoDir
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

augroup UndoDir
	au!
	au VimEnter * call s:create_undo_folder_if_not_exist()
augroup END

fun! s:create_undo_folder_if_not_exist()
	let s:dir=$HOME."/.vimundodir"
	if !isdirectory(s:dir)
		call mkdir(s:dir, "p")
	endif
	execute "set undodir=".s:dir
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoTags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cst
set csto=1
set nocsverb

fun! s:map_for_tag()
	silent! nmap <silent><C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	silent! nmap <silent><C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	silent! nmap <silent><C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	silent! nmap <silent><C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	silent! nmap <silent><C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	silent! nmap <silent><C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	silent! nmap <silent><C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	silent! nmap <silent><C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endf

fun! s:unmap_tag()
	silent! unmap <C-\>s
	silent! unmap <C-\>g
	silent! unmap <C-\>c
	silent! unmap <C-\>t
	silent! unmap <C-\>e
	silent! unmap <C-\>f
	silent! unmap <C-\>i
	silent! unmap <C-\>d
	silent! unmap <C-\>u
endf

fun! s:add_tags_if_no_conn()
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
endf

fun! UpdateCscope()
	if cscope_connection(1, 'GTAGS')
		execute "!global -u > /dev/null 2>&1"
	elseif cscope_connection(1, 'cscope.out')
		execute "!cscope -bkqR"
		cs reset
	else
		execute "!gtags"
		set cscopeprg=gtags-cscope
		cs add GTAGS
	endif
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Project
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
	au Filetype c,cpp,objc
				\ call s:add_tags_if_no_conn() |
				\ call s:map_for_tag() |
				\ set textwidth=0 expandtab |
				\ vmap <silent>= :ClangFormat<CR> |
				\ let s:in_project=1

	au BufWritePost *.[ch],*.[ch]pp silent! call UpdateCscope()
	au FileType python set textwidth=0 expandtab
	au FileType vim set textwidth=0 expandtab
	au FileType tex set textwidth=120 noexpandtab

	au VimLeavePre * if exists('s:in_project') | call s:save_project() | endif
	au VimEnter * if argc()== 0 | call s:load_project() | endif
augroup END


"set formatprg=astyle\ -A1TCSKfpHUk3W3ynq\ --delete-empty-lines

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoTab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"imap <TAB> <C-R>=AutoTab(0)<CR><C-R>=AutoSelect()<CR>
"imap <S-TAB> <C-R>=AutoTab(1)<CR><C-R>=AutoSelect()<CR>
"
"fun! AutoTab(force)
"	if match(getline('.')[col('.')-2], '\t\|\s\|\b') == 0 || col('.') == 1 || &omnifunc == ""
"		return "\<TAB>"
"	else
"		if pumvisible() && a:force == 0
"			return ""
"		else
"			return "\<c-x>\<c-o>\<c-p>"
"		endif
"	endif
"endf

"fun! AutoSelect()
"	if pumvisible()
"		return "\<Down>"
"	else
"		return ""
"	endif
"endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SudoWrite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! W silent execute "w !sudo > /dev/null tee %"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoSession
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"fun! s:confirm_save_session()
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
"endf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: Pyclewn
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"fun! EnterDebugMode()
"	Pyclewn
"	Cmapkeys
"	nmap <C-P> :exe "Cprint " . expand("<cword>") <CR>
"	"nmap <C-D> :silent! exe "Cdbgvar " . expand("<cword>") <CR>
"	nmap <C-F7> :Cshell setsid xterm -e inferior_tty.py &<CR>
"	set nomodifiable
"	1,$foldopen!
"endf

"fun! ExitDebugMode()
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
"endf

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
"let Tlist_Use_Right_Window = 1
nmap <silent> <F2> :Tlist<CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-powerline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:Powerline_symbols = 'compatible'
"let g:Powerline_theme = 'solarized256'
let g:Powerline_colorscheme = 'solarized256'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_confirm_extra_conf=0
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
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
