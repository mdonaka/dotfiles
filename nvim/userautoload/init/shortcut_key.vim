"##### ノーマルモードへの切り替え簡略化 #####
inoremap jj <Esc>
tnoremap jj <C-\><C-n>

"##### ショートカットキーの登録 #####
" window分割関係(移動，拡大縮小)
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap S< <C-w><
nnoremap S> <C-w>>
nnoremap S+ <C-w>+
nnoremap S= <C-w>-
" 保存終了の簡易化
nnoremap <Space>w :<C-u>write<CR> 
nnoremap <Space>q :<C-u>quit<CR> 
" 文末移動
nnoremap 4 <End>
vnoremap 4 <End>
" vimgrepで前へ
nnoremap [q :cprevious<CR>
" vimgrepで次へ
nnoremap ]q :cnext<CR>
