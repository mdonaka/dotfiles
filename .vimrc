"######### 表示設定 ###########
" 対応する括弧，ブレースを表示
set showmatch matchtime=1
" インデント幅
set shiftwidth=4
set softtabstop=4
" 行番号を表示
set number
" タイトルの表示
set title
" 自動インデント
set smartindent
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

"######### 検索設定 ###########
set ignorecase
set smartcase
set wrapscan
