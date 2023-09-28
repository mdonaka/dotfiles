
autocmd! FileType rust call RustSetting()
function! RustSetting()
  let g:rustfmt_autosave = 1
  let g:LanguageClient_serverCommands = {
  \ 'rust': ['rust-analyzer'],
  \ }
  let g:ale_linters = {'rust': ['analyzer']}

  " cocの補完をtabでできるようにする
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <C-q> coc#pum#visible() ? coc#pum#scroll(0) : "\<C-q>"

  " depleteと競合するのでoffにする
  call deoplete#custom#option({
  \ 'auto_complete_popup': 'manual',
  \ })
endfunction
