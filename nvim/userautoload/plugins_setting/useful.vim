
"### deoplete ###
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'auto_complete_popup': 'auto',
\ 'auto_complete_delay': 0,
\ 'omni_patterns': {}
\ })
let g:auto_complete_start_length = 1

imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : "\<CR>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

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

"### vim-commentary ###
autocmd FileType cpp,hpp setlocal commentstring=//\%s
