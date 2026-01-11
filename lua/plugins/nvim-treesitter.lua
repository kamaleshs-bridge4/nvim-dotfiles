-- Syntax & Parsing Module
--
-- Focus: Syntax highlighting, indentation, and text objects via treesitter.
-- Principles:
-- 1. Single Responsibility: This file only handles treesitter configuration.
-- 2. Explicit Configuration: Languages and features are clearly defined.

-- Languages to install parsers for
local LANGUAGES = {
  "lua", "vim", "vimdoc",
  "html", "css", "javascript", "typescript",
  "json", "markdown", "markdown_inline",
  "bash", "go", "gomod", "gosum",
  "ruby", "zig", "rust", "java", "python",
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = LANGUAGES,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

