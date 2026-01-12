-- File Explorer Module
--
-- Focus: Floating file tree with centered horizontal layout.
-- Principles:
-- 1. Single Responsibility: This file only handles file explorer configuration.
-- 2. Explicit Configuration: Layout dimensions and keymaps are clearly defined.

-- Layout configuration
local WINDOW_WIDTH_RATIO = 0.85
local WINDOW_HEIGHT_RATIO = 0.75

-- get_center_layout calculates centered floating window dimensions.
local function get_center_layout()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local window_w = math.floor(screen_w * WINDOW_WIDTH_RATIO)
  local window_h = math.floor(screen_h * WINDOW_HEIGHT_RATIO)

  return {
    relative = "editor",
    row = math.floor((screen_h - window_h) / 2),
    col = math.floor((screen_w - window_w) / 2),
    width = window_w,
    height = window_h,
    border = "rounded",
  }
end

-- on_attach configures buffer-local keymaps when tree opens.
local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  -- Apply default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Custom: Close tree with same key that opens it
  vim.keymap.set("n", "-", api.tree.close, {
    desc = "nvim-tree: Close",
    buffer = bufnr,
    noremap = true,
    silent = true,
  })
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Lazy load: Plugin initializes only when this keybinding is used
  keys = {
    {
      "-",
      function()
        require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
      end,
      desc = "Toggle File Explorer",
    },
  },
  init = function()
    -- Disable netrw to prevent conflicts
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    on_attach = on_attach,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      hijack_cursor = true,
      float = {
        enable = true,
        open_win_config = get_center_layout,
      },
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    renderer = {
      icons = {
        show = {
          git = true,
          diagnostics = false,
        },
      },
    },
    diagnostics = {
      enable = false,
    },
  },
}
