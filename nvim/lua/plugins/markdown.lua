return {
  -- markdownシンタックス・機能強化
  {
    "plasticboy/vim-markdown",
    ft = { "markdown" },
    dependencies = {
      "godlygeek/tabular",
    },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.foldmethod = "manual"
        end,
      })
    end,
  },
  -- プレビュー
  {
    "previm/previm",
    ft = { "markdown" },
    dependencies = {
      "godlygeek/tabular",
    },
    config = function()
      local uname = vim.fn.substitute(vim.fn.system("uname"), '\n', '', '')
      if uname == "Linux" then
        vim.g.previm_open_cmd = '/mnt/c/Program\\ Files/Mozilla\\ Firefox/firefox.exe'
        vim.g.previm_wsl_mode = 1
      elseif vim.fn.has("mac") == 1 then
        vim.g.previm_open_cmd = 'open -a "Google Chrome"'
      end
      vim.g.previm_enable_realtime = 1
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<F5>", ":<C-u>PrevimOpen<CR>", { buffer = true, silent = true })
        end,
      })
    end,
  },
}
