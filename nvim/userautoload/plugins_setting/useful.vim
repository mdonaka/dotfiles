
"### nerdtree ###
" キーの設定
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" vim開始時に開く
autocmd vimenter * NERDTree


"### quickrun ###
" キーの設定
nnoremap <F5> :<C-u>QuickRun<CR> 

"### deoplete ###
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'auto_complete_popup': 'auto',
\ 'auto_complete_delay': 0,
\ 'omni_patterns': {}
\ })
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
			\ neosnippet#expandable_or_jumpable() ?
			\    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
imap <expr><CR>
\ (pumvisible() && neosnippet#expandable()) ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"

"### snippet ###
set completeopt-=preview

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
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
\ 'colorscheme': 'solarized',
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
