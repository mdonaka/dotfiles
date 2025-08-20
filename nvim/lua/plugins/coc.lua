return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- cocの補完をtabでできるようにする
      vim.api.nvim_set_keymap("i", "<TAB>",
        'coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\\<Tab>" : coc#refresh()',
        { noremap = true, silent = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<S-TAB>",
        'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-h>"',
        { noremap = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<C-j>",
        'coc#pum#visible() ? coc#pum#next(1) : "\\<C-j>"',
        { noremap = true, silent = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<C-k>",
        'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-k>"',
        { noremap = true, silent = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<CR>",
        'coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"',
        { noremap = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<C-q>",
        'coc#pum#visible() ? coc#pum#scroll(0) : "\\<C-q>"',
        { noremap = true, silent = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<C-l>",
        'coc#refresh()',
        { noremap = true, silent = true, expr = true }
      )

      -- coclist
      vim.api.nvim_set_keymap("n", "<C-l>", ":CocList<CR>", { noremap = true })

      -- 定義ジャンプ
      vim.api.nvim_set_keymap("n", "gdj", "<Plug>(coc-definition)", { silent = true })
      vim.api.nvim_set_keymap("n", "gdi", ":sp<CR><Plug>(coc-definition)", { silent = true })
      vim.api.nvim_set_keymap("n", "gdI", ":vs<CR><Plug>(coc-definition)", { silent = true })

      -- 変数名変更
      vim.api.nvim_set_keymap("n", "<C-n>", "<Plug>(coc-rename)", { silent = true })

      -- CheckBackspace() の実装
      vim.cmd([[
        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction
      ]])
    end,
  },
}
