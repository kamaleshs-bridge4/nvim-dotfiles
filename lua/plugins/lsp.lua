-- LSP Core Module
--
-- Focus: LSP client setup, diagnostics, and buffer-local keymaps.
-- Principles:
-- 1. Single Responsibility: This file only handles LSP client configuration.
-- 2. Explicit Configuration: Diagnostics and keymaps are clearly defined.
-- Note: Uses native vim.lsp.config (Neovim 0.11+)

-- Hover documentation configuration
local HOVER_WIDTH_RATIO = 0.6
local HOVER_HEIGHT_RATIO = 0.4

-- Track hover window
local hover_win = nil

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

-- setup_hover_keymaps configures navigation keymaps for hover window.
local function setup_hover_keymaps(bufnr, win_id)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Navigation
  vim.keymap.set("n", "h", "<Left>", opts)
  vim.keymap.set("n", "l", "<Right>", opts)
  vim.keymap.set("n", "j", "<Down>", opts)
  vim.keymap.set("n", "k", "<Up>", opts)

  -- Scrolling
  vim.keymap.set("n", "<C-f>", "<C-f>", opts)
  vim.keymap.set("n", "<C-b>", "<C-b>", opts)
  vim.keymap.set("n", "<C-d>", "<C-d>", opts)
  vim.keymap.set("n", "<C-u>", "<C-u>", opts)

  -- Close on Esc or q
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win_id, true)
    hover_win = nil
  end, opts)
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win_id, true)
    hover_win = nil
  end, opts)
end

-- custom_hover creates a floating window near the cursor for hover documentation.
local function custom_hover()
  -- If hover window exists and is valid, focus it
  if hover_win and vim.api.nvim_win_is_valid(hover_win) then
    vim.api.nvim_set_current_win(hover_win)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(bufnr, "textDocument/hover", params, function(err, result, ctx)
    if err or not result then
      return
    end

    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    
    -- Remove empty lines from start and end (replaces deprecated trim_empty_lines)
    while #markdown_lines > 0 and markdown_lines[1] == "" do
      table.remove(markdown_lines, 1)
    end
    while #markdown_lines > 0 and markdown_lines[#markdown_lines] == "" do
      table.remove(markdown_lines, #markdown_lines)
    end
    
    if vim.tbl_isempty(markdown_lines) then
      return
    end

    local screen_w = vim.opt.columns:get()
    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
    local window_w = math.floor(screen_w * HOVER_WIDTH_RATIO)
    local window_h = math.floor(screen_h * HOVER_HEIGHT_RATIO)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, markdown_lines)
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    vim.api.nvim_buf_set_option(buf, "wrap", true)

    -- Position window relative to cursor (below and slightly right)
    hover_win = vim.api.nvim_open_win(buf, true, {
      relative = "cursor",
      row = 1,
      col = 1,
      width = window_w,
      height = window_h,
      border = "rounded",
      style = "minimal",
    })

    -- Enable scrolling in hover window
    vim.api.nvim_win_set_option(hover_win, "wrap", true)
    vim.api.nvim_win_set_option(hover_win, "scrolloff", 0)

    setup_hover_keymaps(buf, hover_win)
  end)
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

        -- Documentation and diagnostics
        vim.keymap.set("n", "K", custom_hover, opts("Hover Documentation"))
        vim.keymap.set("n", "<S-K>", custom_hover, opts("Hover Documentation"))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature Help"))

        -- Code actions and rename
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Actions"))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))
      end,
    })

    -- Enable LSP servers using native vim.lsp.config (Neovim 0.11+)
    vim.lsp.enable(LSP_SERVERS)
  end,
}

