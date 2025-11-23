-- File: lua/plugins/indent.lua
-- Beautiful vertical indentation lines with elegant styling

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  config = function()
    require("ibl").setup({
      indent = {
        char = "│", -- Thin vertical line
        tab_char = "│",
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


