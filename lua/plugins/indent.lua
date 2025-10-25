-- File: lua/plugins/indent.lua
-- Beautiful vertical indentation lines with elegant styling

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  config = function()
    -- Define custom highlight colors for indent guides
    local highlight = {
      "IblIndent1",
      "IblIndent2",
      "IblIndent3",
      "IblIndent4",
      "IblIndent5",
      "IblIndent6",
    }

    local scope_highlight = "IblScope"

    -- Set up subtle, elegant colors for indent guides
    -- These colors work well with both Gruvbox and Catppuccin
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Subtle gradient of colors for indent levels
      vim.api.nvim_set_hl(0, "IblIndent1", { fg = "#3c3836" }) -- Very subtle
      vim.api.nvim_set_hl(0, "IblIndent2", { fg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IblIndent3", { fg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IblIndent4", { fg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IblIndent5", { fg = "#3c3836" })
      vim.api.nvim_set_hl(0, "IblIndent6", { fg = "#3c3836" })
      
      -- Scope/context line is more visible
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#83a598", bold = false })
    end)

    require("ibl").setup({
      indent = {
        char = "│", -- Thin vertical line
        tab_char = "│",
        highlight = highlight,
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = {
        enabled = true,
        char = "▎", -- Thicker line for current scope
        show_start = false,
        show_end = false,
        show_exact_scope = true,
        highlight = scope_highlight,
        include = {
          node_type = {
            lua = { "return_statement", "table_constructor" },
            python = { "function_definition", "class_definition" },
            javascript = { "object", "array", "arrow_function" },
            typescript = { "object_type", "array_type" },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = {
          "terminal",
          "nofile",
        },
      },
    })
  end,
}


