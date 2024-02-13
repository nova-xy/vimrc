
" Startup {{{
filetype indent plugin on

augroup vimrcEx
au!
"自动换行"
autocmd FileType text setlocal textwidth=78

augroup END

" 重新打开文档时光标回到文档关闭前的位置
if has("autocmd")
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line ("'\"") <= line("$") |
				\ exe "normal g'\"" |
				\ endif
endif

"新建.c,.h,.sh,.Java, .python文件，自动插入文件头
autocmd BufNewFile *.py,*.cpp,*.cc,*.[ch],*.sh,*.Java,*.go exec ":call SetTitle()"
func SetTitle()
	if &filetype == 'sh' || &filetype == 'python'
		call setline(1,"\#########################################################################")
		call append(line("."),   "\# File Name:    ".expand("%"))
		call append(line(".")+1, "\# Author:       nova")
		call append(line(".")+2, "\# Mail:         nova-xy@foamail.com")
		call append(line(".")+3, "\# Created Time: ".strftime("%c"))
		call append(line(".")+4, "\#########################################################################")
		call append(line(".")+5, "\#!/bin/bash")
		call append(line(".")+6, "")
	else
		call setline(1, "/*************************************************************************")
		call append(line("."),   "> File Name:     ".expand("%"))
		call append(line(".")+1, "> Author:        nova")
		call append(line(".")+2, "> Mail:          nova-xy@foxmail.com")
		call append(line(".")+3, "> Created Time:  ".strftime("%c"))
		call append(line(".")+4, "> Description:   ")
		call append(line(".")+5, " ************************************************************************/")
		call append(line(".")+6, "")
	endif
endfunc
autocmd BufNewFile * normal G
"新建文件后，自动定位到文件末尾
set termguicolors
syntax on:syntax enable
set ruler           " 显示标尺
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离

" vim 文件折叠方式为 marker
augroup ft_vim
    au!

    autocmd FileType vim setlocal foldmethod=marker

    " 打开文件总是定位到上次编辑的位置
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    augroup END
augroup END
" }}}

" General {{{
set nocompatible
set nobackup
""set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
" }}}
" Lang & Encoding {{{
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set termencoding=utf-8
""set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
"language messages zh_CN.UTF-8
" }}}
" GUI {{{
colorscheme Tomorrow-Night
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set cursorline
"搜索忽略大小写"
set ignorecase
set hlsearch
set number
" 窗口大小
set lines=35 columns=140
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
"不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" 使用内置 tab 样式而不是 gui
set guioptions-=e
" set nolist
""set listchars=trail:·,extends:>,precedes:<
if has("gui_running")
	set guifont=Source_Code_Pro:h16
endif
" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F\ %y%r%m%*%=before\ %{\(localtime()-getftime(expand\(\"%\"\))\)/60}min\ \ \ %{&ff}\[%{&fenc}]\ [row:%l/%L,col:%c]\ %p%%
"set statusline=%{localtime()/1000000}
" 总是显示状态行
set laststatus=2
" 设置光标形状和颜色"
" 插入模式
let &t_SI = "\<Esc>[5 q" . "\<Esc>]12;white\x7"
" 选择模式
let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;black\x7"
" 正常模式
let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;green\x7"
" 1 -> blinking block  闪烁的方块
" 2 -> solid block  不闪烁的方块
" 3 -> blinking underscore  闪烁的下划线
" 4 -> solid underscore  不闪烁的下划线
" 5 -> blinking vertical bar  闪烁的竖线
" 6 -> solid vertical bar  不闪烁的竖线
" 设置光标颜色时也可以使用 RGB 颜色，格式为 rgb:RR/GG/BB。比如纯白色的光标即为 "\<Esc>]12;rgb:FF/FF/FF\x7"

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 高亮显示匹配的括号
"set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
"set matchtime=1
" }}}

