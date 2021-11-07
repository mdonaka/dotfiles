
autocmd! FileType rust call RustSetting()
function! RustSetting()
	let g:rustfmt_autosave = 1
endfunction
