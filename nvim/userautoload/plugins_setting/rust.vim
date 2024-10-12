
autocmd! FileType rust call RustSetting()
function! RustSetting()
  let g:rustfmt_autosave = 1
  let g:LanguageClient_serverCommands = {
  \ 'rust': ['rust-analyzer'],
  \ }
  let g:ale_linters = {'rust': ['analyzer']}
endfunction
