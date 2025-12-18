-- Neovide GUI Configuration
-- This file contains settings specific to Neovide GUI frontend
-- Settings are automatically applied when Neovim is running in Neovide

local M = {}

function M.setup()
  -- Check if running in Neovide
  if vim.g.neovide then
    -- ========================================================================
    -- FONT CONFIGURATION
    -- ========================================================================
    -- Set font family and size
    -- Common options: "FiraCode Nerd Font", "JetBrainsMono Nerd Font", "CascadiaCode Nerd Font"
    vim.g.neovide_font = "JetBrainsMono Nerd Font:h14"
    
    -- Font scaling (can be adjusted with Ctrl+Plus/Minus)
    vim.g.neovide_scale_factor = 1.0
    
    -- ========================================================================
    -- RENDERING & PERFORMANCE
    -- ========================================================================
    -- Enable/disable multigrid (better performance for large files)
    vim.g.neovide_multigrid = false
    
    -- Refresh rate (higher = smoother but more CPU/GPU usage)
    vim.g.neovide_refresh_rate = 60
    
    -- Idle refresh rate (when not actively editing)
    vim.g.neovide_refresh_rate_idle = 5
    
    -- Enable transparency
    vim.g.neovide_transparency = 0.95
    
    -- Background blur (macOS only, requires transparency < 1.0)
    vim.g.neovide_background_color = "#0f1117" .. string.format("%02x", math.floor(0.95 * 255))
    
    -- ========================================================================
    -- CURSOR ANIMATIONS
    -- ========================================================================
    -- Cursor animation length (in seconds) - faster cursor movement
    vim.g.neovide_cursor_animation_length = 0.05
    
    -- Cursor trail size (0 = disabled, higher = longer trail)
    -- Disabled to remove typing trail effects
    vim.g.neovide_cursor_trail_size = 0.0
    
    -- Cursor particle effects - disabled to remove typing animations
    vim.g.neovide_cursor_vfx_mode = ""
    -- Options: "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe", "" (disabled)
    
    -- Cursor particle opacity (not used when vfx_mode is disabled)
    vim.g.neovide_cursor_vfx_opacity = 200.0
    
    -- Cursor particle particle count (not used when vfx_mode is disabled)
    vim.g.neovide_cursor_vfx_particle_density = 7.0
    
    -- Cursor particle speed (not used when vfx_mode is disabled)
    vim.g.neovide_cursor_vfx_speed = 10.0
    
    -- ========================================================================
    -- INPUT & KEYBOARD
    -- ========================================================================
    -- Enable macOS input method (better IME support)
    vim.g.neovide_input_macos_alt_is_meta = true
    
    -- Use system clipboard (already set in init.lua, but ensure it works)
    vim.opt.clipboard = "unnamedplus"
    
    -- ========================================================================
    -- WINDOW & UI
    -- ========================================================================
    -- Remember window size and position
    vim.g.neovide_remember_window_size = true
    
    -- Hide mouse cursor when typing
    vim.g.neovide_hide_mouse_when_typing = true
    
    -- Enable floating window blur (macOS only)
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    
    -- ========================================================================
    -- CURSOR SETTINGS (Optimized for Neovide)
    -- ========================================================================
    -- Override cursor settings for smoother experience in Neovide
    vim.opt.guicursor = table.concat({
      "n-v-c:block-blinkwait700-blinkon400-blinkoff250",
      "i:ver25-blinkwait700-blinkon400-blinkoff250",
      "r:hor20-blinkwait700-blinkon400-blinkoff250"
    }, ",")
    
    -- ========================================================================
    -- PERFORMANCE OPTIMIZATIONS
    -- ========================================================================
    -- Reduce redraws for better performance
    vim.opt.lazyredraw = false -- Keep false for better responsiveness
    
    -- Enable smooth scrolling (Neovim 0.10+)
    if vim.fn.has('nvim-0.10') == 1 then
      vim.opt.smoothscroll = true
    end
    
    -- ========================================================================
    -- KEYMAPS FOR NEOVIDE-SPECIFIC FEATURES
    -- ========================================================================
    -- Font size adjustments (Ctrl+Plus/Minus work by default, but we can add custom)
    vim.keymap.set('n', '<C-=>', function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
    end, { desc = 'Increase font size' })
    
    vim.keymap.set('n', '<C-->', function()
      vim.g.neovide_scale_factor = math.max(0.5, vim.g.neovide_scale_factor - 0.1)
    end, { desc = 'Decrease font size' })
    
    vim.keymap.set('n', '<C-0>', function()
      vim.g.neovide_scale_factor = 1.0
    end, { desc = 'Reset font size' })
    
    -- Toggle cursor particle effects
    vim.keymap.set('n', '<leader>cp', function()
      if vim.g.neovide_cursor_vfx_mode == "" then
        vim.g.neovide_cursor_vfx_mode = "railgun"
        vim.notify("Cursor particles: ON", vim.log.levels.INFO)
      else
        vim.g.neovide_cursor_vfx_mode = ""
        vim.notify("Cursor particles: OFF", vim.log.levels.INFO)
      end
    end, { desc = 'Toggle cursor particles' })
    
    -- Toggle transparency
    vim.keymap.set('n', '<leader>ct', function()
      if vim.g.neovide_transparency == 1.0 then
        vim.g.neovide_transparency = 0.95
        vim.notify("Transparency: ON", vim.log.levels.INFO)
      else
        vim.g.neovide_transparency = 1.0
        vim.notify("Transparency: OFF", vim.log.levels.INFO)
      end
    end, { desc = 'Toggle transparency' })
    
    -- Notify user that Neovide config is loaded
    vim.notify("Neovide GUI configuration loaded", vim.log.levels.INFO)
  end
end

return M
