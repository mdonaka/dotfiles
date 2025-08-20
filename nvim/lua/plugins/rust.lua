return {
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
    config = function()
      -- 自動整形
      vim.g.rustfmt_autosave = 1
      -- LanguageClient用 rust-analyzer
      vim.g.LanguageClient_serverCommands = { rust = { "rust-analyzer" } }
      -- ALE用 linter
      vim.g.ale_linters = { rust = { "analyzer" } }
    end,
  },
}
