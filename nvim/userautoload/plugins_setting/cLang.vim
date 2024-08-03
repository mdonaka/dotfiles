
autocmd! FileType cpp call CppSetting()
autocmd! FileType c call CppSetting()
function! CppSetting()

  "### vim-clang-format ###
  let g:clang_exec = '/usr/bin/g++-12'
  let g:clang_c_options = '-std=c11'
  let g:clang_cpp_options = '-std=c++2b -pedantic-errors -fconcepts -I /ac-library'
  let g:clang_format_auto = 1
  let g:clang_format_style = 'Google'
  let g:clang_check_syntax_auto = 1
  let g:clang_format#style_options = {
      \ "AllowShortBlocksOnASingleLine " : "Always",
      \ "UseTab" : "Never"
      \}
  ClangFormatAutoEnable

  "### ale ###
  let g:ale_linters['cpp'] = ['g++']
  let g:ale_cpp_cc_executable = 'g++-12'
  let g:ale_cpp_cc_options = '-std=c++2b -Wall -I../includes -I /ac-library'

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
    let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-14/lib/libclang-14.so.1'
    let g:deoplete#sources#clang#clang_header='/usr/include/clang'
  endif

endfunction
