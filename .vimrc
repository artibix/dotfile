set background=dark "light
set t_Co=256
let g:solarized_termcolors=256
 colorscheme solarized
"colorscheme shine
"https://github.com/tomasr/molokai/blob/master/colors/molokai.vim
"colorscheme molokai 
set display=uhex	    "未知字符使用16进制显示 
set ft=xxd		        "16进制高亮
set nu
syntax on		        " syntax high lighting
set hlsearch		    " hight lighting search
set ruler		        " right5 bar
set showmode		    " left bar
set relativenumber
set cursorline 
highlight CursorLine cterm=NONE ctermbg=grey ctermfg=NONE guibg=NONE guifg=NONE
set expandtab
set shiftwidth=4
set autoindent
set tabstop=4
set softtabstop=4
set showmatch
set autoread

"set cursorcolumn
"highlight CursorColumn cterm=NONE ctermbg=white ctermfg=green guibg=NONE guifg=NONE

set foldmethod=manual "set default foldmethod
	"manual           	手工定义折叠
	"indent             	更多的缩进表示更高级别的折叠
	"expr               	用表达式来定义折叠
	"syntax             	用语法高亮来定义折叠
	"diff                  	对没有更改的文本进行折叠
	"marker            	对文中的标志折叠

""""""""""""""""""""
	"vundle config
""""""""""""""""""""

	set nocompatible              " 去除VI一致性,必须
	filetype off                  " 必须
	
	" 设置包括vundle和初始化相关的runtime path
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	"call vundle#begin('~/some/path/here')
	
	Plugin 'VundleVim/Vundle.vim'
	
	" 以下范例用来支持不同格式的插件安装.
	" 请将安装插件的命令放在vundle#begin和vundle#end之间.
	" Github上的插件
	" 格式为 Plugin '用户名/插件仓库名'
	" Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
	" 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
	" 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
	" 插件在仓库的子目录中.
	" 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下

""""""""""""""
	"plugin snipmate：已弃用，使用Ultisnip
""""""""""""
 	"Plugin 'MarcWeber/vim-addon-mw-utils'
	"Plugin Plugin 'tomtom/tlib_vim'
	"Plugin Plugin 'garbas/vim-snipmate'
	"Plugin Plugin 'honza/vim-snippets'
	"Plugin let g:snipMate = { 'snippet_version' : 1 }
	"Plugin let g:snips_author = 'manu2x'
""""""""""""
    " auto-format
""""""""""""
    
    Plugin 'Chiel92/vim-autoformat'

""""""""""""
	" plugin nerdtree
""""""""""""

	Plugin 'preservim/nerdtree'
	Plugin 'Xuyuanp/nerdtree-git-plugin'
	Plugin 'junegunn/fzf'
	Plugin 'junegunn/fzf.vim'

""""""""""""
    " vim-colors-solarized
""""""""""""
    let g:solarized_termcolors=256
    Plugin 'altercation/vim-colors-solarized'

""""""""""""
	"plugin airline
""""""""""""

	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'airblade/vim-gitgutter'

	let g:airline#extensions#tabline#enabled = 1
	let g:airline_theme='luna'

"""""""""""""
	" plugin Ultisnip
"""""""""""""

	Plugin 'SirVer/ultisnips'
	Plugin 'honza/vim-snippets'
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<c-b>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"
	let g:UltiSnipsListSnippets="<c-l>"
	let g:UltiSnipsUsePythonVersion = 3
	let g:UltiSnipsSnippetsDir=[$HOME."/.vim/bundle/vim-snippets/UltiSnips"]
	let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/bundle/vim-snippets/UltiSnips"]
	" 如果你希望使用 :UltiSnipsEdit 的时候可以垂直切分你的窗口来编辑
	let g:UltiSnipsEditSplit="vertical"

"""""""""""""
	"plugin YCM
""""""""""""

	Plugin 'ycm-core/YouCompleteMe'
	"<C-j>, <Down>, <C-n>, <Tab>- 选择下一项
	"<C-k>, <Up>, <C-p>, <S-Tab>- 选择上一项
	"<PageUp>, <kPageUp>- 跳上一屏项目
	"<PageDown>, <kPageDown>- 跳下一屏项目
	"<Home>, <kHome>- 跳转到第一项
	"<End>, <kEnd>- 跳到最后一项
	"<CR> - 跳转到所选项目
	"<C-c> 取消/关闭弹出窗口
""""""""""""
	" 解决YCM和Ultisnips热键冲突
""""""""""""
	function! g:UltiSnips_Complete()
	  call UltiSnips#ExpandSnippet()
	  if g:ulti_expand_res == 0
	    if pumvisible()
	      return "\<C-n>"
	    else
	      call UltiSnips#JumpForwards()
	      if g:ulti_jump_forwards_res == 0
	        return "\<TAB>"
	      endif
	    endif
	  endif
	  return ""
	endfunction
	
	function! g:UltiSnips_Reverse()
	  call UltiSnips#JumpBackwards()
	  if g:ulti_jump_backwards_res == 0
	    return "\<C-P>"
	  endif
	
	  return ""
	endfunction
	
	
	if !exists("g:UltiSnipsJumpForwardTrigger")
	  let g:UltiSnipsJumpForwardTrigger = "<tab>"
	endif
	if !exists("g:UltiSnipsJumpBackwardTrigger")
	  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	endif
	
	au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
	au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
	
""""""""""""""""""""""
	"Vundle end
""""""""""""""""""""""

	call vundle#end()            " 必须
	filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
	" 忽视插件改变缩进,可以使用以下替代:
	filetype plugin on
	"
	" 简要帮助文档
	" :PluginList       - 列出所有已配置的插件
	" :PluginInstall    - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
	" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
	" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
	"
	" 查阅 :h vundle 获取更多细节和wiki以及FAQ
	" 将你自己对非插件片段放在这行之后
	
""""""""""""""""""""""
    "Quickly Run
""""""""""""""""""""""
	map <F5> :call CompileRunGcc()<CR>
	func! CompileRunGcc()
	        exec "w"
	if &filetype == 'c'
	            exec "!g++ % -o %<"
	            exec "!time ./%<"
	elseif &filetype == 'cpp'
	            exec "!g++ % -o %<"
	            exec "!time ./%<"
	elseif &filetype == 'java'
	            exec "!javac %"
	            exec "!time java %<"
	elseif &filetype == 'sh'
	            :!time bash %
	elseif &filetype == 'python'
	            exec "!time python2.7 %"
	elseif &filetype == 'html'
	            exec "!firefox % &"
	elseif &filetype == 'go'
	            exec "!time go run %"
	elseif &filetype == 'mkd'
	            exec "!~/.vim/markdown.pl % > %.html &"
	            exec "!firefox %.html &"
	endif
	    endfunc
"""""""""""""""""""
"my shortkey
"""""""""""""""""""

	"alt+上下箭头移动块
	"nmap <M-k> ddP
	"nmap <M-j> ddp

	""""""""
	" all
	""""""""
	noremap <space> :
	noremap H ^
	noremap L $

	""""""""
	" insert
	""""""""
	inoremap <C-j> <down>
	inoremap <C-k> <up>
	inoremap <C-a> <Home>
	inoremap <C-e> <End>

	inoremap jk <ESC>

	""""""""
	" normal
	""""""""
	nnoremap gu gU
	nnoremap gl gu

	""""""""
	" command
	""""""""
	cmap su w !sudo tee >/dev/null %
	cnoremap <C-j> <Down>
	cnoremap <C-k> <Up>
	cnoremap <C-a> <Home>
	cnoremap <C-e> <End>
