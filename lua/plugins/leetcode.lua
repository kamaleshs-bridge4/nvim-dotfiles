-- LeetCode Module
--
-- Focus: In-editor LeetCode problem solving with Telescope picker.
-- Principles:
-- 1. Single Responsibility: This file only handles LeetCode configuration.
-- 2. Explicit Configuration: Language, storage path, and layout are clearly defined.

-- Default language for new solutions (matches gopls LSP setup)
local DEFAULT_LANG = "golang"

-- Directory where solutions are stored (persists across sessions)
local STORAGE_DIR = vim.fn.stdpath("data") .. "/leetcode"

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  -- Lazy load: only initialized when :Leet command is used
  cmd = "Leet",
  opts = {
    -- Storage for downloaded problems and solutions
    storage = {
      home = STORAGE_DIR,
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    -- Language used when opening a problem for the first time
    lang = DEFAULT_LANG,

    -- Use telescope for the problem picker (already configured in telescope.lua)
    picker = { provider = "telescope" },

    -- Description pane on the left, code buffer on the right
    description = {
      position = "left",
      width = "40%",
    },

    -- Inject common boilerplate per language (extend as needed)
    injector = {},

    -- Hooks: add custom behaviour on problem open/submit (extend as needed)
    hooks = {},
  },
}
