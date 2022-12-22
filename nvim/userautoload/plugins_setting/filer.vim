
" keymap変更
function! FernInit() abort
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> H <Plug>(fern-action-hidden)

  nmap <buffer> i <Plug>(fern-action-open:below)
  nmap <buffer> I <Plug>(fern-action-open:right)
  nmap <buffer> o <Plug>(fern-action-open-or-expand)
  nmap <buffer> O <Plug>(fern-action-collapse)
  nmap <buffer> l <Plug>(fern-action-enter)
  nmap <buffer> h <Plug>(fern-action-leave)

  nmap <buffer> C <Plug>(fern-action-clipboard-copy)
  nmap <buffer> M <Plug>(fern-action-clipboard-move)
  nmap <buffer> P <Plug>(fern-action-clipboard-paste)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> - <Plug>(fern-action-mark:toggle)
  nmap <buffer> = <Plug>(fern-action-mark:clear)

  nmap <buffer> N <Plug>(fern-action-new-path=)
endfunction
augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
let g:fern#disable_default_mappings = 1

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
