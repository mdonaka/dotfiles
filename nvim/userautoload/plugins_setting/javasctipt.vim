
autocmd! FileType javascript call JavascriptSetting()
function! JavascriptSetting()

  "##### jscomplete #####
  " 補完の開始
  setl omnifunc=jscomplete#CompleteJS
  " 補完の拡張
  let g:jscomplete_use = ['dom', 'moz', 'es6th']

  "##### ale #####
  " 補完
  let g:ale_fixers['javascript'] = ['eslint']
  " lint
  let g:ale_linters['javascript'] = ['eslint']

  "##### vim-json #####
  " 変な""を消す
  let g:vim_json_syntax_conceal = 0

endfunction


autocmd! FileType typescript call TypescriptSetting()
autocmd! FileType vue call TypescriptSetting()
function! TypescriptSetting()

  "##### ale #####
  " 補完
  let g:ale_fixers['typescript'] = ['tslint']
  " lint
  let g:ale_linters['typescript'] = ['tslint']

  "#### nvim-typescript ####
  " WSL
  let uname = substitute(system('uname'),'\n','','')
  if uname == 'Linux'
    let lines = readfile("/proc/version")
    if lines[0] =~ "Microsoft"
      let g:node_host_prog = '/usr/local/lib/node_modules/neovim/bin/cli.js'
    endif
  endif
  " mac
  if has("mac")
    let g:node_host_prog = '~/.nodebrew/current/lib/node_modules/neovim/bin/cli.js'
  endif
endfunction


autocmd! FileType vue call VueSetting()
function! VueSetting()

  "##### その他 #####
  " .vueファイルでhtml,css,jsを分けてsyntaxされるようにする
  autocmd FileType vue syntax sync fromstart

endfunction
