-- Completion Module
--
-- Focus: Autocompletion UI with LSP, snippets, buffer, and path sources.
-- Principles:
-- 1. Single Responsibility: This file only handles completion configuration.
-- 2. Explicit Configuration: Sources and keymaps are clearly defined.

-- Formatting configuration
local FORMAT_MAXWIDTH = 50
local FORMAT_ELLIPSIS = "..."

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
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = FORMAT_MAXWIDTH,
        ellipsis_char = FORMAT_ELLIPSIS,
      }),
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
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

