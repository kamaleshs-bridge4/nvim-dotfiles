-- Gruvbox Dark Hard theme with consistent plugin theming
local M = {}

-- Color palette for gruvbox-dark-hard
local function get_palette()
  return {
    bg0 = "#1d2021",   -- Very dark, slightly warm grey (default background)
    bg1 = "#282828",   -- Slightly lighter background
    bg2 = "#3c3836",   -- Medium-dark grey (selection background)
    bg3 = "#504945",   -- Lighter medium-dark grey
    bg4 = "#665c54",   -- Even lighter grey
    fg0 = "#fbf1c7",   -- Bright white (default foreground)
    fg1 = "#a89984",   -- Light grey (white/color 7)
    fg2 = "#928374",   -- Medium grey (bright black/color 8)
    fg3 = "#1d2021",   -- Very dark grey (black/color 0)
    -- ANSI colors
    black = "#1d2021",
    red = "#cc241d",
    green = "#98971a",
    yellow = "#d79921",
    blue = "#458588",
    magenta = "#b16286",
    cyan = "#689d6a",
    white = "#a89984",
    -- Bright colors
    bright_black = "#928374",
    bright_red = "#fb4934",
    bright_green = "#b8bb26",
    bright_yellow = "#fabd2f",
    bright_blue = "#83a598",
    bright_magenta = "#d3869b",
    bright_cyan = "#8ec07c",
    bright_white = "#fbf1c7",
  }
end

-- Function to apply consistent theming to all UI components
function M.apply_ui_theming()
  local colors = get_palette()
  
  -- Telescope theming with solid backgrounds
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.bright_cyan, bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.bright_cyan, bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.bg2, fg = colors.fg0 })
  
  -- Sidekick theming
  vim.api.nvim_set_hl(0, "SidekickNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "SidekickBorder", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "SidekickTitle", { fg = colors.bright_cyan, bg = colors.bg1 })
  
  -- ToggleTerm theming
  vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = colors.bright_blue, bg = colors.bg1 })
  
  -- NvimTree theming
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = colors.bg2, bg = colors.bg0 })
  
  -- General floating window theming
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg1 })
  
  -- Enhanced cursor line
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg2 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.bright_yellow, bold = true })
  
  -- LSP reference highlighting
  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = colors.bg3 })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = colors.bg3 })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = colors.bg3, bold = true })
  
  -- Better matching brackets
  vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.bright_yellow, bg = colors.bg3, bold = true })
  
  -- Visual selection
  vim.api.nvim_set_hl(0, "Visual", { bg = colors.bg3, bold = true })
  
  -- Completion menu theming
  vim.api.nvim_set_hl(0, "CmpPmenu", { link = "Pmenu" })
  vim.api.nvim_set_hl(0, "CmpBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "CmpSel", { 
    bg = colors.bg3, 
    fg = colors.fg0, 
    bold = true 
  })
  
  -- DAP UI theming
  vim.api.nvim_set_hl(0, "DapUINormal", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = colors.bright_blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIVariable", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "DapUIValue", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "DapUIScope", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIThread", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIStoppedThread", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIFrameName", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUISource", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUILineNumber", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIWatchesValue", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIWatchesError", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { bg = colors.bg1 })
end

-- Function to switch to gruvbox-dark-hard theme
function M.switch_to_gruvbox_dark_hard()
  vim.cmd("colorscheme gruvbox-dark-hard")
  M.apply_ui_theming()
  vim.notify("Switched to Gruvbox Dark Hard", vim.log.levels.INFO, { title = "Theme" })
end

-- Store module in package.loaded for access from other modules
package.loaded["gruvbox-dark-hard"] = M
package.loaded["plugins.gruvbox-dark-hard"] = M  -- Keep backward compatibility

-- Set up autocmd for colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "gruvbox-dark-hard",
  callback = function()
    vim.defer_fn(function()
      local module = package.loaded["gruvbox-dark-hard"]
      if module and module.apply_ui_theming then
        module.apply_ui_theming()
      end
    end, 10)
  end,
})

-- Initial theming application (only if gruvbox-dark-hard is the current theme)
vim.defer_fn(function()
  if vim.g.colors_name and vim.g.colors_name == "gruvbox-dark-hard" then
    M.apply_ui_theming()
  end
end, 100)

return M
