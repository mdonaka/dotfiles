
autocmd! FileType html call HTMLSetting()
autocmd! FileType vue call HTMLSetting()
function! HTMLSetting()

endfunction


autocmd! FileType css call CSSSetting()
autocmd! FileType vue call CSSSetting()
function! CSSSetting()

endfunction


autocmd! FileType scss call SCSSSetting()
function! SCSSSetting()

endfunction
