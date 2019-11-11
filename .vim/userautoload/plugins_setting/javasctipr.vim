
autocmd! FileType javascript call JavascriptSetting()
function! JavascriptSetting()

	"##### jscomplete #####
	" 補完の開始
	setl omnifunc=jscomplete#CompleteJS
	" 補完の拡張
	let g:jscomplete_use = ['dom', 'moz', 'es6th']

	"##### ale #####
	" 常時lintのoff
	let g:ale_lint_on_text_changed = 1
	" 補完
	let g:ale_fixers['javascript'] = ['eslint']
	" lint
	let g:ale_linters['javascript'] = ['eslint']

endfunction


autocmd! FileType typescript call TypescriptSetting()
autocmd! FileType vue call TypescriptSetting()
function! TypescriptSetting()

	"### vim-js-indent ###
	" typescriptのインデントをいい感じにする
	let g:js_indent_typescript = 1

endfunction


autocmd! FileType vue call VueSetting()
function! VueSetting()

	"##### その他 #####
	" .vueファイルでhtml,css,jsを分けてsyntaxされるようにする
	autocmd FileType vue syntax sync fromstart

endfunction
