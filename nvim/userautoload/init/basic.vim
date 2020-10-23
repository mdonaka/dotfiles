"##### エディタ関係 #####
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
" シンタックス
syntax on
" conceal対象文字を代理文字(スペース)に置換
set conceallevel=1


"##### 検索関係 #####
" 検索結果ハイライト
set hlsearch
" 大文字小文字を無視(下記smartcaseがあるので実質小文字の時だけ無視)
set ignorecase
" 大文字のみそのまま検索
set smartcase
" 最後まで検索したら最初に戻る
set wrapscan
" 検索打ち込み中にhighlight
set incsearch


"##### 色関係 #####
" 全体の設定
function! ColorChanger(num)
	if a:num == 0
		colorscheme molokai
		let g:molokai_original=1
	elseif a:num == 1
		colorscheme wombat256grf
	elseif a:num == 2
		colorscheme miramare
	else
		colorscheme wombat256grf
	endif
endfunction
call ColorChanger(system("echo $((RANDOM%+2))"))

let g:rehash=1
" 背景の設定
set background=dark
" 対応括弧の色付け
hi MatchParen ctermfg=LightGreen ctermbg=blue


"##### その他 #####
" 新しいウインドウを右or下に開く
set splitright
set splitbelow
" カーソル位置の記憶
autocmd BufWritePost * mkview
autocmd BufReadPost * silent! loadview
set viewoptions-=options
" ヤンク <-> クリップボード
set clipboard=unnamedplus
" Python2のpath
let g:python_host_prog=expand("$HOME/.pyenv/shims/python2")
