-- Theme configuration with Gruvbox and Catppuccin
-- Provides theme switching functionality

-- Theme switcher state (stored in global table for persistence)
if not _G.theme_switcher_state then
  _G.theme_switcher_state = {
    current_theme = "gruvbox",
    current_catppuccin_variant = "mocha",
    themes = {
      gruvbox = "gruvbox",
      catppuccin = "catppuccin",
    },
    catppuccin_variants = {
      "latte",
      "frappe",
      "macchiato",
      "mocha",
    },
  }
end

local state = _G.theme_switcher_state

-- Theme switcher functions
local function switch_theme(theme)
  if theme == state.themes.gruvbox then
    local success = pcall(vim.cmd, "colorscheme gruvbox")
    if success then
      state.current_theme = state.themes.gruvbox
      vim.notify("Theme: Gruvbox", vim.log.levels.INFO, { title = "Theme Switcher" })
    else
      vim.notify("Failed to load Gruvbox theme", vim.log.levels.ERROR, { title = "Theme Switcher" })
    end
  elseif theme == state.themes.catppuccin then
    -- Update Catppuccin flavour if needed
    local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
    if catppuccin_ok and catppuccin then
      catppuccin.setup({ flavour = state.current_catppuccin_variant })
      local success = pcall(vim.cmd, "colorscheme catppuccin")
      if success then
        state.current_theme = state.themes.catppuccin
        vim.notify("Theme: Catppuccin (" .. state.current_catppuccin_variant .. ")", vim.log.levels.INFO, { title = "Theme Switcher" })
      else
        vim.notify("Failed to load Catppuccin theme", vim.log.levels.ERROR, { title = "Theme Switcher" })
      end
    else
      vim.notify("Catppuccin plugin not available", vim.log.levels.ERROR, { title = "Theme Switcher" })
    end
  end
end

local function toggle_theme()
  if state.current_theme == state.themes.gruvbox then
    switch_theme(state.themes.catppuccin)
  else
    switch_theme(state.themes.gruvbox)
  end
end

local function cycle_catppuccin_variant()
  local current_index = 1
  for i, variant in ipairs(state.catppuccin_variants) do
    if variant == state.current_catppuccin_variant then
      current_index = i
      break
    end
  end
  
  local next_index = (current_index % #state.catppuccin_variants) + 1
  state.current_catppuccin_variant = state.catppuccin_variants[next_index]
  
  if state.current_theme == state.themes.catppuccin then
    switch_theme(state.themes.catppuccin)
  else
    vim.notify("Catppuccin variant set to: " .. state.current_catppuccin_variant, vim.log.levels.INFO, { title = "Theme Switcher" })
  end
end

-- Make functions globally available
_G.theme_switcher = {
  switch = switch_theme,
  toggle = toggle_theme,
  cycle_variant = cycle_catppuccin_variant,
  state = state,
}

return {
  -- Gruvbox theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Load early to set colorscheme
    config = function()
      local gruvbox_ok, gruvbox = pcall(require, "gruvbox")
      if not gruvbox_ok then
        vim.notify("Failed to load Gruvbox plugin", vim.log.levels.ERROR)
        return
      end
      
      gruvbox.setup({
        contrast = "hard",
        terminal_colors = true,
        transparent_mode = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        palette_overrides = {
          bg = "#181a1b",
          fg = "#fbf1c7",
          dark0 = "#181a1b",
          dark1 = "#282828",
          dark2 = "#32302f",
          dark3 = "#3c3836",
          dark4 = "#504945",
          light0 = "#fbf1c7",
          light1 = "#ebdbb2",
          light2 = "#d5c4a1",
          light3 = "#bdae93",
          light4 = "#a89984",
          bright_red = "#fb4934",
          bright_green = "#b8bb26",
          bright_yellow = "#fabd2f",
          bright_blue = "#83a598",
          bright_purple = "#d3869b",
          bright_aqua = "#8ec07c",
          bright_orange = "#fe8019",
          neutral_red = "#cc241d",
          neutral_green = "#98971a",
          neutral_yellow = "#d79921",
          neutral_blue = "#458588",
          neutral_purple = "#b16286",
          neutral_aqua = "#689d6a",
          neutral_orange = "#d65d0e",
          faded_red = "#9d0006",
          faded_green = "#79740e",
          faded_yellow = "#b57614",
          faded_blue = "#076678",
          faded_purple = "#8f3f71",
          faded_aqua = "#427b58",
          faded_orange = "#af3a03",
        },
        overrides = {
          Pmenu = { link = "Normal" },
        },
      })
    end,
  },
  
  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load early to set colorscheme
    config = function()
      local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
      if not catppuccin_ok then
        vim.notify("Failed to load Catppuccin plugin", vim.log.levels.ERROR)
        return
      end
      
      catppuccin.setup({
        flavour = state.current_catppuccin_variant, -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = {},
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          telescope = {
            enabled = true,
          },
          lsp_trouble = true,
          which_key = true,
        },
      })
      
      -- Setup theme switcher after Catppuccin is configured
      vim.schedule(function()
        -- Set default theme (only if not already set)
        if not vim.g.colors_name or vim.g.colors_name == "" then
          pcall(vim.cmd, "colorscheme gruvbox")
        end
        
        -- Setup keybindings and commands (only if not already set up)
        if not _G.theme_switcher_keymaps_setup then
          -- Keybindings for theme switching
          vim.keymap.set("n", "<leader>tt", function()
            _G.theme_switcher.toggle()
          end, { desc = "Toggle theme (Gruvbox/Catppuccin)" })
          
          vim.keymap.set("n", "<leader>tg", function()
            _G.theme_switcher.switch(_G.theme_switcher.state.themes.gruvbox)
          end, { desc = "Switch to Gruvbox" })
          
          vim.keymap.set("n", "<leader>tc", function()
            _G.theme_switcher.switch(_G.theme_switcher.state.themes.catppuccin)
          end, { desc = "Switch to Catppuccin" })
          
          vim.keymap.set("n", "<leader>tv", function()
            _G.theme_switcher.cycle_variant()
          end, { desc = "Cycle Catppuccin variant" })
          
          -- Commands for theme switching
          vim.api.nvim_create_user_command("ThemeToggle", function()
            _G.theme_switcher.toggle()
          end, { desc = "Toggle between Gruvbox and Catppuccin" })
          
          vim.api.nvim_create_user_command("ThemeGruvbox", function()
            _G.theme_switcher.switch(_G.theme_switcher.state.themes.gruvbox)
          end, { desc = "Switch to Gruvbox theme" })
          
          vim.api.nvim_create_user_command("ThemeCatppuccin", function()
            _G.theme_switcher.switch(_G.theme_switcher.state.themes.catppuccin)
          end, { desc = "Switch to Catppuccin theme" })
          
          vim.api.nvim_create_user_command("ThemeVariant", function()
            _G.theme_switcher.cycle_variant()
          end, { desc = "Cycle through Catppuccin variants" })
          
          _G.theme_switcher_keymaps_setup = true
        end
      end)
    end,
  },
}
