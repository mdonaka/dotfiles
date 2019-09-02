inoremap jj <Esc>
"######### 表示設定 ###########
" カーソル位置の記憶
autocmd BufWritePost * mkview
autocmd BufReadPost * loadview
set viewoptions-=options
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
" 新しいウインドウを右に開く
set splitright

" 対応括弧の色付け
hi MatchParen ctermfg=LightGreen ctermbg=blue

" 保存終了の簡易化
nnoremap <Space>w :<C-u>write<CR> 
nnoremap <Space>q :<C-u>quit<CR> 

set conceallevel=1
"######### 検索設定 ###########
set ignorecase
set smartcase
set wrapscan
set incsearch

"######### ターミナル設定 ##########
set termkey=<A-w>
set splitbelow
tnoremap <Esc> <A-w><S-n>
set belloff=all

"######### プラグイン管理 ###########
call plug#begin('~/.vim/plugged')
" 非同期処理
Plug 'Shougo/vimproc.vim'

" ディレクトリの表示
Plug 'scrooloose/nerdtree'
" 自動補完
Plug 'Shougo/neocomplete'
" 括弧の自動補完
Plug 'cohama/lexima.vim'

" コードの実行
Plug 'thinca/vim-quickrun'

" わからない
Plug 'kana/vim-operator-user'
" C言語系のformat
Plug 'rhysd/vim-clang-format'
" C言語便利ツール
Plug 'vim-scripts/SingleCompile'
Plug 'jceb/vim-hier'

" TypeScript
" 色付け
Plug 'leafgarland/typescript-vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'jason0x43/vim-js-indent'
Plug 'posva/vim-vue'

" html
" Plug 'mattn/emmet-vim' " 改行が遅くなる
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'

" 補完
" Plug 'clausreinke/typescript-tools'

" Python
Plug 'davidhalter/jedi-vim', {'for': 'python'}
" Plug 'scrooloose/syntastic'
" Plug 'nvie/vim-flake8',{'filetypes':'python'}
Plug 'w0rp/ale'
Plug 'tell-k/vim-autopep8'
Plug 'tweekmonster/braceless.vim'

" Vim
Plug 'lervag/vimtex'

call plug#end()

"######### プラグインの設定 ###########
" clang
let g:clang_exec = '/usr/bin/g++-9'
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

" jedi-vim(python)
set completeopt=menuone                        " 補完候補を呼び出すとき常にポップアップメニューを使う
autocmd! User jedi-vim call s:jedivim_hook()   " vim-plugの遅延ロード呼び出し
function! s:jedivim_hook()              " jedi-vimを使うときだけ呼び出す処理を関数化
	let g:jedi#auto_initialization    = 1 " 自動で実行される初期化処理を有効
	let g:jedi#auto_vim_configuration = 0 " 'completeopt' オプションを上書きしない
	let g:jedi#popup_on_dot           = 1 " ドット(.)を入力したとき自動で補完する
	let g:jedi#popup_select_first     = 0 " 補完候補の1番目を選択しない
	let g:jedi#show_call_signatures   = 1 " 関数の引数表示を無効(ポップアップのバグを踏んだことがあるため)
	autocmd FileType python setlocal omnifunc=jedi#completions   " 補完エンジンはjediを使う
endfunction

" autopep8
" Shift + F でautopep自動修正
nnoremap <S-f> :call Autopep8()<CR>

" 強化indentの追加，fold機能の追加
autocmd FileType python BracelessEnable +indent +fold +highlight

" vim-vue
autocmd FileType vue syntax sync fromstart

" html
let g:user_emmet_leader_key='<c-m>'

" 自動保存
" autocmd BufWrite *.{py} :call Autopep8()

" quickrun
nnoremap <F5> :<C-u>QuickRun<CR> 

" vimtex
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex = g:vimtex#re#neocomplete

"######### C++設定 ###########
autocmd FileType cpp ClangFormatAutoEnable

