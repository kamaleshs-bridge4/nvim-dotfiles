-- LSP Installer Module
--
-- Focus: Automatic installation and management of LSP servers via Mason.
-- Principles:
-- 1. Single Responsibility: This file only handles LSP server installation.
-- 2. Explicit Configuration: All LSP servers are explicitly listed.

-- LSP servers to install
local LSP_SERVERS = {
  "lua_ls",
  "ruby_lsp",
  "html",
  "cssls",
  "jsonls",
  "ts_ls",
  "eslint",
  "pyright",
  "bashls",
  "rust_analyzer",
  "gopls",
  "golangci_lint_ls",
}

return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = LSP_SERVERS,
      automatic_installation = true,
    })
  end,
}

