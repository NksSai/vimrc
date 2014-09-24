"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一般设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设定默认解码
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936,big5
set enc=utf-8
let &termencoding=&encoding



" 不要使用vi的键盘模式，而是vim自己的
set nocompatible

" history文件中需要记录的行数
set history=100

" 显示行号
set number

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 与windows共享剪贴板
set clipboard+=unnamed

" 侦测文件类型
filetype on

"取消光标闪烁
set gcr=a:block-blinkon0

" 载入文件类型插件
filetype plugin on

"折叠，默认折叠方式按缩进折叠
:nnoremap <space> za

" 为特定文件类型载入相关缩进文件
filetype indent on

" 保存全局变量
set viminfo+=!

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 语法高亮
syntax on

" 每次切换缓冲时，自动保存
""set autowrite

" CTRL_J CTRL_K 时保存文件
""nmap <c-j> :w<CR>
""imap <c-k> <esc>:w<CR>a

" 高亮字符，让其不受100列限制
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%101v.*'

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White
"highlight Corsur guifg=Gray guibg=Black


" 字符间插入的像素行数目
set linespace=0

" 增强模式中的命令行自动完成操作
set wildmenu

" 在状态行上显示光标所在位置的行号和列号
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=1

" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2

" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" 不让vim发出讨厌的滴滴声
set noerrorbells
if has('autocmd')
    autocmd GUIEnter * set vb t_vb=
endif
"No bell settings End }}}

"在屏幕最后一行显示 (部分的) 命令
set showcmd

"在每个tab上显示编号
set guitablabel=%{tabpagenr()}.%t\ %m

set autoread                " 自动重新加载外部修改内容
set autochdir               " 自动切换当前目录为当前文件所在的目录

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索和匹配
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 高亮显示匹配的括号
set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 在搜索的时候忽略大小写
set ignorecase

" 不要高亮被搜索的句子（phrases）
set nohlsearch

" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

" 输入:set list命令是应该显示些啥？
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" 光标移动到buffer的顶部和底部时保持10行距离
set scrolloff=10

" 不要闪烁
set novisualbell

" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" 总是显示状态行
set laststatus=2

""""""""""""""""""""""""""""""
" 文件阅览
"''"""""""""""""""""""""""""
 let g:netrw_winsize = 30
 nmap <silent> <leader>fe :Sexplore!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文本格式和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"缩进相关

" ambiwidth 默认值为 single。在其值为 single 时，
" 若 encoding 为 utf-8，gvim 显示全角符号时就会
" 出问题，会当作半角显示。
set ambiwidth=double

function! GnuIndent()
   " setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=2
    setlocal tabstop=4
endfunction

