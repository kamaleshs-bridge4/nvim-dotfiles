-- Gruvbox dark theme with consistent plugin theming
local M = {}

-- Function to apply consistent theming to all UI components
function M.apply_ui_theming()
  -- Get gruvbox colors using the gruvbox.nvim palette API
  local ok, palette = pcall(require, "gruvbox.palette")
  if not ok then
    -- Fallback to hardcoded gruvbox dark colors if palette API is not available
    palette = {
      get_palette = function()
        return {
          bg0 = "#282828",   -- dark0
          bg1 = "#3c3836",   -- dark1
          bg2 = "#504945",   -- dark2
          bg3 = "#665c54",   -- dark3
          bg4 = "#7c6f64",   -- dark4
          fg0 = "#fbf1c7",   -- light0
          fg1 = "#ebdbb2",   -- light1
          fg2 = "#d5c4a1",   -- light2
          fg3 = "#bdae93",   -- light3
          fg4 = "#a89984",   -- light4
          blue = "#83a598",
          aqua = "#8ec07c",
          green = "#b8bb26",
          yellow = "#fabd2f",
          orange = "#fe8019",
          red = "#fb4934",
          purple = "#d3869b",
        }
      end
    }
  end
  local colors = palette.get_palette()
  
  -- Gruvbox dark palette mapping
  -- bg0 = dark0, bg1 = dark1, bg2 = dark2, bg3 = dark3, bg4 = dark4
  -- fg0 = light0, fg1 = light1, fg2 = light2, fg3 = light3, fg4 = light4
  
  -- Telescope theming with solid backgrounds
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.aqua, bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.aqua, bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = colors.bg2, fg = colors.fg1 })
  
  -- Sidekick theming
  vim.api.nvim_set_hl(0, "SidekickNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "SidekickBorder", { fg = colors.blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "SidekickTitle", { fg = colors.aqua, bg = colors.bg1 })
  
  -- ToggleTerm theming
  vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = colors.blue, bg = colors.bg1 })
  
  -- NvimTree theming
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = colors.bg2, bg = colors.bg0 })
  
  -- General floating window theming
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.blue, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg1 })
  
  -- Enhanced cursor line
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg2 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.yellow, bold = true })
  
  -- LSP reference highlighting
  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = colors.bg3 })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = colors.bg3 })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = colors.bg3, bold = true })
  
  -- Better matching brackets
  vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.orange, bg = colors.bg3, bold = true })
  
  -- Visual selection
  vim.api.nvim_set_hl(0, "Visual", { bg = colors.bg3, bold = true })
  
  -- Completion menu theming
  vim.api.nvim_set_hl(0, "CmpPmenu", { link = "Pmenu" })
  vim.api.nvim_set_hl(0, "CmpBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "CmpSel", { 
    bg = colors.bg3, 
    fg = colors.fg1, 
    bold = true 
  })
  
  -- DAP UI theming
  vim.api.nvim_set_hl(0, "DapUINormal", { bg = colors.bg0 })
  vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = colors.blue, bg = colors.bg1 })
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

-- Function to switch to gruvbox dark theme
function M.switch_to_gruvbox()
  vim.cmd("colorscheme gruvbox")
  M.apply_ui_theming()
  vim.notify("Switched to Gruvbox dark", vim.log.levels.INFO, { title = "Theme" })
end

-- Unified theme switcher that works with Catppuccin, Gruvbox, and Gruvbox Dark Hard
function M.unified_theme_switch()
  local current_theme = vim.g.colors_name or ""
  
  if current_theme == "gruvbox-dark-hard" then
    -- If on gruvbox-dark-hard, cycle back to catppuccin latte (first variant)
    local catppuccin_module = package.loaded["plugins.catpuccin"]
    if catppuccin_module then
      -- Set current_index to latte (index 1, the first variant)
      catppuccin_module.current_index = 1
    end
    vim.cmd("colorscheme catppuccin-latte")
    -- Apply catppuccin theming
    if catppuccin_module and catppuccin_module.apply_ui_theming then
      catppuccin_module.apply_ui_theming()
    end
    vim.notify("Switched to Catppuccin latte", vim.log.levels.INFO, { title = "Theme" })
  elseif current_theme == "gruvbox" then
    -- If on gruvbox, switch to gruvbox-dark-hard
    local gruvbox_dark_hard_module = package.loaded["gruvbox-dark-hard"] or package.loaded["plugins.gruvbox-dark-hard"]
    if gruvbox_dark_hard_module and gruvbox_dark_hard_module.switch_to_gruvbox_dark_hard then
      gruvbox_dark_hard_module.switch_to_gruvbox_dark_hard()
    else
      vim.cmd("colorscheme gruvbox-dark-hard")
      vim.notify("Switched to Gruvbox Dark Hard", vim.log.levels.INFO, { title = "Theme" })
    end
  elseif current_theme:match("catppuccin") then
    -- If on catppuccin, check if we're on the last variant (mocha)
    -- If so, switch to gruvbox; otherwise cycle to next variant
    local catppuccin_module = package.loaded["plugins.catpuccin"]
    if catppuccin_module then
      local current_variant = catppuccin_module.variants[catppuccin_module.current_index]
      if current_variant == "mocha" then
        -- On last variant, switch to gruvbox
        M.switch_to_gruvbox()
      else
        -- Cycle to next catppuccin variant
        catppuccin_module.cycle_theme()
      end
    else
      -- Fallback: switch to gruvbox
      M.switch_to_gruvbox()
    end
  else
    -- If on neither, switch to gruvbox dark
    M.switch_to_gruvbox()
  end
end

-- Store module in package.loaded for access from other modules
package.loaded["plugins.gruvbox"] = M

return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox",
  priority = 1000,
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
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    
    -- Apply theming on colorscheme change
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "gruvbox*",
      callback = M.apply_ui_theming,
    })
    
    -- Initial theming application (only if gruvbox is the current theme)
    if vim.g.colors_name and vim.g.colors_name:match("gruvbox") then
      M.apply_ui_theming()
    end
    
    -- Set up unified theme switching keymap
    -- Use defer to ensure this runs after all plugins (including catppuccin) are loaded
    vim.defer_fn(function()
      -- Remove any existing binding first (in case catppuccin set it)
      -- Use pcall to safely handle the case where the keymap doesn't exist
      pcall(vim.keymap.del, "n", "<leader>cc")
      vim.keymap.set("n", "<leader>cc", M.unified_theme_switch, { desc = "Cycle themes (Catppuccin variants / Gruvbox / Gruvbox Dark Hard)" })
    end, 200)
  end,
}
