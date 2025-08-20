-- ノーマルモードへの切り替え簡略化
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("t", "jj", "<C-\\><C-n>")

-- ショートカットキーの登録
-- window分割関係(移動，拡大縮小)
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sl", "<C-w>l")
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "S<", "<C-w><")
vim.keymap.set("n", "S>", "<C-w>>")
vim.keymap.set("n", "S+", "<C-w>+")
vim.keymap.set("n", "S=", "<C-w>-")

-- 保存終了の簡易化
vim.keymap.set("n", "<Space>w", ":<C-u>write<CR>")
vim.keymap.set("n", "<Space>q", ":<C-u>quit<CR>")

-- 文末移動
vim.keymap.set({ "n", "v" }, "4", "<End>")

-- vimgrepで前へ
vim.keymap.set("n", "[q", ":cprevious<CR>")
-- vimgrepで次へ
vim.keymap.set("n", "]q", ":cnext<CR>")
