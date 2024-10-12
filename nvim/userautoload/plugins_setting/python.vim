
autocmd! FileType python call PythonSetting()
function! PythonSetting()

  "### braceless ###
  " 強化indentの追加，fold機能の追加
  autocmd FileType python BracelessEnable +indent +fold

endfunction
