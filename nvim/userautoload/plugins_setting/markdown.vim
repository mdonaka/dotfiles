
autocmd! FileType markdown call MarkdownSetting()
function! MarkdownSetting()

  " 自動折りたたみの無効化
  let g:vim_markdown_folding_disabled = 1
  set foldmethod=manual

  " プレビューを開く
  " WSL
  let uname = substitute(system('uname'),'\n','','')
  if uname == 'Linux'
    let g:previm_open_cmd = '/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
    let g:previm_wsl_mode = 1
  endif
  " mac
  if has("mac")
    let g:previm_open_cmd = 'open -a "Google Chrome"'

  endif

  " F5でプレビューを開く
  nnoremap <F5> :<C-u>PrevimOpen<CR> 

  " リアルタイム更新
  let g:previm_enable_realtime = 1

endfunction
