set display=uhex	"未知字符使用16进制显示 
set ft=xxd		"16进制高亮
set nu
syntax on		" syntax high lighting
set hlsearch		" hight lighting search
set ruler		" right bar
set showmode		" left bar
set cursorcolumn
"set cursorline
"highlight CursorColumn cterm=NONE ctermbg=white ctermfg=green guibg=NONE guifg=NONE

""""""""""""""""""""
	"vundle config
""""""""""""""""""""
set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
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
	"Plugin 
	"Plugin " Optional:
	"Plugin Plugin 'honza/vim-snippets'
	"Plugin let g:snipMate = { 'snippet_version' : 1 }
	"Plugin let g:snips_author = 'manu2x'
"""""""""""""
	" plugin Ultisnip
"""""""""""""
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetsDir=[$HOME."/.vim/bundle/vim-snippets/UltiSnips"]
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/bundle/vim-snippets/UltiSnips"]
" 如果你希望使用 :UltiSnipsEdit 的时候可以垂直切分你的窗口来编辑
let g:UltiSnipsEditSplit="vertical"
"""""""""""""
	"plugin jedi-vim
""""""""""""""
"Plugin 'davidhalter/jedi-vim'
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
