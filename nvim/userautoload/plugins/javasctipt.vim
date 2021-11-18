
" ----- Javascript  -----
" javascriptのsyntax
Plug 'othree/yajs.vim', {'for': 'javascript'}

" javascriptの補完
Plug 'mattn/jscomplete-vim', {'for': 'javascript'}

" javascriptの補完
Plug 'elzr/vim-json', {'for': 'javascript'}

" vueのsyntax
" Plug 'posva/vim-vue', {'for': 'vue'}

" coffee-scriptのsyntax(他の事もできるが設定が必要)
Plug 'kchmck/vim-coffee-script'


" syntax file for typescript
Plug 'HerringtonDarkholme/yats.vim', {'for': 'typescript'}
Plug 'mhartington/nvim-typescript', {'for': 'typescript', 'do': './install.sh'}
" For async completion
Plug 'Shougo/deoplete.nvim', {'for': 'typescript'}
" For Denite features
Plug 'Shougo/denite.nvim', {'for': 'typescript'}
