-- Slides Module
--
-- Focus: Terminal-based presentation from markdown files.
-- Principles:
-- 1. Single Responsibility: This file only handles slides presentation.
-- 2. Explicit Configuration: Options and keymaps are clearly defined.

return {
  "aspeddro/slides.nvim",
  -- Lazy load: Plugin initializes only when command or keymap is used
  cmd = "Slides",
  keys = {
    { "<leader>ps", "<cmd>Slides<cr>", desc = "Present Slides" },
  },
  opts = {
    bin = "slides",    -- path to slides binary
    fullscreen = true, -- open in fullscreen
  },
}
