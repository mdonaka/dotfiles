-- ##### エディタ関係 #####
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.title = true
vim.opt.display = "lastline"
vim.opt.pumheight = 10
vim.opt.ruler = true
vim.opt.syntax = "on"
vim.opt.conceallevel = 1
vim.opt.list = true
vim.opt.listchars = { tab = "»-", trail = "-", extends = "»", precedes = "«", nbsp = "%" }

vim.cmd([[hi SpecialKey ctermbg=None ctermfg=70 guibg=NONE guifg=None]])

-- ##### 検索関係 #####
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.incsearch = true

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "*grep*",
  command = "cwindow"
})

-- 対応括弧の色付け
vim.cmd([[hi MatchParen ctermfg=LightGreen ctermbg=blue]])

-- ##### その他 #####
vim.opt.splitright = true
vim.opt.splitbelow = true

-- カーソル位置の記憶
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  command = "mkview"
})
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = "silent! loadview"
})
vim.opt.viewoptions:remove("options")

vim.opt.clipboard = "unnamedplus"

-- Python2のpath
vim.g.python_host_prog = vim.fn.expand("$HOME/.pyenv/shims/python2")

-- WSL/Win32でクリップボード共有（Linux + Microsoft環境）
if vim.loop.os_uname().sysname == "Linux" then
  local lines = vim.fn.readfile("/proc/version")
  if lines[1] and lines[1]:find("Microsoft") then
    vim.g.clipboard = {
      name = "myClipboard",
      copy = { ["+"] = "xsel -bi", ["*"] = "xsel -bi" },
      paste = { ["+"] = "xsel -bo", ["*"] = "xsel -bo" },
      cache_enabled = 1,
    }
  end
end

-- ##### ターミナルモード #####
if vim.fn.has("nvim") == 1 then
  vim.api.nvim_create_user_command("Term", "split | terminal <args>", { nargs = "*" })
  vim.api.nvim_create_user_command("Termv", "vsplit | terminal <args>", { nargs = "*" })
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert"
})
