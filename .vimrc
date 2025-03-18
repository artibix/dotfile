set enc=utf-8
set background=dark "light
set t_Co=256
set display=uhex		"未知字符使用16进制显示
set ft=xxd				"16进制高亮
set nu
syntax on				" syntax highlighting
set hlsearch			" highlight search
set ruler				" right bar
set showmode			" left bar
set relativenumber
set cursorline
set expandtab
set shiftwidth=4
set smartindent
set tabstop=4
set softtabstop=4
set showmatch
set autoread

""""""""""""
" my autocmd
""""""""""""
autocmd BufReadPost * normal! g`"  "跳转以前编辑位置"