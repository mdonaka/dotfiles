return {
  {
    "tpope/vim-commentary",
  },
  -- 非同期処理
  {
    "Shougo/vimproc.vim",
    build = "make",
  },
  -- 括弧の自動補完
  {
    "Townk/Vim-autoclose",
  },
  -- オペレータを定義する
  {
    "kana/vim-operator-user",
  },
  -- statuslineをおしゃれにする
  {
    "itchyny/lightline.vim",
    config = function()
      if not vim.fn.has("gui_running") then
        vim.opt.t_Co = 256
      end
      vim.g.lightline = {
        colorscheme = "solarized",
        active = {
          left = {
            { "mode",            "paste" },
            { "readonly",        "filename",      "modified" },
            { "linter_checking", "linter_errors", "linter_warnings", "linter_ok" },
          },
        },
      }
    end,
  },
  -- スニペットの補完
  {
    "Shougo/neosnippet",
    dependencies = { "Shougo/neosnippet-snippets" },
    config = function()
      vim.opt.completeopt:remove("preview")
    end,
  },
  -- スニペット集
  {
    "Shougo/neosnippet-snippets",
  },

  -- Vimのcolorschemeを切り替える
  {
    "mdonaka/vim-color-switcher",
    dependencies = {
      "rafi/awesome-vim-colorschemes",
      {
        "ibhagwan/fzf-lua",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
      }
    }
  }
}
