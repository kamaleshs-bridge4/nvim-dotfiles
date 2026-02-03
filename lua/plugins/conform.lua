-- Formatter Module
--
-- Focus: Code formatting with format-on-save support.
-- Principles:
-- 1. Single Responsibility: This file only handles code formatting.
-- 2. Explicit Configuration: Formatters are explicitly listed per filetype.

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format Buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
