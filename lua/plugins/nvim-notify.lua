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
      
      -- Background color transparency
      background_colour = "#000000",
      
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
    
    -- Add custom highlight groups that work with transparent themes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Make notification backgrounds slightly transparent
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

