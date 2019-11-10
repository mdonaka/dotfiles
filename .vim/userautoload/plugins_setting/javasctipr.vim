
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
