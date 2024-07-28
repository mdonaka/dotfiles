"##### エディタ関係 #####
" インデント幅
set expandtab
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
" タブ等を視覚的に分かりやすく
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
hi SpecialKey ctermbg=None ctermfg=70 guibg=NONE guifg=None

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
" vimgrepでquickfix-windowを開く
autocmd QuickFixCmdPost *grep* cwindow

"##### 色関係 #####
" 色変更の関数
let s:colorList = split(system("ls ~/.config/nvim/colors/"), "\n")
function! ColorChanger(num)
  let s:colorName = split(s:colorList[a:num], ".vim")[0]
  echo "change the color to [" . s:colorName . "]"
  exe("colorscheme " . s:colorName)
endfunction
" 起動時の色をランダム変更
let s:colorSize = system("ls -1 ~/.config/nvim/colors | wc -l")
call ColorChanger(system('echo $((RANDOM%+' . s:colorSize . '))'))

let g:rehash=1
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
" win32でクリップボード共有
let uname = substitute(system('uname'),'\n','','')
if uname == 'Linux'
  let lines = readfile("/proc/version")
  if lines[0] =~ "Microsoft"
    let g:clipboard = {
        \   'name': 'myClipboard',
        \   'copy': {
        \      '+': 'xsel -bi',
        \      '*': 'xsel -bi',
        \    },
        \   'paste': {
        \      '+': 'xsel -bo',
        \      '*': 'xsel -bo',
        \   },
        \   'cache_enabled': 1,
        \ }
  endif
endif

"#### ターミナルモード
" 下に開く
if has('nvim')
  command! -nargs=* Term split | terminal <args>
  command! -nargs=* Termv vsplit | terminal <args>
endif
" インサートモードで開く
autocmd TermOpen * startinsert
