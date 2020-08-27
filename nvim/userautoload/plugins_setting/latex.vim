
autocmd! FileType plaintex call LaTexSetting()
function! LaTexSetting()

	"### vimtex ###
	" vimtex
	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.tex = g:vimtex#re#neocomplete

endfunction

