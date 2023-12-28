autocmd! FileType julia call JuliaSetting()
function! JuliaSetting()

  " 保存時に自動format
  autocmd! BufWrite *.jl :JuliaFormatterFormat

endfunction
