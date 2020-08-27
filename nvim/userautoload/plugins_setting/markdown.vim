
autocmd! FileType markdown call MarkdownSetting()
function! MarkdownSetting()

	" 自動折りたたみの無効化
	let g:vim_markdown_folding_disabled = 1 

	" プレビューをfirefoxで開く
	let g:previm_open_cmd = 'firefox'

	" F5でプレビューを開く(quickrunの設定を更新しているので注意)
	nnoremap <F5> :<C-u>PrevimOpen<CR> 

	" リアルタイム更新
	let g:previm_enable_realtime = 1

endfunction
