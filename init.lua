require("config.lazy")

-- Load gruvbox-dark-hard module early to set up autocmds
pcall(require, "gruvbox-dark-hard")

-- Basic settings
vim.o.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "number"

-- Cursor settings with blinking
vim.opt.guicursor = table.concat({
  "n-v-c:block-blinkwait700-blinkon400-blinkoff250",
  "i:ver25-blinkwait700-blinkon400-blinkoff250",
  "r:hor20-blinkwait700-blinkon400-blinkoff250"
}, ",")

-- Enhanced cursor line
vim.opt.cursorline = true

-- Global border style for floating windows
vim.g.border_style = "rounded"

-- Set global floating window border
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded"
  }
)

-- Better defaults
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