function! MyIndent()
    setlocal cinoptions=:0,g0,(0,w1,t0
    setlocal shiftwidth=8
    setlocal tabstop=8
    setlocal softtabstop=8
    setlocal smartindent
endfunction

au FileType c,cpp call MyIndent()
au FileType diff  setlocal shiftwidth=4 tabstop=4
au FileType html  setlocal autoindent indentexpr=
au FileType changelog setlocal textwidth=76

" Recognize standard C++ headers
au BufEnter /usr/include/c++/*    setf cpp
au BufEnter /usr/include/qt/*	setf cpp
au BufEnter /usr/include/qwt/*	setf cpp
au BufEnter ~/tags/stl/* setf cpp

au BufEnter *.cpp setf cpp
au BufEnter *.cxx setf cpp
au BufEnter *.hpp setf cpp
au BufEnter *.c++ setf cpp
au BufEnter *.cc setf cpp
au BufEnter *.h setf cpp
au BufEnter *.c setf c
au BufEnter *.tex setf tex


function! RemoveTrailingSpace()
    if $VIM_HATE_SPACE_ERRORS != '0' &&
                \(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'vim')
        normal m`
        silent! :%s/\s\+$//e
        normal ``
   endif
endfunction
" Remove trailing spaces for C/C++ and Vim files
au BufWritePre *                  call RemoveTrailingSpace()

" 自动格式化
set formatoptions=tcrqn

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

" 为C程序提供自动缩进
set smartindent

" 使用C样式的缩进
set cindent

" 制表符为4
set tabstop=4

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

" 要用空格代替制表符
set noexpandtab

" 在行和段开始处使用制表符
set smarttab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 只在下列文件类型被侦测到的时候显示行号，普通文本文件不显示

if has("autocmd")
    autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
	autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>-->
    autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>*/
    autocmd FileType c,cpp,cs source ~/.vim/cpp/project.vim
""    autocmd BufEnter *.tex source ~/.vim/tex/project.vim
    autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=76
    autocmd Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
endif " has("autocmd")

" 能够漂亮地显示.NFO文件
set encoding=utf-8
function! SetFileEncodings(encodings)
    let b:myfileencodingsbak=&fileencodings
    let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
    let &fileencodings=b:myfileencodingsbak
    unlet b:myfileencodingsbak
endfunction

au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt

"Gui action mapping
nnoremap <F7> :set guioptions+=m<CR>
nnoremap <C-F7> :set guioptions-=m<CR>

"字典完成
"set  dictionary+=/usr/share/dict/words

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Keybinding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 双反斜杠\\即可打开bufexplorer
map <leader><leader> \be

nnoremap <silent> <F4> :tabprevious<CR>

:set cscopequickfix=s-,c-,d-,i-,t-,e-
nnoremap <silent> <F3> :Grep<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""
"" 怎样才能把它弄得跟 eclipse 一样智能呢？一路回车
"" 就可以跳出括号

"":inoremap ( ()<ESC>i
"":inoremap ) <c-r>=ClosePair(')')<CR>
"":inoremap { {<cr>}<ESC>O
"":inoremap } <c-r>=ClosePair('}')<CR>
"":inoremap [ []<ESC>i
"":inoremap ] <c-r>=ClosePair(']')<CR>
"":inoremap " ""<ESC>i
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

" mapping
" 如果下拉菜单弹出，回车映射为接受当前所选项目，否则，仍映射为回车；
"
" 如果下拉菜单弹出，CTRL-J映射为在下拉菜单中向下。否则映射为CTRL-X CTRL-O；
"
" 如果下拉菜单弹出，CTRL-K映射为在下拉菜单中向上，否则仍映射为CTRL-K；
"
" 如果下拉菜单弹出，CTRL-U映射为CTRL-E，即停止补全，否则，仍映射为CTRL-U；

inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
:inoremap <expr> <C-n>      pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X><C-O>"
:inoremap <expr> <C-K>      pumvisible()?"\<PageDown>\<C-P>\<C-N>":"\<C-K>"

:inoremap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"a

"在有弹出菜单的情况下
:inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
:inoremap <expr> <c-j> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
:inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

"加上日期 对应F2
"":map <F2> <ESC>gg:read !date<CR>

"选中一段文字并全文搜索这段文字
:vnoremap <silent> ,/ y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
:vnoremap <silent> ,? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"查找选中文本
"vnoremap <c-s> "zy/<c-r>=substitute(escape(@z,'[]*.\\/'),'\n', '\\n', 'g')<cr><cr><cr>

"Super paste
"inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

let g:bufExplorerSortBy = "name"
"""""""""""""""""""""""""""""""""""""""""
"TextMate-Like
"""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/textmateOnly/
set runtimepath+=~/.vim/textmateOnly/after/

""""autocmd BufEnter *.tex
""         \ if 1 == line('$') && empty(getline(1)) |
         ""\   if has('gui_running')      |
 ""        \      0r ~/.vim/tex/xetex.template |
 ""        \   else            |
 ""        \      0r ~/.vim/tex/xetex.template |
 ""        \   endif   |
 ""        \   normal G |
         ""\ endif

autocmd BufEnter resume.tex
         \ if 1 == line('$') && empty(getline(1)) |
         \   if has('gui_running')      |
         \      0r ~/.vim/tex/resume.tex |
         \   else            |
         \      0r ~/.vim/tex/resume.tex |
         \   endif   |
         \   normal G |
         \ endif

"查找包含符合特定模式的字符串的行数
function! MyCountMatchLine(MyRegMatch) range
   let matchCount = 0
   for LineNum in range(a:firstline,a:lastline)
      let LineContent = getline(LineNum)
      if LineContent =~ a:MyRegMatch
         let matchCount += 1
      endif
   endfor
   echo matchCount
endfunction

"查找符合特定模式的字符串的个数
function! MyCountPattern(MyRegMatch) range
   let matchCount = 0
   for LineNum in range(a:firstline,a:lastline)
      let LineContent = getline(LineNum)
      let MyLineTmp = substitute(LineContent, a:MyRegMatch, '', 'g')
      let matchCount -= strlen(substitute(MyLineTmp, "[^@]", '', 'g'))
      let MyLineTmp = substitute(LineContent, a:MyRegMatch, '@', 'g')
      let matchCount += strlen(substitute(MyLineTmp, "[^@]", '', 'g'))
   endfor
   echomsg matchCount
endfunction

" paste
set pastetoggle=<leader>p


"vim wiki viki
" Viki
autocmd! BufRead,BufNewFile *.viki set filetype=viki
let g:vimwiki_list = [{ 'path':'~/viki/',
			\'template_path':'~/viki/template/',
			\'template_default':'default_template',
			\'template_ext':'.html',
			\'path_html':'~/viki/html/'}]


""autocmd filetype python set complete+=k~/.vim/pydiction/pydiction
""autocmd FileType python set omnifunc=pythoncomplete#Complete
""autocmd filetype python inoremap <f2> <c-n>
autocmd filetype go compiler go


" configure tags - add additional tags here or comment out not-used ones
	set tags+=~/.vim/tags/cpp,./tags,../tags,/home/freedom/.vim/tags/tags
	" build tags of your own project with F12
	map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .;cscope -Rkbq<CR>
	let OmniCpp_ShowPrototypeInAbbr = 1
	let OmniCpp_DefaultNamespaces = [ "std" ]
	set nocp
	set tags+=/home/freedom/codes/tag/tags
	"au BufWritePost *.c,*.cpp,*.cc,*.h !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
	" OmniCppComplete
	let OmniCpp_NamespaceSearch = 1
	let OmniCpp_GlobalScopeSearch = 1
	let OmniCpp_ShowAccess = 1
	let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
	let OmniCpp_MayCompleteDot = 1 " autocomplete after .
	let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
	let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
	let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"	 automatically open and close the popup menu  preview window
	au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
	set completeopt=menuone,menu,longest,preview


"模板
let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
au BufRead,BufNewFile *.txt setlocal ft=txt
au BufRead,BufRead *.t2t set ft=txt2tags
:nmap <silent> <F8> <ESC>:Tlist<RETURN>
:noremap <silent> <F5> <ESC>:TlistUpdate<RETURN>


"目录列表 映射到了 \e 和F9
nmap    <leader>e  :NERDTreeToggle<CR>
nmap <silent> <F9> <ESC>:NERDTreeToggle<RETURN>

" MAKE IT EASY TO UPDATE/RELOAD _vimrc
:nmap ,s :source $HOME/.vimrc
:nmap ,v :e $HOME/.vimrc


" make 设定，vim 的 quickfix 模式
autocmd FileType c,cpp  map <buffer> <leader><space> :w<cr>:make<cr><cr> :cw<cr>
nmap = :cnext<cr>
nmap + :cprev<cr>

autocmd filetype html,htmldjango,sh,python,tex,make,erlang :inoremap { {}<ESC>ha
autocmd filetype html,htmldjango,sh,python,tex,make,erlang :inoremap } <c-r>=ClosePair('}')<CR>
autocmd filetype python :inoremap <c-p> <c-x><c-u>
autocmd FileType java :inoremap . .<c-x><c-u>

""自动载入模板
let g:enable_template = 1
let g:template_dir = "~/.vim/templates"

let g:pydiction_location = '/home/freedom/.vim/pydiction/complete-dict'

"ctrl + l 跳出括号
:inoremap<c-l> <esc>l%%a
:inoremap<c-k> <esc>lva"A


"for taglist"
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 0
nmap <leader>t :TlistToggle<CR>

""au FileType python set ft=python.django


""for winManager
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1
let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function;m:member'
autocmd filetype javascript :inoremap <c-o> <c-x><c-o>


""vimwiki
let g:vimwiki_use_mouse = 1
let g:vimwiki_list=[{'path':'~/Dropbox/vimwiki/','path_html':'~/Dropbox/vimwiki/html/','html_header':'~/Dropbox/vimwiki/template/header.tpl',}]
autocmd filetype vimwiki :inoremap <c-r> <c-r>=strftime("%d-%m-%y")<cr>

""lisp
let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \" clisp -i ~/.vim/slime/start-swank.lisp\""'

