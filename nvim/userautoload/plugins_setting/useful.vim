
"### nerdtree ###
" キーの設定
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" vim開始時に開く
autocmd vimenter * NERDTree


"### quickrun ###
" キーの設定
nnoremap <F5> :<C-u>QuickRun<CR> 


"### neocomplete ###
" 補完候補を呼び出すとき常にポップアップメニューを使う
set completeopt=menuone
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


"### ale ###
" 保存時に自動整形
let g:ale_fix_on_save = 1
" 常時lintのon
let g:ale_lint_on_text_changed = 1
" エディタがエラー行追加に左にずれるのを防ぐ
let g:ale_sign_column_always = 1
" linterを表示
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


"### lightline ### 
let g:lightline = {
\ 'colorscheme': 'Solarized Light',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'modified' ],
\             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ],
\ },
\ }


"### lightline-ale ###
let g:lightline.component_expand = {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\ }
let g:lightline.component_type = {
\     'linter_checking': 'left',
\     'linter_warnings': 'warning',
\     'linter_errors': 'error',
\     'linter_ok': 'left',
\ }