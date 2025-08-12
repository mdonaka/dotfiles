
" initial setup for Copilot Chat in Neovim
lua << EOF
require("CopilotChat").setup()
EOF

" Bufferを使って Copilot とチャットする
function! CopilotChatBuffer() abort
  let l:input = input('Quick Chat: ')
  if !empty(l:input)
    call luaeval('require("CopilotChat").ask(_A[1], { selection = require("CopilotChat.select").buffer })', [l:input])
  endif
endfunction


" Copilot Chatを開く
nnoremap <silent> <leader>cc :lua require("CopilotChat").open()<CR>
" buffer付きで Copilot Chatを開く
nnoremap <silent> <leader>cq :call CopilotChatBuffer()<CR>
" 選択範囲をCopilot Chatでリファクタリング
xnoremap <silent> <leader>cr :<C-u>lua require("CopilotChat").ask("このコードをリファクタリングしてください", { selection = require("CopilotChat.select").visual })<CR>
" 選択範囲をCopilot Chatでリファクタリング
xnoremap <silent> <leader>cr :<C-u>lua require("CopilotChat").ask("このコードをリファクタリングしてください", { selection = require("CopilotChat.select").visual })<CR>
" 選択範囲をCopilot Chatで修正
xnoremap <silent> <leader>cf :<C-u>lua require("CopilotChat").ask("このコードを修正してください", { selection = require("CopilotChat.select").visual })<CR>
" git diffからcommit messageを生成
nnoremap <silent> <leader>cm :lua require("CopilotChat").ask("このgit diffからcommit messageを生成してください．\ncommit messageは英語で簡潔に書いてください．\n ex1) add --- \n ex2) remove --- \n" .. table.concat(vim.fn.systemlist('git diff'), '\n'))<CR>
