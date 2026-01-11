-- Tmux Integration Module
--
-- Focus: Seamless navigation between Neovim splits and Tmux panes.
-- Principles:
-- 1. Single Responsibility: This file only handles Tmux navigation.
-- 2. Explicit Configuration: Keys are explicitly defined for clarity and lazy-loading support.

return {
  {
    "christoomey/vim-tmux-navigator",
    -- Lazy load: Plugin initializes only when these commands are invoked
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    -- Lazy load: Plugin initializes only when these keybindings are used
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate Left (Tmux/Nvim)" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate Down (Tmux/Nvim)" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate Up (Tmux/Nvim)" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate Right (Tmux/Nvim)" },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate Previous (Tmux/Nvim)" },
    },
    init = function()
      -- Disable default mappings to avoid conflicts and maintain control in the 'keys' table above.
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
}
