-- Terminal Module
--
-- Focus: Floating terminal with centered layout.
-- Principles:
-- 1. Single Responsibility: This file only handles terminal configuration.
-- 2. Explicit Configuration: Layout dimensions and keymaps are clearly defined.

-- Layout configuration
local WINDOW_WIDTH_RATIO = 0.85
local WINDOW_HEIGHT_RATIO = 0.75

-- on_open configures buffer-local keymaps when terminal opens.
local function on_open(term)
  local opts = { buffer = term.bufnr, noremap = true, silent = true }

  -- Terminal mode: Esc switches to normal mode
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

  -- Normal mode: Esc closes the terminal
  vim.keymap.set("n", "<Esc>", "<cmd>ToggleTerm<cr>", opts)
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- Lazy load: Plugin initializes only when this keybinding is used
  keys = {
    { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
  },
  opts = {
    size = function(term)
      if term.direction == "float" then
        return math.floor(vim.o.lines * WINDOW_HEIGHT_RATIO)
      end
    end,
    direction = "float",
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * WINDOW_WIDTH_RATIO)
      end,
      height = function()
        return math.floor(vim.o.lines * WINDOW_HEIGHT_RATIO)
      end,
    },
    on_open = on_open,
  },
}

