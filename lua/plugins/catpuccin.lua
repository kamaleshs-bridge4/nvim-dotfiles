-- Add this to your lazy.nvim plugins list
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Keep priority high, same as other themes
  config = function()
    -- You can set catppuccin-specific options here
    require("catppuccin").setup({
       flavour = "mocha", -- mocha for dark theme with better transparency
       transparent_background = true, -- Enable transparency
       integrations = {
         cmp = true, 
         treesitter = true,
         telescope = {
           enabled = true,
         },
         nvimtree = true,
         illuminate = {
           enabled = true,
           lsp = true,
         },
         native_lsp = {
           enabled = true,
           underlines = {
             errors = { "undercurl" },
             hints = { "undercurl" },
             warnings = { "undercurl" },
             information = { "undercurl" },
           },
         },
         notify = true,
         lsp_saga = false,
       },
       custom_highlights = function(colors)
         return {
           -- Make borders more visible with subtle colors
           FloatBorder = { fg = colors.blue, bg = "none" },
           -- Telescope transparency
           TelescopeNormal = { bg = "none" },
           TelescopeBorder = { fg = colors.blue, bg = "none" },
           TelescopePromptNormal = { bg = "none" },
           TelescopePromptBorder = { fg = colors.teal, bg = "none" },
           TelescopePromptTitle = { fg = colors.teal, bg = "none" },
           TelescopeResultsNormal = { bg = "none" },
           TelescopeResultsBorder = { fg = colors.blue, bg = "none" },
           TelescopeResultsTitle = { fg = colors.blue, bg = "none" },
           TelescopePreviewNormal = { bg = "none" },
           TelescopePreviewBorder = { fg = colors.blue, bg = "none" },
           TelescopePreviewTitle = { fg = colors.blue, bg = "none" },
           TelescopeSelection = { bg = colors.surface0, fg = colors.text },
           -- Enhanced cursor line
           CursorLine = { bg = colors.surface0 },
           CursorLineNr = { fg = colors.lavender, style = { "bold" } },
           -- LSP reference highlighting
           LspReferenceText = { bg = colors.surface1 },
           LspReferenceRead = { bg = colors.surface1 },
           LspReferenceWrite = { bg = colors.surface1, style = { "bold" } },
           -- Better matching brackets
           MatchParen = { fg = colors.peach, bg = colors.surface1, style = { "bold" } },
           -- Visual selection
           Visual = { bg = colors.surface1, style = { "bold" } },
         }
       end,
    })
  end,
}

