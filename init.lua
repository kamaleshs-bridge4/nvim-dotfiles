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
vim.opt.cursorline = false

vim.cmd.colorscheme("catppuccin-frappe")

-- Global border style for floating windows (Neovim 0.11+)
vim.o.winborder = "rounded"

-- Transparency (reapplied on colorscheme change)
local function apply_transparency()
  local highlight_groups = {
    "Normal", "NormalNC", "LineNr", "Folded",
    "NonText", "SpecialKey", "VertSplit",
    "SignColumn", "EndOfBuffer", "NormalFloat", "FloatBorder"
  }

  for _, group in ipairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
  end

  -- Subtle line numbers (barely visible)
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#3b4261", bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#565f89", bg = "none" })

  -- Diagnostic underlines: Use undercurl (squiggly) instead of straight underline
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#db4b4b" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#e0af68" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#0db9d7" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#1abc9c" })
end

-- Apply on startup and after every colorscheme change
apply_transparency()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TransparencyOnThemeChange", { clear = true }),
  callback = apply_transparency,
})

-- LSP diagnostics and floating window borders configured in lua/plugins/lsp.lua

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

-- Open Telescope file picker when Neovim is opened with a directory
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('OpenDirectory', { clear = true }),
  callback = function()
    -- Check if opened with a directory (no file specified)
    -- When opening with 'nvim .', the buffer name is empty or matches the directory
    local bufname = vim.api.nvim_buf_get_name(0)
    local is_empty_buffer = bufname == "" or bufname == vim.fn.getcwd()
    
    if is_empty_buffer and vim.bo.buftype == "" then
      -- Close the empty buffer and open Telescope file picker
      vim.api.nvim_buf_delete(0, { force = true })
      vim.defer_fn(function()
        require("telescope.builtin").find_files({ hidden = true })
      end, 10)
    end
  end,
})
