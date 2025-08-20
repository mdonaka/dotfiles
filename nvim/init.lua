require("config.options")
require("config.filetypes")
require("config.keymaps")
require("config.lazy")

-- init.vimを移植完了まで読み込んでおく
local legacy = vim.fn.stdpath("config") .. "/init_legacy.vim"
if vim.fn.filereadable(legacy) == 1 then
  vim.cmd("source " .. legacy)
end
