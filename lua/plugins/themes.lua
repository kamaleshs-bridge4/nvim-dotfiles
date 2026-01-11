-- Themes Module
--
-- Focus: Colorscheme installation and configuration.
-- Principles:
-- 1. Single Responsibility: This file only handles theme configuration.
-- 2. Explicit Configuration: Theme settings are clearly defined.

return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      term_colors = true,
    },
  },
  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_mode = true,
    },
  },
}

