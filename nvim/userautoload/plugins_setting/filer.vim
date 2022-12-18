

" <C-e>で起動
nnoremap <C-e> :Fern . -reveal=% -drawer -toggle -width=27<CR>

" 起動時に開く
augroup __fern__
  au!
  autocmd VimEnter * ++nested Fern . -reveal=% -drawer -toggle -width=27
augroup END

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" pでpreview
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
endfunction

