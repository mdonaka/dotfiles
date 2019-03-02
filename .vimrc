inoremap jj <Esc>
"######### 表示設定 ###########
" カーソル位置の記憶
au BufWritePost * mkview
autocmd BufReadPost * loadview
" インデント幅
set tabstop=2
set shiftwidth=2
set softtabstop=2
" 対応する括弧，ブレースを表示
set showmatch matchtime=1
" 自動インデント
set smartindent
" 行番号を表示
set number
" タイトルの表示
set title
" 行末まで表示する
set display=lastline
" 補完の最大高さ
set pumheight=10
" カーソル位置の表示
set ruler
" 検索結果ハイライト
set hlsearch
" シンタックス
syntax on
" 色の設定
colorscheme molokai
let g:molokai_original=1
let g:rehash=1
set background=dark
" window分割キーショートカット
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap S< <C-w><
nnoremap S> <C-w>>
nnoremap S+ <C-w>+
nnoremap S= <C-w>-

"######### 検索設定 ###########
set ignorecase
set smartcase
set wrapscan

"######### ターミナル設定 ##########
set termkey=<A-w>
set splitbelow
tnoremap <Esc> <A-w><S-n>

"######### プラグイン管理 ###########
call plug#begin('~/.vim/plugged')

" ディレクトリの表示
Plug 'scrooloose/nerdtree'
" 自動補完
Plug 'Shougo/neocomplete'
" 括弧の自動補完
Plug 'cohama/lexima.vim'

" わからない
Plug 'kana/vim-operator-user'
" C言語系のformat
Plug 'rhysd/vim-clang-format'
" C言語系の自動補完
Plug 'justmao945/vim-clang'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/neoinclude.vim'
" C言語便利ツール
Plug 'vim-scripts/SingleCompile'
Plug 'jceb/vim-hier'

" TypeScript
" 色付け
Plug 'leafgarland/typescript-vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'jason0x43/vim-js-indent'
" 補完
" Plug 'clausreinke/typescript-tools'

call plug#end()

"######### プラグインの設定 ###########
" clang
let g:clang_exec = 'clang++'
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++1z -pedantic-errors'
let g:clang_format_auto = 1
let g:clang_format_style = 'Google'
let g:clang_check_syntax_auto = 1

" vim-hier
" エラーを赤字の波線で
execute "highlight qf_error_ucurl gui=undercurl guisp=Red"
let g:hier_highlight_group_qf  = "qf_error_ucurl"
" 警告を青字の波線で
execute "highlight qf_warning_ucurl gui=undercurl guisp=Blue"
let g:hier_highlight_group_qfw = "qf_warning_ucurl"

" nerdtree
" キー設定
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" 開き方
autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" vim-js-indent
" indentの設定
let g:js_indent_typescript = 1
"######### C++設定 ###########
autocmd FileType cpp ClangFormatAutoEnable