" Format {{{
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
"tab键转换为空格"
set expandtab
""set foldmethod=indent
syntax on
" }}}
" Keymap {{{
"键盘映射
inoremap jk <Esc>
inoremap ff <Esc>la
inoremap qq <Esc>i 
nmap <F9> :noh<CR>
""tnoremap <ESC> <C-\><C-n>
"""自动补全
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>

inoremap { {}<ESC>i
inoremap {<CR> {}<Esc>i<CR><Esc>koi<Esc>j<C-S-v><S-%>=j<S-$>xa

""inoremap {<CR> {<CR>}<ESC>O
inoremap } {}<Esc>i
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " <c-r>=DQuote()<CR>
inoremap ' <c-r>=SQuote()<CR>
" 将BackSpace键映射为RemovePairs函数
inoremap <BS> <c-r>=RemovePairs()<CR>
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
"自动补全双引号
func! DQuote()
	if getline('.')[col('.') - 1] == '"'
		return "\<Right>"
	else
		if getline('.')[col('.') - 2] == '"'
			return '"'
		else
			return "\"\"\<Left>"
		endif
	endif
endfunc
"自动补全单引号
func! SQuote()
	if getline('.')[col('.') - 1] == "'"
		return "\<Right>"
	else
		if getline('.')[col('.') - 2] == "'"
			return "'"
		else
			return "''\<Left>"
		endif
	endif
endfunc
" 按BackSpace键时判断当前字符和前一字符是否为括号对或一对引号，如果是则两者均删除，并保留BackSpace正常功能
func! RemovePairs()
	let l:line = getline(".") " 取得当前行
	let l:current_char = l:line[col(".")-1] " 取得当前光标字符
	let l:previous_char = l:line[col(".")-2] " 取得光标前一个字符

	if (l:previous_char == '"' || l:previous_char == "'") && l:previous_char == l:current_char
		return "\<delete>\<bs>"
	elseif index(["(", "[", "{"], l:previous_char) != -1
		" 将光标定位到前括号上并取得它的索引值
		execute "normal! h"
		let l:front_col = col(".")
		" 将光标定位到后括号上并取得它的行和索引值
		execute "normal! %"
		let l:line1 = getline(".")
		let l:back_col = col(".")
		" 将光标重新定位到前括号上
		execute "normal! %"
		" 当行相同且后括号的索引比前括号大1则匹配成功
		if l:line1 == l:line && l:back_col == l:front_col + 1
			return "\<right>\<delete>\<bs>"
		else
			return "\<right>\<bs>"
		end
	else
		return "\<bs>"
	end
endfunc


" 编译快捷键
map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()
	execute "w"
	if &filetype == 'c'
		execute 'cd %:h'
		if !isdirectory('build')
			execute "!mkdir build"
		endif
		execute '!gcc % -o build/%<'
		execute 'term ./build/%<'
	elseif &filetype == 'cpp'
		execute 'cd %:h'
		if !isdirectory('build')
			execute "!mkdir build"
		endif
		execute '!g++ % -o build/%<'
		execute 'bo term ./build/%<'
	elseif &filetype == 'python'
		execute 'cd %:h'
		execute 'term python3 %'
	elseif &filetype == 'sh'
		execute 'cd %:h'
        execute '!time bash %'
	endif
endfunc
"autocmd filetype dot nnoremap <F5> :w <bar> exec '!dot -Tsvg sqlparse.dot > sqlparse.svg'<CR>
"autocmd Filetype java nnoremap <F5> :w <bar> exec '!javac '.shellescape('%'). ' -d ./bin'<CR>
"autocmd filetype java nnoremap <F2> :w <bar> exec '!java -cp ./bin '.shellescape('%:r')<CR>

let mapleader=","
nmap <leader>s :source $MYVIMRC<cr>
nmap <leader>e :e $MYVIMRC<cr>
nmap <leader>tn :tabnew<cr>
nmap <leader>tc :tabclose<cr>
nmap <leader>th :tabp<cr>
nmap <leader>tl :tabn<cr>
" 移动分割窗口
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>
" 插入模式移动光标 alt + 方向键
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
" IDE like delete
inoremap <C-BS> <Esc>bdei
nnoremap vv ^vg_
" 转换当前行为大写
inoremap <C-u> <esc>mzgUiw`za
" 命令模式下的行首尾
cnoremap <C-a> <home>
cnoremap <C-e> <end>
nnoremap <F2> :setlocal number!<cr>
nnoremap <leader>w :set wrap!<cr>
imap <C-v> "+gP
vmap <C-c> "+y
vnoremap <BS> d
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
imap <C-V> "+gP
map <S-Insert> "+gP
cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
" 打开当前目录 windows
nmap <silent> <leader>ex :!start explorer %:p:h<CR>
" 打开当前目录CMD
nmap <silent> <leader>cmd :!start cmd /k cd %:p:h<cr>
" 打印当前时间
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
let NERDTreeBookmarksFile = $VIM . '/NERDTreeBookmarks'
" 复制当前文件/路径到剪贴板
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
"设置切换Buffer快捷键"
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
" }}}


" Plugin {{{
filetype off
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin('$VIM/vimfiles/bundle')
" ----- Vundle ----- {{{
Plugin 'VundleVim/Vundle.vim'
" }}}
" ----- NerdTree ----- {{{
Plugin 'scrooloose/nerdtree'
let NERDTreeIgnore=['.idea', '.vscode', 'node_modules', '*.pyc']
let NERDTreeBookmarksFile = $VIM . '/NERDTreeBookmarks'
let NERDTreeMinimalUI = 1
let NERDTreeBookmarksSort = 1
let NERDTreeShowLineNumbers = 0
let NERDTreeShowBookmarks = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nmap <leader>n :NERDTreeToggle <cr>
if exists('g:NERDTreeWinPos')
    autocmd vimenter * NERDTree D:\repo
endif
" }}}
" ----- Multiple-cursors ----- {{{
Plugin 'terryma/vim-multiple-cursors'
" }}}
" ----- Tabular ----- {{{
Plugin 'godlygeek/tabular'
" }}}
" ----- Markdown ----- {{{
Plugin 'plasticboy/vim-markdown'
" }}}
" ----- Airline ----- {{{
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"set laststatus=2
"if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
"endif
"let g:airline_theme='tomorrow'
"let g:airline_powerline_fonts = 1
"let g:Powerline_symbols='fancy'
" let g:airline_symbols.branch = ''
" let g:airline_left_sep = '»'
" let g:airline_right_sep = '«'
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
" let g:airline_mode_map = {
" \ 'n'  : 'N',
" \ 'i'  : 'I',
" \ 'v'  : 'V',
" \ }
" let g:airline#extensions#tabline#enabled = 1
" }}}
" ----- Ctrlp ----- {{{
Plugin 'kien/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
set wildignore+=*\\.git\\*,*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc
" }}}
" ----- Nerdcommenter ----- {{{
Plugin 'scrooloose/nerdcommenter'
" }}}
" ----- Emmet ----- {{{
Plugin 'mattn/emmet-vim'
" }}}
" ----- SnipMate ----- {{{
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Replace your repo
Plugin 'keelii/vim-snippets'
" Allow for vimrc re-sourcing
let g:snipMate = get(g:, 'snipMate', {})
" }}}
" ----- Fugitive ----- {{{
Plugin 'tpope/vim-fugitive'
" }}}
" ----- Neocomplete ----- {{{
Plugin 'Shougo/neocomplete.vim'
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory=$VIM . '/vimfiles/bundle/vim-snippets/snippets'
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" }}}
filetype on
call vundle#end()
" }}}


" Function {{{
" Remove trailing whitespace when writing a buffer, but not for diff files.
" From: Vigil
" @see http://blog.bs2.to/post/EdwardLee/17961
function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
" }}}


" Plugin {{{

" 定义插件管理器
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" ----- NerdTree ----- {{{
Plug 'scrooloose/nerdtree'

let NERDTreeIgnore=['.idea', '.vscode', 'node_modules', '*.pyc']
let NERDTreeBookmarksFile = $HOME . '/.vim/NERDTreeBookmarks'
let NERDTreeMinimalUI = 1
let NERDTreeBookmarksSort = 1
let NERDTreeShowLineNumbers = 0
let NERDTreeShowBookmarks = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <leader>n :NERDTreeToggle<CR>
if exists('g:NERDTreeWinPos')
    autocmd vimenter * NERDTree D:\repo
endif
" }}}

" ----- Multiple-cursors ----- {{{
Plug 'terryma/vim-multiple-cursors'
" }}}

" ----- Tabular ----- {{{
Plug 'godlygeek/tabular'
" }}}

" ----- Markdown ----- {{{
Plug 'plasticboy/vim-markdown'
" }}}

" ----- Airline ----- {{{
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"set laststatus=2

"if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
"endif
"let g:airline_theme='tomorrow'
"let g:airline_powerline_fonts = 1
"let g:Powerline_symbols='fancy'
" let g:airline_symbols.branch = ''
" let g:airline_left_sep = '»'
" let g:airline_right_sep = '«'
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
" let g:airline_mode_map = {
" \ 'n'  : 'N',
" \ 'i'  : 'I',
" \ 'v'  : 'V',
" \ }
" let g:airline#extensions#tabline#enabled = 1
" }}}

" ----- Ctrlp ----- {{{
Plug 'kien/ctrlp.vim'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
set wildignore+=*\\.git\\*,*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc
" }}}

" ----- Nerdcommenter ----- {{{
Plug 'scrooloose/nerdcommenter'
" }}}

" ----- Emmet ----- {{{
Plug 'mattn/emmet-vim'
" }}}

" ----- SnipMate ----- {{{
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
" Replace your repo
Plug 'keelii/vim-snippets'
" Allow for vimrc re-sourcing
let g:snipMate = get(g:, 'snipMate', {})
" }}}

" ----- Fugitive ----- {{{
Plug 'tpope/vim-fugitive'
" }}}

" ----- Neocomplete ----- {{{
Plug 'Shougo/neocomplete.vim'
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
""let g:neosnippet#snippets_directory=$HOME . '/.vim/bundle/vim-snippets/snippets'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" }}}

"filetype indent on
"syntax on

" 定义插件管理器结束
call plug#end()
" }}}

" }}}
" 移除尾部空白
function! RemoveTrailingWhitespace()
    if &ft != "diff"
        let b:curcol = col(".")
        let b:curline = line(".")
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()
" }}}
