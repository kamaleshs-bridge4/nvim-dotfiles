-- Beautiful notification system with animations
return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  config = function()
    local notify = require("notify")
    
    notify.setup({
      -- Animation style (fade, slide, fade_in_slide_out, static)
      stages = "fade_in_slide_out",
      
      -- Timeout for notifications
      timeout = 3000,
      
      -- Background color (solid, matches theme)
      background_colour = "#1e1e2e", -- Catppuccin base color, will be overridden by theme
      
      -- Icons for notification levels
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
      
      -- Minimum width for notifications
      minimum_width = 50,
      
      -- Maximum width (percentage of window width)
      max_width = function()
        return math.floor(vim.o.columns * 0.6)
      end,
      
      -- Maximum height (percentage of window height)
      max_height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
      
      -- Position of notifications
      -- top_left, top_right, bottom_left, bottom_right
      -- Can also use custom positioning
      top_down = true,
      
      -- Enable FPS for animations
      fps = 60,
      
      -- Render function
      render = "compact", -- default, minimal, simple, compact
      
      -- Level for displaying notifications
      level = 2,
    })
    
    -- Override vim.notify with nvim-notify
    vim.notify = notify
    
    -- Add custom highlight groups that work with Catppuccin themes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        local colorscheme = vim.g.colors_name or ""
        if colorscheme:match("catppuccin") then
          local colors = require("catppuccin.palettes").get_palette()
          -- Use Catppuccin colors for notifications with solid backgrounds
          vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.red, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = colors.yellow, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.blue, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.green, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.lavender, bg = colors.mantle })
          
          vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = colors.red, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = colors.yellow, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = colors.blue, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = colors.green, bg = colors.mantle })
          vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = colors.lavender, bg = colors.mantle })
          
          -- Set notification body background
          vim.api.nvim_set_hl(0, "NotifyBackground", { bg = colors.mantle })
          
          -- Update background color for notifications dynamically
          notify.setup({ background_colour = colors.mantle })
        else
          -- Fallback colors for other themes
          vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#fb4934" })
          vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#fabd2f" })
          vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#83a598" })
          vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#8ec07c" })
          vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#d3869b" })
          
          vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#fb4934" })
          vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#fabd2f" })
          vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#83a598" })
          vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#8ec07c" })
          vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#d3869b" })
        end
      end,
    })
    
    -- Keymaps for notification management
    vim.keymap.set('n', '<leader>nd', function() 
      notify.dismiss({ silent = true, pending = true }) 
    end, { desc = 'Dismiss all Notifications' })
    
    -- Show notification history
    vim.keymap.set('n', '<leader>nh', function() 
      require("telescope").extensions.notify.notify()
    end, { desc = 'Notification History' })
  end,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
}

