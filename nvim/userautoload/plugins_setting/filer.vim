
" keymap変更
let g:fern#disable_default_mappings = 1
function! FernInit() abort
  nmap <buffer><silent><expr>
    \ <Plug>(fern-my-open-or-expand-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-action-open)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> H <Plug>(fern-action-hidden)

  nmap <buffer> i <Plug>(fern-action-open:below)
  nmap <buffer> I <Plug>(fern-action-open:right)
  nmap <buffer> o <Plug>(fern-my-open-or-expand-collapse)
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

  " pでpreview
  nmap <silent> <buffer> p <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> d <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> u <Plug>(fern-action-preview:scroll:up:half)

  " fzf
  nmap <buffer> ff <Plug>(fern-action-fzf-root-files)
  nmap <buffer> fd <Plug>(fern-action-fzf-root-dirs)
  nmap <buffer> fa <Plug>(fern-action-fzf-root-both)

endfunction
augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" <C-e>で起動
nnoremap <C-e> :Fern . -reveal=% -drawer -toggle -width=27<CR>

" 起動時に開く
augroup __fern__
  au!
  autocmd VimEnter * ++nested Fern . -reveal=% -drawer -toggle -width=27
augroup END

" font適用
let g:fern#renderer = 'nerdfont'
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" ディレクトリの線を追加
let g:fern#renderer#nerdfont#indent_markers = 1

" fzf
function! Fern_mapping_fzf_customize_option(spec)
    let a:spec.options .= ' --multi'
    " Note that fzf#vim#with_preview comes from fzf.vim
    if exists('*fzf#vim#with_preview')
        return fzf#vim#with_preview(a:spec)
    else
        return a:spec
    endif
endfunction

function! Fern_mapping_fzf_before_all(dict)
    if !len(a:dict.lines)
        return
    endif
    return a:dict.fern_helper.async.update_marks([])
endfunction

function! s:reveal(dict)
    execute "FernReveal -wait" a:dict.relative_path
    execute "normal \<Plug>(fern-action-mark:set)"
endfunction

let g:Fern_mapping_fzf_file_sink = function('s:reveal')
let g:Fern_mapping_fzf_dir_sink = function('s:reveal')
