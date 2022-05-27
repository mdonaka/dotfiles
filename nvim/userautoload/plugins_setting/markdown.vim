
autocmd! FileType markdown call MarkdownSetting()
function! MarkdownSetting()

	" 自動折りたたみの無効化
	let g:vim_markdown_folding_disabled = 1 

	" プレビューを開く
	" WSL
	let uname = substitute(system('uname'),'\n','','')
	if uname == 'Linux'
		let lines = readfile("/proc/version")
		if lines[0] =~ "Microsoft"
			let g:previm_open_cmd = 'firefox"'
		endif
	endif
	" mac
	if has("mac")
		let g:previm_open_cmd = 'open -a "Google Chrome"'
	endif

	" F5でプレビューを開く(quickrunの設定を更新しているので注意)
	nnoremap <F5> :<C-u>PrevimOpen<CR> 

	" リアルタイム更新
	let g:previm_enable_realtime = 1

endfunction
