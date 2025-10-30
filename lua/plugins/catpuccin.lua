-- Catppuccin theme with 4 variants and cycling support
local M = {}

-- Define the 4 Catppuccin variants
M.variants = { "latte", "frappe", "macchiato", "mocha" }
M.current_index = 1

-- Function to cycle through themes
function M.cycle_theme()
  M.current_index = M.current_index + 1
  if M.current_index > #M.variants then
    M.current_index = 1
  end
  
  local variant = M.variants[M.current_index]
  vim.cmd("colorscheme catppuccin-" .. variant)
  
  -- Notify user of current theme
  vim.notify("Switched to Catppuccin " .. variant, vim.log.levels.INFO, { title = "Theme" })
  
  -- Apply consistent theming to all UI components
  M.apply_ui_theming()
end

-- Function to apply consistent theming to all UI components
function M.apply_ui_theming()
  local colors = require("catppuccin.palettes").get_palette()
  
  -- Telescope theming
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.blue, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.teal, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.teal, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.blue, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.blue, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.blue, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.blue, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.surface0, fg = colors.text })
  
  -- Sidekick theming
  vim.api.nvim_set_hl(0, "SidekickNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "SidekickBorder", { fg = colors.blue, bg = "none" })
  vim.api.nvim_set_hl(0, "SidekickTitle", { fg = colors.teal, bg = "none" })
  
  -- ToggleTerm theming
  vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = colors.blue, bg = "none" })
  
  -- NvimTree theming
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = colors.surface0, bg = "none" })
  
  -- General floating window theming
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.blue, bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  
  -- Enhanced cursor line
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.surface0 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.lavender, bold = true })
  
  -- LSP reference highlighting
  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = colors.surface1 })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = colors.surface1 })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = colors.surface1, bold = true })
  
  -- Better matching brackets
  vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.peach, bg = colors.surface1, bold = true })
  
  -- Visual selection
  vim.api.nvim_set_hl(0, "Visual", { bg = colors.surface1, bold = true })
  
  -- Completion menu theming
  vim.api.nvim_set_hl(0, "CmpPmenu", { link = "Pmenu" })
  vim.api.nvim_set_hl(0, "CmpBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "CmpSel", { 
    bg = colors.surface1, 
    fg = colors.text, 
    bold = true 
  })
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = M.variants[M.current_index],
      transparent_background = true,
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
          CursorLineNr = { fg = colors.lavender, bold = true },
          -- LSP reference highlighting
          LspReferenceText = { bg = colors.surface1 },
          LspReferenceRead = { bg = colors.surface1 },
          LspReferenceWrite = { bg = colors.surface1, bold = true },
          -- Better matching brackets
          MatchParen = { fg = colors.peach, bg = colors.surface1, bold = true },
          -- Visual selection
          Visual = { bg = colors.surface1, bold = true },
        }
      end,
    })
    
    -- Set up theme cycling keymap
    vim.keymap.set("n", "<leader>cc", M.cycle_theme, { desc = "Cycle Catppuccin theme variants" })
    
    -- Apply theming on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "catppuccin-*",
      callback = M.apply_ui_theming,
    })
    
    -- Initial theming application
    M.apply_ui_theming()
  end,
}

