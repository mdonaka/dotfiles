return {
  {
    "rhysd/vim-clang-format",
    ft = { "c", "cpp" },
    config = function()
      -- 共通設定
      vim.g.clang_exec = "/usr/bin/g++-12"
      vim.g.clang_c_options = "-std=c11"
      vim.g.clang_cpp_options = "-std=c++2b -pedantic-errors -fconcepts -I /ac-library"
      vim.g.clang_format_auto = 1
      vim.g.clang_format_style = "Google"
      vim.g.clang_check_syntax_auto = 1
      vim.g["clang_format#style_options"] = {
        AllowShortBlocksOnASingleLine = "Always",
        UseTab = "Never",
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp" },
        callback = function()
          vim.cmd("ClangFormatAutoEnable")
        end,
      })
    end,
  },
  {
    "octol/vim-cpp-enhanced-highlight",
    ft = { "c", "cpp" },
    config = function()
      vim.g.cpp_class_scope_highlight = 1
      vim.g.cpp_member_variable_highlight = 1
      vim.g.cpp_class_decl_highlight = 1
      vim.g.cpp_posix_standard = 1
      vim.g.cpp_experimental_simple_template_highlight = 1
      vim.g.cpp_concepts_highlight = 1
    end,
  },
  -- commentaryのcommentstring設定もここで
  {
    "tpope/vim-commentary",
    ft = { "c", "cpp", "h", "hpp" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "h", "hpp" },
        callback = function()
          vim.opt_local.commentstring = "//%s"
        end,
      })
    end,
  },
}
