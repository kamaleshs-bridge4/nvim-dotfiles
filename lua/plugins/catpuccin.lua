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
  
  -- Telescope theming with solid backgrounds
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = colors.crust })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.teal, bg = colors.crust })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.teal, bg = colors.crust })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.surface0, fg = colors.text })
  
  -- Sidekick theming
  vim.api.nvim_set_hl(0, "SidekickNormal", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "SidekickBorder", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "SidekickTitle", { fg = colors.teal, bg = colors.mantle })
  
  -- ToggleTerm theming
  vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = colors.blue, bg = colors.mantle })
  
  -- NvimTree theming
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = colors.base })
  vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = colors.surface0, bg = colors.base })
  
  -- General floating window theming
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.mantle })
  
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
  
  -- DAP UI theming
  vim.api.nvim_set_hl(0, "DapUINormal", { bg = colors.base })
  vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = colors.blue, bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIVariable", { bg = colors.base })
  vim.api.nvim_set_hl(0, "DapUIValue", { bg = colors.base })
  vim.api.nvim_set_hl(0, "DapUIScope", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIThread", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIStoppedThread", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIFrameName", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUISource", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUILineNumber", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIWatchesValue", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIWatchesError", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { bg = colors.mantle })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { bg = colors.mantle })
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = M.variants[M.current_index],
      transparent_background = false,
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
          -- Floating windows with solid backgrounds
          FloatBorder = { fg = colors.blue, bg = colors.mantle },
          NormalFloat = { bg = colors.mantle },
          -- Telescope with solid backgrounds
          TelescopeNormal = { bg = colors.mantle },
          TelescopeBorder = { fg = colors.blue, bg = colors.mantle },
          TelescopePromptNormal = { bg = colors.crust },
          TelescopePromptBorder = { fg = colors.teal, bg = colors.crust },
          TelescopePromptTitle = { fg = colors.teal, bg = colors.crust },
          TelescopeResultsNormal = { bg = colors.mantle },
          TelescopeResultsBorder = { fg = colors.blue, bg = colors.mantle },
          TelescopeResultsTitle = { fg = colors.blue, bg = colors.mantle },
          TelescopePreviewNormal = { bg = colors.mantle },
          TelescopePreviewBorder = { fg = colors.blue, bg = colors.mantle },
          TelescopePreviewTitle = { fg = colors.blue, bg = colors.mantle },
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
    
    -- Note: Theme switching keymap is handled by gruvbox.lua unified switcher
    -- This allows <leader>cc to work with both Catppuccin and Gruvbox themes
    
    -- Apply theming on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "catppuccin-*",
      callback = M.apply_ui_theming,
    })
    
    -- Initial theming application
    M.apply_ui_theming()
  end,
}

