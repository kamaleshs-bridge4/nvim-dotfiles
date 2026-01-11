-- Search & Navigation Module
--
-- Focus: Fuzzy finding files, text, and symbols with centered preview.
-- Principles:
-- 1. Single Responsibility: This file only handles search/navigation configuration.
-- 2. Explicit Configuration: Layout and keymaps are clearly defined.

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  -- Lazy load: Plugin initializes only when these keybindings are used
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep Word Under Cursor" },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            prompt_position = "top",
          },
          width = 0.85,
          height = 0.75,
        },
        sorting_strategy = "ascending",
      },
    })

    -- Load fzf extension for better performance
    pcall(telescope.load_extension, "fzf")
  end,
}
