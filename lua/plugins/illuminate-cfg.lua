-- Token Highlighting Module
--
-- Focus: Highlight word under cursor using LSP/Treesitter/Regex.
-- Principles:
-- 1. Single Responsibility: This file only handles token highlighting.
-- 2. Explicit Configuration: Providers and keymaps are clearly defined.

return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Highlight style: bold text, no underline
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bold = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bold = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bold = true })

    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 100,
      under_cursor = true,
    })

    -- Keymaps for navigating references
    vim.keymap.set("n", "<A-n>", function()
      require("illuminate").goto_next_reference()
    end, { desc = "Next Reference" })

    vim.keymap.set("n", "<A-p>", function()
      require("illuminate").goto_prev_reference()
    end, { desc = "Prev Reference" })
  end,
}

