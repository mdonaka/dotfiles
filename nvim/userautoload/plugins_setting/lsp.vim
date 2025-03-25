
"### coc ###

" cocの補完をtabでできるようにする
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <C-q> coc#pum#visible() ? coc#pum#scroll(0) : "\<C-q>"
inoremap <silent><expr> <C-l> coc#refresh()

" coclist
nnoremap <C-l> :CocList<CR>

" 定義ジャンプ
nmap <silent> gdj <Plug>(coc-definition)
nmap <silent> gdi :sp<CR><Plug>(coc-definition)
nmap <silent> gdI :vs<CR><Plug>(coc-definition)

" 変数名変更
nmap <silent> <C-n> <Plug>(coc-rename)
