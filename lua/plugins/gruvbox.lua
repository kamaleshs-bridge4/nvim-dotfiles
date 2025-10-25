return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox", -- Optional, but good practice
  priority = 1000, -- Make sure to load this before all the other start plugins
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        -- Transparency
        Normal = { bg = "none" },
        NonText = { bg = "none" },
        NormalFloat = { bg = "none" },
        SignColumn = { bg = "none" },
        -- Make borders more visible
        FloatBorder = { fg = "#83a598", bg = "none" },
        -- Telescope transparency
        TelescopeNormal = { bg = "none" },
        TelescopeBorder = { fg = "#83a598", bg = "none" },
        TelescopePromptNormal = { bg = "none" },
        TelescopePromptBorder = { fg = "#8ec07c", bg = "none" },
        TelescopePromptTitle = { fg = "#8ec07c", bg = "none", bold = true },
        TelescopeResultsNormal = { bg = "none" },
        TelescopeResultsBorder = { fg = "#83a598", bg = "none" },
        TelescopeResultsTitle = { fg = "#83a598", bg = "none", bold = true },
        TelescopePreviewNormal = { bg = "none" },
        TelescopePreviewBorder = { fg = "#83a598", bg = "none" },
        TelescopePreviewTitle = { fg = "#83a598", bg = "none", bold = true },
        TelescopeSelection = { bg = "#3c3836", fg = "#ebdbb2", bold = true },
        -- Enhanced cursor line
        CursorLine = { bg = "#3c3836" },
        CursorLineNr = { fg = "#fabd2f", bg = "none", bold = true },
        -- LSP reference highlighting
        LspReferenceText = { bg = "#504945" },
        LspReferenceRead = { bg = "#504945" },
        LspReferenceWrite = { bg = "#504945", bold = true },
        -- Better matching brackets
        MatchParen = { fg = "#fe8019", bg = "#504945", bold = true },
        -- Visual selection
        Visual = { bg = "#504945", bold = true },
        -- Transparent sidebars
        NvimTreeNormal = { bg = "none" },
        NvimTreeNormalNC = { bg = "none" },
      },
      dim_inactive = false,
      transparent_mode = true,
    })

    -- Load the colorscheme
    vim.cmd.colorscheme("gruvbox")
  end,
}
