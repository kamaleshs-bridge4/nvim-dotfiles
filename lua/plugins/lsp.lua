-- LSP Core Module
--
-- Focus: LSP client setup, diagnostics, and buffer-local keymaps.
-- Principles:
-- 1. Single Responsibility: This file only handles LSP client configuration.
-- 2. Explicit Configuration: Diagnostics and keymaps are clearly defined.
-- Note: Uses native vim.lsp.config (Neovim 0.11+)

-- LSP servers to enable (must match mason.lua)
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

-- show_diagnostics_or_hover shows diagnostics if present, otherwise hover documentation.
-- This provides a unified K experience: diagnostics take priority over hover.
local function show_diagnostics_or_hover()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diagnostics > 0 then
    vim.diagnostic.open_float({ border = "rounded", source = true })
    return
  end
  vim.lsp.buf.hover()
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Diagnostics: Squiggly underlines only, no virtual text
    vim.diagnostic.config({
      virtual_text = false,
      underline = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
      },
    })

    -- Diagnostic underlines: Use undercurl (squiggly) instead of straight underline
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#db4b4b" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#e0af68" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#0db9d7" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#1abc9c" })

    -- Setup LSP keymaps when LSP attaches to buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
      callback = function(event)
        local function opts(desc)
          return { buffer = event.buf, noremap = true, silent = true, desc = desc }
        end

        -- Goto navigation via Telescope (floating UI instead of bottom pane)
        local function show_definitions()
          require("telescope.builtin").lsp_definitions()
        end
        local function show_implementations()
          require("telescope.builtin").lsp_implementations()
        end
        local function show_references()
          require("telescope.builtin").lsp_references()
        end
        
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
        vim.keymap.set("n", "gd", show_definitions, opts("Goto Definition"))
        vim.keymap.set("n", "gi", show_implementations, opts("Goto Implementation"))
        vim.keymap.set("n", "gr", show_references, opts("Goto References"))
        vim.keymap.set("n", "<leader>gr", show_references, opts("Goto References"))

        -- Documentation and diagnostics (K shows diagnostics if present, else hover)
        vim.keymap.set("n", "K", show_diagnostics_or_hover, opts("Show Diagnostics or Hover"))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))

        -- Code actions and rename
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Actions"))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))
      end,
    })

    -- ESLint: Enable flat config support (eslint.config.mjs)
    vim.lsp.config("eslint", {
      settings = {
        useFlatConfig = true,
        experimental = {
          useFlatConfig = true,
        },
      },
    })

    -- Enable LSP servers using native vim.lsp.config (Neovim 0.11+)
    vim.lsp.enable(LSP_SERVERS)
  end,
}

