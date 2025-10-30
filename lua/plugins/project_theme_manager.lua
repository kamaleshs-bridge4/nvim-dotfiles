-- Add this as a new item in your lazy.nvim plugins list.
return {
  dir = vim.fn.stdpath("config"),
  name = "project-theme-manager",
  event = "VimEnter",
  config = function()
    -- 1. Define your project-to-theme mappings (only Catppuccin variants)
    local project_themes = {
      ["nvim"] = "catppuccin-mocha",
      ["booking_service"] = "catppuccin-macchiato",
      ["foundation"] = "catppuccin-mocha",
      ["goutils"] = "catppuccin-mocha",
      ["rewards-catalogue"] = "catppuccin-mocha",
    }
    
    -- 2. Define your default theme (Catppuccin mocha)
    local default_theme = "catppuccin-mocha"
    
    -- 3. Function to setup completion menu highlights
    local function setup_cmp_highlights()
      -- Define custom highlight groups for nvim-cmp
      -- These will work with any colorscheme
      
      -- CmpPmenu: The main completion menu background
      vim.api.nvim_set_hl(0, 'CmpPmenu', { link = 'Pmenu' })
      
      -- CmpBorder: The border of the completion window
      vim.api.nvim_set_hl(0, 'CmpBorder', { link = 'FloatBorder' })
      
      -- CmpSel: The SELECTED item in the completion menu (this is the key one!)
      -- Use Catppuccin colors dynamically based on current theme
      local colorscheme = vim.g.colors_name or ""
      if colorscheme:match("catppuccin") then
        if colorscheme:match("mocha") then
          vim.api.nvim_set_hl(0, 'CmpSel', {
            bg = '#45475a',  -- Catppuccin mocha surface1
            fg = '#cdd6f4',  -- Catppuccin mocha text
            bold = true
          })
        elseif colorscheme:match("macchiato") then
          vim.api.nvim_set_hl(0, 'CmpSel', {
            bg = '#494d64',  -- Catppuccin macchiato surface1
            fg = '#cad3f5',  -- Catppuccin macchiato text
            bold = true
          })
        elseif colorscheme:match("frappe") then
          vim.api.nvim_set_hl(0, 'CmpSel', {
            bg = '#414559',  -- Catppuccin frappe surface1
            fg = '#c6d0f5',  -- Catppuccin frappe text
            bold = true
          })
        elseif colorscheme:match("latte") then
          vim.api.nvim_set_hl(0, 'CmpSel', {
            bg = '#e6e9ef',  -- Catppuccin latte surface1
            fg = '#4c4f69',  -- Catppuccin latte text
            bold = true
          })
        end
      else
        -- Fallback for other themes
        vim.api.nvim_set_hl(0, 'CmpSel', { 
          bg = '#504945',  -- Default dark color
          fg = '#fbf1c7',  -- Default light color
          bold = true 
        })
      end
    end
    
    -- 4. Function to get project root and apply theme
    local function apply_project_theme()
      local git_dir = vim.fs.find(".git", {
        upward = true,
        path = vim.fn.getcwd(),
      })[1]
      
      local theme_to_load = default_theme
      if git_dir then
        local project_path = vim.fn.fnamemodify(git_dir, ":h")
        local project_name = vim.fn.fnamemodify(project_path, ":t")
        if project_themes[project_name] then
          theme_to_load = project_themes[project_name]
        end
      end
      
      -- Load the chosen colorscheme
      local success, msg = pcall(vim.cmd.colorscheme, theme_to_load)
      if not success then
        print("Error loading colorscheme '" .. theme_to_load .. "': " .. msg)
        if theme_to_load ~= default_theme then
          pcall(vim.cmd.colorscheme, default_theme)
        end
      end
      
      -- Apply completion menu highlights after loading the theme
      setup_cmp_highlights()
    end
    
    -- 5. Run the function to set the theme on startup
    apply_project_theme()
    
    -- 6. Re-run when changing directories
    vim.api.nvim_create_autocmd("DirChanged", {
      pattern = "*",
      callback = apply_project_theme,
    })
    
    -- 7. Also re-apply highlights when colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = setup_cmp_highlights,
    })
  end,
}
