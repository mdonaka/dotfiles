return {
  -- ファイラ本体
  {
    "lambdalisue/fern.vim",
    config = function()
      -- デフォルトマッピング無効化
      vim.g["fern#disable_default_mappings"] = 1

      -- FileType fern で FernInit を呼ぶ
      local function FernInit()
        local api = vim.api
        local buf = api.nvim_get_current_buf()

        vim.cmd([[
        nmap <buffer><silent><expr> <Plug>(fern-my-open-or-expand-collapse) fern#smart#leaf("\<Plug>(fern-action-open-or-enter)", "\<Plug>(fern-action-expand)", "\<Plug>(fern-action-collapse)")
      ]])

        api.nvim_buf_set_keymap(buf, "n", "r", "<Plug>(fern-action-reload)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "H", "<Plug>(fern-action-hidden)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "i", "<Plug>(fern-action-open:below)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "I", "<Plug>(fern-action-open:right)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "o", "<Plug>(fern-my-open-or-expand-collapse)",
          { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "O", "<Plug>(fern-action-collapse)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "l", "<Plug>(fern-action-enter)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "h", "<Plug>(fern-action-leave)", { noremap = false, silent = true })

        api.nvim_buf_set_keymap(buf, "n", "C", "<Plug>(fern-action-clipboard-copy)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "M", "<Plug>(fern-action-clipboard-move)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "P", "<Plug>(fern-action-clipboard-paste)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "D", "<Plug>(fern-action-remove)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "-", "<Plug>(fern-action-mark:toggle)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "v", "-", "<Plug>(fern-action-mark:toggle)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "=", "<Plug>(fern-action-mark:clear)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "A", "<Plug>(fern-action-new-path=)", { noremap = false, silent = true })

        api.nvim_buf_set_keymap(buf, "n", "p", "<Plug>(fern-action-preview:toggle)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "<C-p>", "<Plug>(fern-action-preview:auto:toggle)",
          { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "d", "<Plug>(fern-action-preview:scroll:down:half)",
          { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "u", "<Plug>(fern-action-preview:scroll:up:half)",
          { noremap = false, silent = true })

        api.nvim_buf_set_keymap(buf, "n", "ff", "<Plug>(fern-action-fzf-files)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "fd", "<Plug>(fern-action-fzf-dirs)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "fa", "<Plug>(fern-action-fzf-both)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "frf", "<Plug>(fern-action-fzf-root-files)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "frd", "<Plug>(fern-action-fzf-root-dirs)", { noremap = false, silent = true })
        api.nvim_buf_set_keymap(buf, "n", "fra", "<Plug>(fern-action-fzf-root-both)", { noremap = false, silent = true })
      end

      -- FileType fernで初期化
      vim.api.nvim_create_augroup("FernEvents", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = "FernEvents",
        pattern = "fern",
        callback = FernInit,
      })

      -- <C-e> でFernを起動
      vim.keymap.set("n", "<C-e>", ":Fern . -reveal=% -drawer -toggle -width=27<CR>", { noremap = true, silent = true })

      -- VimEnterでFernを自動起動（ここが抜けていました）
      vim.api.nvim_create_augroup("__fern__", { clear = true })
      vim.api.nvim_create_autocmd("VimEnter", {
        group = "__fern__",
        nested = true,
        command = "Fern . -reveal=% -drawer -toggle -width=27",
      })
    end
  },

  -- git差分を表示
  { "lambdalisue/fern-git-status.vim", dependencies = { "lambdalisue/fern.vim" } },
  -- previewを開く
  { "yuki-yano/fern-preview.vim",      dependencies = { "lambdalisue/fern.vim" } },

  -- font
  { "lambdalisue/nerdfont.vim" },
  {
    "lambdalisue/glyph-palette.vim",
    config = function()
      vim.api.nvim_create_augroup("my-glyph-palette", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = "my-glyph-palette",
        pattern = { "fern", "nerdtree", "startify" },
        callback = function()
          vim.cmd("call glyph_palette#apply()")
        end,
      })
    end,
  },
  {
    "lambdalisue/fern-renderer-nerdfont.vim",
    dependencies = { "lambdalisue/fern.vim", "lambdalisue/nerdfont.vim" },
    config = function()
      vim.g["fern#renderer"] = "nerdfont"
      -- ディレクトリの線を表示
      vim.g["fern#renderer#nerdfont#indent_markers"] = 1
    end,
  },

  { "junegunn/fzf", build = "./install --bin" },
  {
    "LumaKernel/fern-mapping-fzf.vim",
    dependencies = { "lambdalisue/fern.vim" },
    config = function()
      -- fzfオプションカスタマイズ
      vim.cmd([[
        function! Fern_mapping_fzf_customize_option(spec)
          let a:spec.options .= ' --multi'
          if exists('*fzf#vim#with_preview')
            return fzf#vim#with_preview(a:spec)
          else
            return a:spec
          endif
        endfunction

        function! Fern_mapping_fzf_before_all(dict)
          if !len(a:dict.lines)
            return
          endif
          return a:dict.fern_helper.async.update_marks([])
        endfunction

        function! s:reveal(dict)
          execute "FernReveal -wait" a:dict.relative_path
          execute "normal \<Plug>(fern-action-mark:set)"
        endfunction

        let g:Fern_mapping_fzf_file_sink = function('s:reveal')
        let g:Fern_mapping_fzf_dir_sink = function('s:reveal')
      ]])
    end,
  },
}
