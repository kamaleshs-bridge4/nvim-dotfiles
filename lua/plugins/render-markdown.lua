-- Markdown Rendering Module
--
-- Focus: Rich in-buffer markdown rendering (headings, code blocks, tables, checkboxes).
-- Principles:
-- 1. Single Responsibility: This file only handles render-markdown configuration.
-- 2. Explicit Configuration: All render targets are clearly toggled.

-- File types that trigger the plugin
local RENDER_FILETYPES = { "markdown", "Avante" }

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = RENDER_FILETYPES,
  keys = {
    {
      "<leader>mr",
      "<cmd>RenderMarkdown toggle<cr>",
      ft = "markdown",
      desc = "Toggle Markdown Rendering",
    },
  },
  opts = {
    enabled = false, -- start disabled; toggle with <leader>mr
    file_types = RENDER_FILETYPES,
    render_modes = { "n", "c" }, -- render in normal and command mode only
    anti_conceal = { enabled = false }, -- always render, even on the current line
    heading = {
      sign = false, -- no sign column clutter (matches signcolumn="number")
    },
    code = {
      sign = false,
      width = "block", -- code blocks fill only content width, cleaner on transparent bg
      right_pad = 1,
    },
  },
}
