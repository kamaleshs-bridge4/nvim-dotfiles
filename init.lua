require("config.lazy")

-- Basic settings
vim.o.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.signcolumn = "number"
vim.opt.laststatus = 0

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

-- Transparency
local highlight_groups = {
  "Normal", "NormalNC", "LineNr", "Folded", 
  "NonText", "SpecialKey", "VertSplit", 
  "SignColumn", "EndOfBuffer", "NormalFloat", "FloatBorder"
}

for _, group in ipairs(highlight_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

-- LSP floating window borders configured in lua/plugins/lsp.lua

-- Better defaults
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Go-specific tab settings (Go uses tabs, not spaces)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod', 'gowork', 'gotmpl' },
  group = vim.api.nvim_create_augroup('GoTabSettings', { clear = true }),
  callback = function()
    vim.opt_local.expandtab = false  -- Use actual tabs
    vim.opt_local.tabstop = 8        -- Go standard: tabs are 8 spaces wide
    vim.opt_local.shiftwidth = 8     -- Indent with tabs (8 spaces wide)
  end,
})
