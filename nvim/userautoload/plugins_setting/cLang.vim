
autocmd! FileType cpp call CppSetting()
autocmd! FileType c call CppSetting()
function! CppSetting()

  "### vim-clang-format ###
  let g:clang_exec = '/usr/bin/g++'
  let g:clang_c_options = '-std=c11'
  let g:clang_cpp_options = '-std=c++2a -pedantic-errors -fconcepts'
  let g:clang_format_auto = 1
  let g:clang_format_style = 'Google'
  let g:clang_check_syntax_auto = 1
  let g:clang_format#style_options = {
      \ "AllowShortBlocksOnASingleLine " : "Always",
      \ "UseTab" : "Never"
      \}
  ClangFormatAutoEnable

  "### QuickRun ###
  let g:quickrun_config = {
  \  'cpp':{
  \    'command': 'g++',
  \    'cmdopt': '-std=c++2a -O2 -fconcepts'
  \  }
  \}

  "### ale ###
  let g:ale_linters['cpp'] = ['g++']
  let g:ale_cpp_gcc_executable = 'g++'
  let g:ale_cpp_gcc_options = '-std=c++2a -fconcepts -Wall -I../includes'

  " ### vim-cpp-enhanced-highlight ###
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_posix_standard = 1
  let g:cpp_experimental_simple_template_highlight = 1
  let g:cpp_concepts_highlight = 1

  " ### deoplete-clang ###
  if has("mac")
    let g:deoplete#sources#clang#libclang_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
    let g:deoplete#sources#clang#clang_header='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang'
  else
    let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-10/lib/libclang-10.so.1'
    let g:deoplete#sources#clang#clang_header='/usr/include/clang'
  endif

endfunction
