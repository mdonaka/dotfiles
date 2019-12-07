
autocmd! FileType cpp call CppSetting()
autocmd! FileType c call CppSetting()
function! CppSetting()

	"### vim-clang-format ###
	let g:clang_exec = '/usr/bin/g++-9'
	let g:clang_c_options = '-std=c11'
	let g:clang_cpp_options = '-std=c++1z -pedantic-errors'
	let g:clang_format_auto = 1
	let g:clang_format_style = 'Google'
	let g:clang_check_syntax_auto = 1
	ClangFormatAutoEnable


	"### vim-hier ###
	" エラーを赤字の波線で
	execute "highlight qf_error_ucurl gui=undercurl guisp=Red"
	let g:hier_highlight_group_qf  = "qf_error_ucurl"
	" 警告を青字の波線で
	execute "highlight qf_warning_ucurl gui=undercurl guisp=Blue"
	let g:hier_highlight_group_qfw = "qf_warning_ucurl"

	" ### vim-cpp-enhanced-highlight ###
	let g:cpp_class_scope_highlight = 1
	let g:cpp_member_variable_highlight = 1
	let g:cpp_class_decl_highlight = 1
	let g:cpp_posix_standard = 1
	let g:cpp_experimental_simple_template_highlight = 1
	let g:cpp_concepts_highlight = 1

endfunction
