

" ファイラ本体
Plug 'lambdalisue/fern.vim'

" git差分を表示
Plug 'lambdalisue/fern-git-status.vim'

" previewを開く
 Plug 'yuki-yano/fern-preview.vim'

 " font
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'LumaKernel/fern-mapping-fzf.vim'
