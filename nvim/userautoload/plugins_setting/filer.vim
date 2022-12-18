

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

" font適用
let g:fern#renderer = 'nerdfont'
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
