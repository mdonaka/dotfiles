
autocmd! FileType python call PythonSetting()
function! PythonSetting()

	"### braceless ###
	" 強化indentの追加，fold機能の追加
	autocmd FileType python BracelessEnable +indent +fold

	"### ale ###
	" flake8をLinterとして登録
	let g:ale_linters['python'] = ['flake8', 'mypy']
	" 各ツールをFixerとして登録
	let g:ale_fixers['python'] = ['black','autopep8' 'isort']

	"### jedi-vim ###
	" 自動で実行される初期化処理を有効
	let g:jedi#auto_initialization    = 1 
	" 'completeopt' オプションを上書きしない
	let g:jedi#auto_vim_configuration = 0
	" ドット(.)を入力したとき自動で補完する
	let g:jedi#popup_on_dot           = 1 
	" 補完候補の1番目を選択しない
	let g:jedi#popup_select_first     = 0 
	" 関数の引数表示を無効	
	let g:jedi#show_call_signatures   = 1
	" 補完エンジンはjediを使う
	autocmd FileType python setlocal omnifunc=jedi#completions

endfunction
