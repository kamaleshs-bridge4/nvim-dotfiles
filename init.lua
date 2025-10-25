require("config.lazy")

vim.o.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "number"

vim.opt.guicursor = table.concat({
  "n-v-c:block-blinkwait700-blinkon400-blinkoff250",
  "i:ver25-blinkwait700-blinkon400-blinkoff250",
  "r:hor20-blinkwait700-blinkon400-blinkoff250"
}, ",")

vim.opt.cursorline = true
