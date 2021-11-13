
autocmd! FileType rust call RustSetting()
function! RustSetting()
	let g:rustfmt_autosave = 1
	let g:deoplete#sources#rust#racer_binary='~/.cargo/bin/racer'
	let g:deoplete#sources#rust#rust_source_path='/path/to/rust/src'
endfunction
