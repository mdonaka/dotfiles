-- Kotlin
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.kt",
  command = "setfiletype kotlin",
})

-- CoffeeScript
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile", "BufReadPre"}, {
  pattern = "*.coffee",
  command = "set filetype=coffee",
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.cson",
  command = "set ft=coffee",
})

-- Markdown
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.md",
  command = "set filetype=markdown",
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.mkd",
  command = "set filetype=markdown",
})

-- CSV
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.csv",
  command = "set filetype=csv",
})

-- Terraform
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.tf",
  command = "set filetype=terraform",
})
