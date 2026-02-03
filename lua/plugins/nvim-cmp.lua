-- Completion Module
--
-- Focus: Autocompletion UI with LSP, snippets, buffer, and path sources.
-- Principles:
-- 1. Single Responsibility: This file only handles completion configuration.
-- 2. Explicit Configuration: Sources and keymaps are clearly defined.

-- Formatting configuration
local FORMAT_MAXWIDTH = 20
local FORMAT_ELLIPSIS = "..."

-- Docs scroll mode: remap j/k to scroll documentation while keeping cmp open
local docs_scroll_mode = false
local scroll_keymaps = {}

local function exit_docs_scroll_mode()
  if not docs_scroll_mode then return end
  docs_scroll_mode = false
  -- Remove temporary keymaps (including Esc)
  for _, key in ipairs({ "j", "k", "<C-d>", "<C-u>", "G", "g", "<Esc>" }) do
    pcall(vim.keymap.del, "i", key, { buffer = 0 })
  end
  scroll_keymaps = {}
  vim.api.nvim_echo({}, false, {}) -- Clear the mode indicator
end

local function enter_docs_scroll_mode(cmp)
  if docs_scroll_mode then return end
  docs_scroll_mode = true

  local buf = vim.api.nvim_get_current_buf()

  -- Scroll down
  vim.keymap.set("i", "j", function()
    cmp.mapping.scroll_docs(4)()
  end, { buffer = buf, nowait = true })

  -- Scroll up
  vim.keymap.set("i", "k", function()
    cmp.mapping.scroll_docs(-4)()
  end, { buffer = buf, nowait = true })

  -- Page down
  vim.keymap.set("i", "<C-d>", function()
    cmp.mapping.scroll_docs(12)()
  end, { buffer = buf, nowait = true })

  -- Page up
  vim.keymap.set("i", "<C-u>", function()
    cmp.mapping.scroll_docs(-12)()
  end, { buffer = buf, nowait = true })

  -- Bottom (G)
  vim.keymap.set("i", "G", function()
    cmp.mapping.scroll_docs(999)()
  end, { buffer = buf, nowait = true })

  -- Top (gg)
  vim.keymap.set("i", "g", function()
    cmp.mapping.scroll_docs(-999)()
  end, { buffer = buf, nowait = true })

  -- Show mode indicator
  vim.api.nvim_echo({ { "-- DOCS SCROLL (j/k/G/g, Esc to exit) --", "ModeMsg" } }, false, {})

  -- Exit on Esc or when cmp closes
  vim.keymap.set("i", "<Esc>", function()
    exit_docs_scroll_mode()
    cmp.abort()
  end, { buffer = buf, nowait = true })
end


local function setup_cmp()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  -- Integrate autopairs with cmp to avoid double-closing during completion
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  cmp.setup({
    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered({
        max_width = 120,
        max_height = 20,
      }),
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        show_labelDetails = true,
        maxwidth = FORMAT_MAXWIDTH,
        ellipsis_char = FORMAT_ELLIPSIS,
      }),
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["K"] = cmp.mapping(function()
        if cmp.visible() then
          enter_docs_scroll_mode(cmp)
        end
      end, { "i" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
  })

  -- Exit docs scroll mode when completion menu closes
  cmp.event:on("menu_closed", exit_docs_scroll_mode)
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "onsails/lspkind.nvim",
    "windwp/nvim-autopairs",
  },
  config = setup_cmp,
}

