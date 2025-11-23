-- Add this as a new item in your lazy.nvim plugins list.
return {
  dir = vim.fn.stdpath("config"),
  name = "project-theme-manager",
  event = "VimEnter",
  config = function()
    -- 1. Define your project-to-theme mappings (Catppuccin variants and Gruvbox)
    local project_themes = {
    }
    
    -- 2. Define your default theme (Catppuccin mocha)
    local default_theme = "gruvbox-dark-hard"
    
    -- 3. Function to setup completion menu highlights
    local function setup_cmp_highlights()
      -- Define custom highlight groups for nvim-cmp
      -- These will work with any colorscheme
      
      -- CmpPmenu: The main completion menu background
      vim.api.nvim_set_hl(0, 'CmpPmenu', { link = 'Pmenu' })
      
      -- CmpBorder: The border of the completion window
      vim.api.nvim_set_hl(0, 'CmpBorder', { link = 'FloatBorder' })
      
      -- CmpSel: The SELECTED item in the completion menu (this is the key one!)
      -- Use theme colors dynamically based on current theme
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
      elseif colorscheme == "gruvbox-dark-hard" then
        -- Gruvbox dark hard colors
        vim.api.nvim_set_hl(0, 'CmpSel', {
          bg = '#504945',  -- Gruvbox dark hard bg3
          fg = '#fbf1c7',  -- Gruvbox dark hard fg0 (bright white)
          bold = true
        })
        -- Apply gruvbox-dark-hard theming if module is available
        local gruvbox_dark_hard_module = package.loaded["gruvbox-dark-hard"] or package.loaded["plugins.gruvbox-dark-hard"]
        if gruvbox_dark_hard_module and gruvbox_dark_hard_module.apply_ui_theming then
          gruvbox_dark_hard_module.apply_ui_theming()
        end
      elseif colorscheme:match("gruvbox") then
        -- Gruvbox dark colors
        vim.api.nvim_set_hl(0, 'CmpSel', {
          bg = '#665c54',  -- Gruvbox bg3 (dark3)
          fg = '#ebdbb2',  -- Gruvbox fg1 (light1)
          bold = true
        })
        -- Apply gruvbox theming if gruvbox module is available
        local gruvbox_module = package.loaded["plugins.gruvbox"]
        if gruvbox_module and gruvbox_module.apply_ui_theming then
          gruvbox_module.apply_ui_theming()
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
      
      -- Apply gruvbox theming if gruvbox is loaded
      if theme_to_load == "gruvbox-dark-hard" then
        -- Use a small delay to ensure gruvbox-dark-hard module is loaded
        vim.defer_fn(function()
          -- Try to require the module if not already loaded
          if not package.loaded["gruvbox-dark-hard"] then
            pcall(require, "gruvbox-dark-hard")
          end
          local gruvbox_dark_hard_module = package.loaded["gruvbox-dark-hard"] or package.loaded["plugins.gruvbox-dark-hard"]
          if gruvbox_dark_hard_module and gruvbox_dark_hard_module.apply_ui_theming then
            gruvbox_dark_hard_module.apply_ui_theming()
          end
        end, 100)
      elseif theme_to_load:match("gruvbox") then
        -- Use a small delay to ensure gruvbox module is loaded
        vim.defer_fn(function()
          local gruvbox_module = package.loaded["plugins.gruvbox"]
          if gruvbox_module and gruvbox_module.apply_ui_theming then
            gruvbox_module.apply_ui_theming()
          end
        end, 100)
      end
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
