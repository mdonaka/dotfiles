return {
  {
    "tweekmonster/braceless.vim",
    ft = { "python" },
    config = function()
      -- pythonファイルを開いたときにBracelessを+indent +foldで有効化
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.cmd("BracelessEnable +indent +fold")
        end,
      })
    end,
  },
}
