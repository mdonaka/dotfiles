
autocmd! FileType python call PythonSetting()
function! PythonSetting()

	"### braceless ###
	" 強化indentの追加，fold機能の追加
	autocmd FileType python BracelessEnable +indent +fold

	"### ale ###
	" flake8をLinterとして登録
	let g:ale_linters['python'] = ['flake8', 'mypy']
	" 各ツールをFixerとして登録
	let g:ale_fixers['python'] = ['autopep8', 'black', 'isort']
	
	" ### deoplete-jedi ###
	" let g:deoplete#sources#jedi#python_path = '$HOME/.pyenv/shims/python3'
	let g:deoplete#sources#jedi#show_docstring = 0

endfunction
